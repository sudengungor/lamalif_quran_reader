import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quran_reader/src/domain/model/book.dart';
import 'package:quran_reader/src/domain/model/drawer_component.dart';
import 'package:quran_reader/src/domain/service/book_read_preferences.dart';
import 'package:quran_reader/src/domain/service/book_read_repository.dart';
import 'package:quran_reader/src/l10n/generated/quran_reader_localizations.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/color/color_option.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/color/reading_theme_manager.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class BookReadProvider extends ChangeNotifier {
  BookReadProvider({
    required BookReadRepository repository,
    required BookReadPreferences preferences,
  }) : _bookReadRepository = repository,
       _bookPreferences = preferences;

  final BookReadRepository _bookReadRepository;
  final BookReadPreferences _bookPreferences;

  late ItemScrollController? itemScrollController;
  late ItemPositionsListener? itemPositionsListener;

  bool isLoading = false;
  late Book selectedBook;
  List<Section> fihristSections = [];
  List<Section> fihristCuzSections = [];
  String? errorMessage;

  int? bookFileLength;
  int? bookPageLength;
  int currentPage = 0;
  Future<List<String>>? bookDataFuture;

  List<int> itemPageNumbers = [];
  Map<int, int> surahItemIndexMap = {};
  Map<String, int> specialSectionItemIndexMap = {};
  Map<String, int> hizbItemIndexMap = {};

  int get currentPhysicalPage {
    if (itemPageNumbers.isEmpty || currentPage >= itemPageNumbers.length) {
      return currentPage + selectedBook.firstPage;
    }
    return itemPageNumbers[currentPage];
  }

  int get minPhysicalPage {
    if (itemPageNumbers.isNotEmpty) return itemPageNumbers.first;
    return selectedBook.firstPage;
  }

  int get maxPhysicalPage {
    return bookPageLength ?? selectedBook.firstPage;
  }

  /// Fiziksel Mushaf sayfa numarasına gider.
  void goToPhysicalPage(int pageNumber) {
    final pageNums = itemPageNumbers;
    int targetIndex;

    if (pageNums.isNotEmpty) {
      final idx = pageNums.indexOf(pageNumber);
      if (idx != -1) {
        targetIndex = idx;
      } else {
        // Sayfa listede yoksa en yakın önceki sayfayı bul.
        targetIndex = 0;
        for (var i = 0; i < pageNums.length; i++) {
          if (pageNums[i] <= pageNumber) {
            targetIndex = i;
          } else {
            break;
          }
        }
      }
    } else {
      final length = bookFileLength ?? 1;
      targetIndex = (pageNumber - selectedBook.firstPage).clamp(0, length - 1);
    }

    currentPage = targetIndex;
    setSavePage(targetIndex.toDouble());
    itemScrollController?.jumpTo(index: targetIndex);
    _safeNotifyListeners();
  }

  void _safeNotifyListeners() {
    if (WidgetsBinding.instance.schedulerPhase != SchedulerPhase.idle) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } else {
      notifyListeners();
    }
  }

  void _toggleLoading(bool value) {
    isLoading = value;
    _safeNotifyListeners();
  }

  @override
  void dispose() {
    currentPage = 0;
    errorMessage = null;
    super.dispose();
  }

  Future<void> init([String? fileName]) async {
    try {
      final resolvedFileName =
          fileName ??
          (_bookPreferences.getMealEnabled() ? 'kuran_meal' : 'kuran');
      selectedBook = Book(
        fileName: resolvedFileName,
        lastPage: _bookPreferences.getLastPage(),
        firstPage: 0,
      );
      itemScrollController = ItemScrollController();
      itemPositionsListener = ItemPositionsListener.create();

      itemPositionsListener!.itemPositions.addListener(() async {
        final position = _primaryVisiblePosition(
          itemPositionsListener!.itemPositions.value,
        );
        if (position == null) return;
        currentPage = position.index;
        await saveAlignment(position.itemLeadingEdge);
        await setSavePage(currentPage.toDouble());
        _safeNotifyListeners();
      });
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<void> getFihristSections() async {
    try {
      _toggleLoading(true);
      fihristSections = await _bookReadRepository.getFihristData(selectedBook);
      fihristCuzSections = await _bookReadRepository.getFihristCuzData(
        selectedBook,
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _toggleLoading(false);
    }
  }

  void loadBookData() {
    bookDataFuture = _fetchBookData();
    _safeNotifyListeners();
  }

  Future<List<String>> _fetchBookData() async {
    try {
      _toggleLoading(true);

      final bookData = await _bookReadRepository.getBookData(selectedBook);
      itemPageNumbers = bookData.pageNumbers;
      bookFileLength = bookData.items.length;
      bookPageLength = itemPageNumbers.isNotEmpty
          ? itemPageNumbers.last
          : bookData.items.length - 1;

      _buildItemIndexMaps(bookData.items);
      await getFihristSections();
      return bookData.items;
    } catch (e) {
      errorMessage = e.toString();
      return [];
    } finally {
      _toggleLoading(false);
    }
  }

  void _buildItemIndexMaps(List<String> items) {
    surahItemIndexMap = {};
    specialSectionItemIndexMap = {};
    hizbItemIndexMap = {};

    final surahPattern = RegExp(r'^\d+\n<(\d+)-');
    final surahPatternAtStart = RegExp(r'^<(\d+)-');
    final specialSectionPattern = RegExp(r'^\d+\n<([^>\d][^>]*)>');
    final hizbPattern = RegExp(r'^\d+\n~«حزب ([١٢٣٤])»');

    for (int i = 0; i < items.length; i++) {
      final surahMatch =
          surahPattern.firstMatch(items[i]) ??
          surahPatternAtStart.firstMatch(items[i]);
      if (surahMatch != null) {
        final surahNum = int.tryParse(surahMatch.group(1)!);
        if (surahNum != null && !surahItemIndexMap.containsKey(surahNum)) {
          surahItemIndexMap[surahNum] = i;
        }
        continue;
      }

      final specialMatch = specialSectionPattern.firstMatch(items[i]);
      if (specialMatch != null) {
        final title = specialMatch.group(1)!.trim();
        specialSectionItemIndexMap.putIfAbsent(title, () => i);
        continue;
      }

      final hizbMatch = hizbPattern.firstMatch(items[i]);
      if (hizbMatch != null) {
        final hizbNum = hizbMatch.group(1)!.codeUnitAt(0) - 0x0660;
        if (hizbNum > 0 && i < itemPageNumbers.length) {
          final key = '${itemPageNumbers[i]}_$hizbNum';
          hizbItemIndexMap[key] = i;
        }
      }
    }
  }

  void onTabSlider(double value) {
    final targetIndex = (value * (bookFileLength! - 1)).round().clamp(
      0,
      bookFileLength! - 1,
    );

    setSavePage(targetIndex.toDouble());
    itemScrollController?.jumpTo(index: targetIndex);

    _safeNotifyListeners();
  }

  Future<void> setSavePage(double page) async {
    await _bookPreferences.setLastPage(page);
    selectedBook.lastPage = page;
  }

  void reloadSavedPosition() {
    final savedPage = _bookPreferences.getLastPage();
    selectedBook.lastPage = savedPage;
    currentPage = savedPage.toInt();
  }

  ItemPosition? _primaryVisiblePosition(Iterable<ItemPosition> positions) {
    if (positions.isEmpty) return null;
    return positions.reduce(
      (best, pos) => pos.itemLeadingEdge < best.itemLeadingEdge ? pos : best,
    );
  }

  Future<void> saveCurrentReadingPosition() async {
    if (bookFileLength == null) return;

    final position = _primaryVisiblePosition(
      itemPositionsListener?.itemPositions.value ?? [],
    );
    if (position != null) {
      currentPage = position.index;
      await saveAlignment(position.itemLeadingEdge);
    }

    await setSavePage(currentPage.toDouble());
  }

  Future<void> saveAlignment(double value) async {
    await _bookPreferences.setAlignment(value);
  }

  double getAlignment() => _bookPreferences.getAlignment();

  Future<void> saveFontScale(double value) async {
    await _bookPreferences.setFontScale(value);
  }

  double getFontScale() => _bookPreferences.getFontScale();

  String getCurrentPage() {
    return currentPhysicalPage.toString();
  }

  String getCurrentPageForNavigation() {
    return currentPhysicalPage.toString();
  }

  String getCurrentSurahTitle(QuranReaderLocalizations l10n) {
    if (fihristSections.isEmpty) return '';
    return _findActiveSureTitleByItemIndex(currentPage, l10n.localeName);
  }

  String getAppBarSubtitle(QuranReaderLocalizations l10n) {
    if (fihristCuzSections.isEmpty) return '';

    final page = currentPhysicalPage;
    final activeCuz = _findActiveSection(fihristCuzSections, page);
    final cuzNumber = activeCuz?.title.replaceAll(RegExp(r'[^0-9]'), '');

    if (cuzNumber == null || cuzNumber.isEmpty) {
      return l10n.bookPageShort('$page');
    }
    return l10n.bookAppBarSubtitle(cuzNumber, '$page');
  }

  String getCurrentLocationInfo(QuranReaderLocalizations l10n) {
    if (fihristSections.isEmpty || fihristCuzSections.isEmpty) return '';

    final page = currentPhysicalPage;
    final surahTitle = _findActiveSureTitleByItemIndex(
      currentPage,
      l10n.localeName,
    );
    final activeCuz = _findActiveSection(fihristCuzSections, page);
    final cuzLabel = _formatIndexedLabel(
      activeCuz?.title,
      l10n.bookFihristCuzTab,
    );

    if (surahTitle.isEmpty || cuzLabel == null) return '';

    final activeHizb = activeCuz != null
        ? _findActiveHizbByItemIndex(activeCuz.children, currentPage)
        : null;
    final hizbLabel = _formatIndexedLabel(
      activeHizb?.title,
      l10n.bookFihristHizb,
    );

    return hizbLabel != null
        ? '$surahTitle - $cuzLabel / $hizbLabel'
        : '$surahTitle - $cuzLabel';
  }

  Section? _findActiveHizbByItemIndex(
    List<Section> hizbChildren,
    int currentItemIndex,
  ) {
    Section? best;
    int bestItemIndex = -1;

    for (final hizb in hizbChildren) {
      final hizbNum = _extractHizbNumber(hizb.title);
      if (hizbNum == null) continue;
      final itemIdx = hizbItemIndexMap['${hizb.page}_$hizbNum'];
      if (itemIdx == null) continue;
      if (itemIdx <= currentItemIndex && itemIdx > bestItemIndex) {
        bestItemIndex = itemIdx;
        best = hizb;
      }
    }
    return best;
  }

  int? _extractHizbNumber(String title) {
    final match = RegExp(r'Hizb-(\d+)').firstMatch(title);
    return int.tryParse(match?.group(1) ?? '');
  }

  Section? _findActiveSection(List<Section> sections, int page) {
    Section? lastBefore;
    for (final section in sections) {
      if (section.page == page) return section;
      if (section.page < page) {
        lastBefore = section;
      } else {
        break;
      }
    }
    return lastBefore;
  }

  String _findActiveSureTitleByItemIndex(
    int currentItemIndex,
    String localeName,
  ) {
    String? bestTitle;
    int bestItemIndex = -1;

    for (final section in fihristSections) {
      final surahNum = _extractSurahNumberFromTitle(section.title);
      final int? itemIdx;
      if (surahNum != null) {
        itemIdx = surahItemIndexMap[surahNum];
      } else {
        itemIdx =
            specialSectionItemIndexMap[section.title.split('@').first.trim()];
      }
      if (itemIdx == null) continue;

      if (itemIdx <= currentItemIndex && itemIdx > bestItemIndex) {
        bestItemIndex = itemIdx;
        bestTitle = section.title;
      }
    }

    return bestTitle != null
        ? _localizedSureName(bestTitle, localeName)
        : '';
  }

  int? _extractSurahNumberFromTitle(String title) {
    final match = RegExp(r'^(\d+)\.').firstMatch(title);
    return int.tryParse(match?.group(1) ?? '');
  }

  String _localizedSureName(String title, String localeName) {
    final parts = title.split('@');
    final isTurkish = localeName.toLowerCase().startsWith('tr');
    final name = (parts.length > 1 && !isTurkish ? parts[1] : parts[0]).trim();
    return name.replaceFirst(RegExp(r'^\d+\.\s*'), '');
  }

  /// Kur'an metnindeki `<1-Fâtiha>` başlığını dile göre gösterir.
  String localizedInlineSureName(String raw, String localeName) {
    if (localeName.toLowerCase().startsWith('tr')) return raw;

    final numberMatch = RegExp(r'^(\d+)-').firstMatch(raw);
    if (numberMatch != null) {
      final surahNum = int.tryParse(numberMatch.group(1)!);
      for (final section in fihristSections) {
        if (_extractSurahNumberFromTitle(section.title) == surahNum) {
          return '$surahNum-${_localizedSureName(section.title, localeName)}';
        }
      }
      return raw;
    }

    for (final section in fihristSections) {
      if (section.title.split('@').first.trim() == raw.trim()) {
        return _localizedSureName(section.title, localeName);
      }
    }
    return raw;
  }

  String? _formatIndexedLabel(String? rawTitle, String suffix) {
    if (rawTitle == null) return null;
    final number = rawTitle.replaceAll(RegExp(r'[^0-9]'), '');
    return number.isEmpty ? rawTitle : '$number. $suffix';
  }

  void decreaseFontSize() {
    if (getFontScale() <= 1.1) {
      return;
    }

    saveFontScale(getFontScale() - 0.05);
  }

  void increaseFontSize() {
    if (getFontScale() >= 2.5) {
      return;
    }

    saveFontScale(getFontScale() + 0.05);
  }

  Future<void> saveLineSpacing(double value) async {
    await _bookPreferences.setLineSpacing(value);
  }

  double getLineSpacing() => _bookPreferences.getLineSpacing();

  Future<void> saveTextAlignment(TextAlign alignment) async {
    await _bookPreferences.setTextAlignment(alignment.index);
  }

  TextAlign getTextAlignment() => TextAlign.values.firstWhere(
    (align) => align.index == _bookPreferences.getTextAlignment(),
  );

  Future<void> saveTextColor(Color color) async {
    await _bookPreferences.setTextColor(color.toARGB32());
    _safeNotifyListeners();
  }

  Color getTextColor() => Color(_bookPreferences.getTextColor());

  Future<void> saveBackgroundColor(Color color) async {
    await _bookPreferences.setBackgroundColor(color.toARGB32());
    _safeNotifyListeners();
  }

  Color getBackgroundColor() => Color(_bookPreferences.getBackgroundColor());

  ColorOption get bgOption {
  final bgColor = getBackgroundColor();

  return ReadingThemeManager.backgroundPalettes.firstWhere(
    (option) => option.color.toARGB32() == bgColor.toARGB32(),

    // Kullanıcının daha eski bir sürümden kalmış rengi varsa
    // ekran çökmek yerine ilk güvenli arka planı kullanır.
    orElse: () => ReadingThemeManager.backgroundPalettes.first,
  );
}

  List<Color> getAvailableTextColors() {
    final colorOption = bgOption.getAvailableColorsBy(
      ReadingThemeManager.textPalettes,
    );
    return colorOption.map((option) => option.color).toList();
  }

  Color getVerseNumberColor() {
    final colorOption = bgOption.getAvailableColorBy(
      ReadingThemeManager.verseNumberPalettes,
    );
    return colorOption.color;
  }

  Color getIconColor() {
    final colorOption = bgOption.getAvailableColorBy(
      ReadingThemeManager.uiPalettes,
    );
    return colorOption.color;
  }

  Future<void> savePadding(double value) async {
    await _bookPreferences.setPadding(value);
  }

  double getPadding() => _bookPreferences.getPadding();

  bool getMealEnabled() => _bookPreferences.getMealEnabled();

  Future<void> toggleMeal() async {
    final newValue = !_bookPreferences.getMealEnabled();
    await _bookPreferences.setMealEnabled(newValue);
    final fileName = newValue ? 'kuran_meal' : 'kuran';
    await init(fileName);
    loadBookData();
  }
}
