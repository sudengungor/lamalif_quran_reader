import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_reader/src/core/events/book_read_events.dart';
import 'package:quran_reader/src/core/utils/string_normalizer.dart';
import 'package:quran_reader/src/domain/model/drawer_component.dart';
import 'package:quran_reader/src/l10n/generated/quran_reader_localizations.dart';
import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';
import 'package:quran_reader/src/presentation/provider/section_provider.dart';
import 'package:quran_reader/src/presentation/widgets/fihrist_sections/expand_button.dart';
import 'package:quran_reader/src/presentation/widgets/fihrist_sections/fihrist_drawer_colors.dart';

/// Fihrist listesindeki tek bir bölüm satırı.
class SectionListItem extends StatefulWidget {
  final Section section;
  final FihristType fihristType;
  final SectionProvider sectionProvider;
  final BookReadProvider bookReadProvider;
  final List<Section> allSections;
  final GlobalKey? activeKey;
  final bool isActive;
  final String searchQuery;

  const SectionListItem({
    super.key,
    required this.section,
    required this.fihristType,
    required this.sectionProvider,
    required this.bookReadProvider,
    required this.allSections,
    this.activeKey,
    required this.isActive,
    this.searchQuery = '',
  });

  @override
  State<SectionListItem> createState() => _SectionListItemState();
}

