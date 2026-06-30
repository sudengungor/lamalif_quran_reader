import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/core/utils/string_normalizer.dart';
import 'package:quran_reader/src/domain/model/drawer_component.dart';
import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';
import 'package:quran_reader/src/presentation/provider/section_provider.dart';
import 'package:quran_reader/src/presentation/widgets/fihrist_sections/section_list_item.dart';

/// Drawer içindeki bölüm listesini, otomatik scroll ve aktif bölüm
/// vurgulamasıyla birlikte yöneten widget.
///
/// [type] parametresine göre Sure veya Cüz fihristini gösterir.
/// Her tab instance'ı kendi scroll controller ve key haritasını yönetir;
/// bu sayede sekmeler arasında geçişte scroll pozisyonu korunur.
class DrawerSectionListView extends StatefulWidget {
  final FihristType type;
  final bool isActiveTab;
  final String searchQuery;

  const DrawerSectionListView({
    super.key,
    required this.type,
    required this.isActiveTab,
    this.searchQuery = '',
  });

  @override
  State<DrawerSectionListView> createState() => _DrawerSectionListViewState();
}

class _DrawerSectionListViewState extends State<DrawerSectionListView>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;
  final Map<int, GlobalKey> _sectionKeys = {};
  int? _activeIndex;
  int? _lastSyncedPage;
  bool _syncOnActivate = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DrawerSectionListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActiveTab && !oldWidget.isActiveTab) {
      _syncOnActivate = true;
    }
  }

  int _currentPageFor(BookReadProvider bookReadProvider) {
    return widget.type == FihristType.sure
        ? bookReadProvider.currentPage
        : bookReadProvider.currentPhysicalPage;
  }

  void _scrollToActiveSection() {
    if (_activeIndex == null) return;

    _sectionKeys[_activeIndex!] ??= GlobalKey();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _sectionKeys[_activeIndex]?.currentContext;
      if (ctx == null) return;

      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) return;

      try {
        final offset = box.localToGlobal(Offset.zero);
        final screenHeight = MediaQuery.sizeOf(ctx).height;
        final itemHeight = box.size.height;

        final targetScroll =
            _scrollController.offset +
            offset.dy -
            (screenHeight / 2) +
            (itemHeight / 2);

        final maxScroll = _scrollController.position.maxScrollExtent;
        final minScroll = _scrollController.position.minScrollExtent;

        _scrollController.jumpTo(targetScroll.clamp(minScroll, maxScroll));
      } catch (e) {
        log('DrawerSectionListView scroll error: $e');
      }
    });
  }

  void _updateActiveSection(
    List<Section> sections,
    BookReadProvider bookReadProvider,
  ) {
    _activeIndex = null;

    if (widget.type == FihristType.sure) {
      _updateActiveSureSection(sections, bookReadProvider);
    } else {
      _updateActiveCuzSection(sections, bookReadProvider.currentPhysicalPage);
    }
  }

  void _updateActiveSureSection(
    List<Section> sections,
    BookReadProvider bookReadProvider,
  ) {
    final currentItemIndex = bookReadProvider.currentPage;
    final indexMap = bookReadProvider.surahItemIndexMap;

    int? bestFihristIndex;
    int bestItemIndex = -1;

    for (int i = 0; i < sections.length; i++) {
      final surahNum = _extractSurahNumber(sections[i].title);
      if (surahNum == null) continue;
      final itemIdx = indexMap[surahNum];
      if (itemIdx == null) continue;

      if (itemIdx <= currentItemIndex && itemIdx > bestItemIndex) {
        bestItemIndex = itemIdx;
        bestFihristIndex = i;
      }
    }

    _activeIndex = bestFihristIndex;
  }

  void _updateActiveCuzSection(List<Section> sections, int physicalPage) {
    for (int i = 0; i < sections.length; i++) {
      final section = sections[i];
      if (section.page == physicalPage) {
        _activeIndex = i;
        return;
      }
      if (section.page < physicalPage) {
        _activeIndex = i;
      } else {
        break;
      }
    }
  }

  int? _extractSurahNumber(String title) {
    final match = RegExp(r'^(\d+)\.').firstMatch(title);
    return int.tryParse(match?.group(1) ?? '');
  }

  List<Section> _resolveSections(BookReadProvider bookReadProvider) {
    return widget.type == FihristType.sure
        ? bookReadProvider.fihristSections
        : bookReadProvider.fihristCuzSections;
  }

  bool _sectionMatchesQuery(Section section, String query) {
    final normalizedQuery = StringNormalizer.normalizeForSearch(query);
    if (normalizedQuery.isEmpty) return true;

    final title = StringNormalizer.normalizeForSearch(section.title);
    if (title.contains(normalizedQuery)) return true;

    final surahNum = _extractSurahNumber(section.title);
    if (surahNum != null && surahNum.toString().contains(normalizedQuery)) {
      return true;
    }

    final cuzMatch = RegExp(
      r'cüz-(\d+)',
      caseSensitive: false,
    ).firstMatch(section.title);
    if (cuzMatch != null && cuzMatch.group(1)!.contains(normalizedQuery)) {
      return true;
    }

    final hizbMatch = RegExp(
      r'hizb-(\d+)',
      caseSensitive: false,
    ).firstMatch(section.title.trim());
    if (hizbMatch != null && hizbMatch.group(1)!.contains(normalizedQuery)) {
      return true;
    }

    return false;
  }

  bool _cuzMatchesQuery(Section section, String query, BuildContext context) {
    final normalizedQuery = StringNormalizer.normalizeForSearch(query);
    if (normalizedQuery.isEmpty) return true;

    final cuzMatch = RegExp(
      r'^Cüz-(\d+)$',
      caseSensitive: false,
    ).firstMatch(section.title);
    if (cuzMatch == null) return false;

    final cuzNumber = cuzMatch.group(1)!;
    if (cuzNumber.startsWith(normalizedQuery)) return true;
    final localizedCuzLabel = context.quranL10n.bookFihristCuzLabel(cuzNumber);
    if (StringNormalizer.normalizeForSearch(
      localizedCuzLabel,
    ).contains(normalizedQuery)) {
      return true;
    }

    return false;
  }

  List<Section> _filterSections(List<Section> sections, BuildContext context) {
    final query = widget.searchQuery.trim();
    if (query.isEmpty) return sections;

    if (widget.type == FihristType.cuz) {
      return sections
          .where((section) => _cuzMatchesQuery(section, query, context))
          .toList();
    }

    return sections.where((section) {
      if (_sectionMatchesQuery(section, query)) return true;
      return section.children.any(
        (child) => _sectionMatchesQuery(child, query),
      );
    }).toList();
  }

  void _syncTabState(
    SectionProvider sectionProvider,
    BookReadProvider bookReadProvider,
    List<Section> sections,
    int currentPage,
  ) {
    sectionProvider.onActivePageChanged = () {
      _updateActiveSection(sections, bookReadProvider);
      _scrollToActiveSection();
    };

    sectionProvider.syncTab(widget.type, currentPage, sections);
    _lastSyncedPage = currentPage;
    _syncOnActivate = false;
    _scrollToActiveSection();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Consumer2<BookReadProvider, SectionProvider>(
      builder: (context, bookReadProvider, sectionProvider, child) {
        final allSections = _resolveSections(bookReadProvider);
        final sections = _filterSections(allSections, context);
        final currentPage = _currentPageFor(bookReadProvider);

        _updateActiveSection(allSections, bookReadProvider);

        for (int i = 0; i < allSections.length; i++) {
          _sectionKeys[i] ??= GlobalKey();
        }

        if (widget.isActiveTab) {
          final shouldSync = _syncOnActivate || _lastSyncedPage != currentPage;
          if (shouldSync) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted || !widget.isActiveTab) return;
              _syncTabState(
                sectionProvider,
                bookReadProvider,
                allSections,
                currentPage,
              );
            });
          }
        }

        return SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 14),
          child: Column(
            children: List.generate(sections.length, (index) {
              final section = sections[index];
              final originalIndex = allSections.indexOf(section);
              final isActive = _activeIndex == originalIndex;

              return SectionListItem(
                key: _sectionKeys[originalIndex],
                section: section,
                fihristType: widget.type,
                sectionProvider: sectionProvider,
                bookReadProvider: bookReadProvider,
                allSections: allSections,
                isActive: isActive,
                searchQuery: widget.searchQuery,
              );
            }),
          ),
        );
      },
    );
  }
}