class _SectionListItemState extends State<SectionListItem> {
  void _navigateToPage(int pageNumber, {String? sectionTitle}) {
    final title = sectionTitle ?? widget.section.title;
    final targetIndex = _calcIndex(
      pageNumber,
      widget.bookReadProvider.selectedBook.firstPage,
      title: title,
    );

    widget.bookReadProvider.itemScrollController?.jumpTo(index: targetIndex);

    context.bookReadEvent('${BookReadEvents.fihristSectionSelect}:$title');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.sectionProvider.syncTab(
        widget.fihristType,
        pageNumber,
        widget.allSections,
      );
    });

    if (mounted) {
      Navigator.pop(context);
    }
  }

  int _calcIndex(int pageNumber, int firstPage, {required String title}) {
    final surahNum = _extractSurahNumber(title);
    if (surahNum != null) {
      final itemIdx = widget.bookReadProvider.surahItemIndexMap[surahNum];
      if (itemIdx != null) return itemIdx;
    }

    final hizbNum = _extractHizbNumber(title);
    if (hizbNum != null) {
      final key = '${pageNumber}_$hizbNum';
      final itemIdx = widget.bookReadProvider.hizbItemIndexMap[key];
      if (itemIdx != null) return itemIdx;
    }

    final pageNums = widget.bookReadProvider.itemPageNumbers;
    if (pageNums.isNotEmpty) {
      final idx = pageNums.indexOf(pageNumber);
      if (idx != -1) return idx;
    }

    if (pageNumber <= firstPage) return 0;
    final targetIndex = pageNumber - firstPage;
    if (widget.bookReadProvider.bookFileLength != null &&
        targetIndex >= widget.bookReadProvider.bookFileLength!) {
      return widget.bookReadProvider.bookFileLength! - 1;
    }
    return targetIndex;
  }

  int? _extractSurahNumber(String title) {
    final match = RegExp(r'^(\d+)\.').firstMatch(title);
    return int.tryParse(match?.group(1) ?? '');
  }

  int? _extractHizbNumber(String title) {
    final match = RegExp(r'^Hizb-(\d+)$').firstMatch(title.trim());
    return int.tryParse(match?.group(1) ?? '');
  }

  bool _matchesQuery(String title) {
    final query = StringNormalizer.normalizeForSearch(widget.searchQuery);
    if (query.isEmpty) return true;

    if (StringNormalizer.normalizeForSearch(title).contains(query)) return true;

    final surahNum = _extractSurahNumber(title);
    if (surahNum != null && surahNum.toString().contains(query)) {
      return true;
    }

    final cuzMatch = RegExp(
      r'cüz-(\d+)',
      caseSensitive: false,
    ).firstMatch(title);
    if (cuzMatch != null && cuzMatch.group(1)!.contains(query)) {
      return true;
    }

    final hizbMatch = RegExp(
      r'hizb-(\d+)',
      caseSensitive: false,
    ).firstMatch(title.trim());
    if (hizbMatch != null && hizbMatch.group(1)!.contains(query)) {
      return true;
    }

    return false;
  }

  ({String badge, String displayTitle}) _parseDisplay(
    Section section,
    QuranReaderLocalizations l10n,
  ) {
    final parts = section.title.split('@');
    final isTurkish = l10n.localeName.toLowerCase().startsWith('tr');
    final localizedName = (parts.length > 1 && !isTurkish ? parts[1] : parts[0])
        .trim();

    final sureMatch = RegExp(r'^(\d+)\.\s*(.+)$').firstMatch(parts[0].trim());
    if (sureMatch != null) {
      return (
        badge: sureMatch.group(1)!,
        displayTitle: localizedName.replaceFirst(RegExp(r'^\d+\.\s*'), ''),
      );
    }

    final cuzMatch = RegExp(
      r'^Cüz-(\d+)$',
      caseSensitive: false,
    ).firstMatch(section.title);
    if (cuzMatch != null) {
      return (
        badge: cuzMatch.group(1)!,
        displayTitle: l10n.bookFihristCuzLabel(cuzMatch.group(1)!),
      );
    }

    final hizbMatch = RegExp(
      r'^Hizb-(\d+)$',
      caseSensitive: false,
    ).firstMatch(section.title.trim());
    if (hizbMatch != null) {
      return (
        badge: hizbMatch.group(1)!,
        displayTitle: l10n.bookFihristHizbLabel(hizbMatch.group(1)!),
      );
    }

    return (badge: '•', displayTitle: localizedName);
  }

  @override
  Widget build(BuildContext context) {
    final bool hasChildren = widget.section.children.isNotEmpty;

    return Consumer<SectionProvider>(
      builder: (context, sectionProvider, child) {
        final bool isExpanded = sectionProvider.isSectionExpanded(
          widget.fihristType,
          widget.section,
        );
        final l10n = context.quranL10n;
        final display = _parseDisplay(widget.section, l10n);
        final visibleChildren = widget.fihristType == FihristType.cuz
            ? widget.section.children
            : widget.section.children
                  .where((child) => _matchesQuery(child.title))
                  .toList();

        final isCuzTab = widget.fihristType == FihristType.cuz;
        final isCuzParent = RegExp(
          r'^Cüz-\d+$',
          caseSensitive: false,
        ).hasMatch(widget.section.title);

        return Column(
          key: widget.isActive ? widget.activeKey : null,
          mainAxisSize: MainAxisSize.min,
          children: [
            _SectionRow(
              badge: isCuzTab && isCuzParent ? null : display.badge,
              title: display.displayTitle,
              isActive: widget.isActive,
              onTap: () => _navigateToPage(widget.section.page),
              leading: isCuzTab && hasChildren
                  ? ExpandButton(
                      isExpanded: isExpanded,
                      onTap: () => sectionProvider.toggleSectionExpanded(
                        widget.fihristType,
                        widget.section,
                      ),
                    )
                  : null,
              trailing: !isCuzTab && hasChildren
                  ? ExpandButton(
                      isExpanded: isExpanded,
                      onTap: () => sectionProvider.toggleSectionExpanded(
                        widget.fihristType,
                        widget.section,
                      ),
                    )
                  : null,
            ),
            if (hasChildren && isExpanded)
              ...visibleChildren.map((child) {
                final childDisplay = _parseDisplay(child, l10n);
                final bool isChildActive = sectionProvider.isChildSectionActive(
                  widget.fihristType,
                  child,
                  widget.section,
                  widget.allSections,
                );

                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: _SectionRow(
                    badge: childDisplay.badge,
                    title: childDisplay.displayTitle,
                    isActive: isChildActive,
                    onTap: () =>
                        _navigateToPage(child.page, sectionTitle: child.title),
                  ),
                );
              }),
          ],
        );
      },
    );
  }
}

class _SectionRow extends StatelessWidget {
  final String? badge;
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final Widget? leading;
  final Widget? trailing;

  const _SectionRow({
    this.badge,
    required this.title,
    required this.isActive,
    required this.onTap,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colors = FihristDrawerTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
        decoration: BoxDecoration(
          color: isActive ? colors.itemActiveBackground : null,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            if (leading != null)
              SizedBox(width: 32, height: 32, child: Center(child: leading))
            else if (badge != null)
              _NumberBadge(label: badge!, isActive: isActive),
            if (leading != null || badge != null) const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                  color: isActive ? colors.itemActiveText : colors.itemText,
                ),
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}

class _NumberBadge extends StatelessWidget {
  final String label;
  final bool isActive;

  const _NumberBadge({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final colors = FihristDrawerTheme.of(context);

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive ? colors.badgeActiveBackground : colors.badgeBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: isActive ? colors.badgeActiveText : colors.badgeText,
        ),
      ),
    );
  }
}
