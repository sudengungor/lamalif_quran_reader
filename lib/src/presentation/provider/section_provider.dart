import 'package:flutter/widgets.dart';

import '../../domain/model/drawer_component.dart';

/// Drawer fihrist sekmeleri.
///
/// Index 0 = Sure, Index 1 = Cüz
enum FihristType { sure, cuz }

/// Drawer içindeki Sure/Cüz fihrist bölümlerinin durumunu yönetir.
///
/// Her sekme kendi sayfa koordinatını ve genişletme durumunu ayrı tutar:
/// - Sure → scroll item indeksi
/// - Cüz → fiziksel Mushaf sayfa numarası
class SectionProvider extends ChangeNotifier {
  final Map<FihristType, int> _pages = {
    FihristType.sure: 0,
    FihristType.cuz: 0,
  };
  final Map<FihristType, Map<String, bool>> _expandedSections = {
    FihristType.sure: {},
    FihristType.cuz: {},
  };
  final Map<FihristType, String> _currentlyExpandedSection = {
    FihristType.sure: '',
    FihristType.cuz: '',
  };

  /// Aktif sekmenin scroll callback'i; yalnızca o sekme tarafından atanır.
  VoidCallback? onActivePageChanged;

  int currentPageFor(FihristType tab) => _pages[tab]!;

  /// Geriye dönük uyumluluk: aktif sekmenin sayfasını döner.
  int get currentPage => _pages[FihristType.cuz]!;

  Map<String, bool> expandedSectionsFor(FihristType tab) =>
      Map.unmodifiable(_expandedSections[tab]!);

  String currentlyExpandedSectionFor(FihristType tab) =>
      _currentlyExpandedSection[tab]!;

  bool isSectionExpanded(FihristType tab, Section section) {
    return _expandedSections[tab]![section.title] ?? false;
  }

  void toggleSectionExpanded(FihristType tab, Section section) {
    final expanded = _expandedSections[tab]!;
    final key = section.title;
    final currentValue = expanded[key] ?? false;

    if (currentValue) {
      expanded[key] = false;
      _currentlyExpandedSection[tab] = '';
    } else {
      for (final sectionKey in expanded.keys.toList()) {
        expanded[sectionKey] = false;
      }
      expanded[key] = true;
      _currentlyExpandedSection[tab] = key;
    }

    notifyListeners();
  }

  (int startPage, int endPage) _getSectionPageRange(
    Section section,
    List<Section> allSections,
  ) {
    final sectionIndex = allSections.indexWhere(
      (s) => s.title == section.title,
    );
    if (sectionIndex == -1) return (section.page, section.page);

    final startPage = section.page;
    int endPage = 999999;

    for (int i = sectionIndex + 1; i < allSections.length; i++) {
      final nextSection = allSections[i];
      if (nextSection.tabCount <= section.tabCount) {
        endPage = nextSection.page - 1;
        break;
      }
    }

    return (startPage, endPage);
  }

  Section? _findActiveChildSection(FihristType tab, Section parentSection) {
    if (parentSection.children.isEmpty) return null;

    final currentPage = _pages[tab]!;
    final sortedChildren = [...parentSection.children]
      ..sort((a, b) => a.page.compareTo(b.page));

    Section? bestMatch;
    for (final child in sortedChildren) {
      if (child.page == currentPage) return child;
      if (currentPage >= child.page) {
        bestMatch = child;
      } else {
        break;
      }
    }

    return bestMatch;
  }

  bool isSectionActive(
    FihristType tab,
    Section section,
    List<Section> allSections,
  ) {
    final currentPage = _pages[tab]!;
    final (startPage, endPage) = _getSectionPageRange(section, allSections);
    final isInRange = currentPage >= startPage && currentPage <= endPage;

    if (!isInRange) return false;

    if (section.children.isNotEmpty) {
      if (currentPage == section.page) return true;
      return _findActiveChildSection(tab, section) != null;
    }

    return true;
  }

  bool isChildSectionActive(
    FihristType tab,
    Section childSection,
    Section parentSection,
    List<Section> allSections,
  ) {
    final currentPage = _pages[tab]!;
    final (parentStartPage, parentEndPage) = _getSectionPageRange(
      parentSection,
      allSections,
    );
    if (currentPage < parentStartPage || currentPage > parentEndPage) {
      return false;
    }

    final activeChild = _findActiveChildSection(tab, parentSection);
    return activeChild?.title == childSection.title;
  }

  /// Sekme aktif olduğunda veya okuma konumu değiştiğinde çağrılır.
  ///
  /// Sayfayı günceller ve aktif üst bölümü (Cüz/Sure) otomatik açar.
  void syncTab(FihristType tab, int page, List<Section> sections) {
    final pageChanged = _pages[tab] != page;
    _pages[tab] = page;

    _autoExpandActiveSection(tab, sections);

    if (pageChanged) {
      notifyListeners();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onActivePageChanged?.call();
      });
    } else {
      notifyListeners();
    }
  }

  void _autoExpandActiveSection(FihristType tab, List<Section> sections) {
    String? sectionToExpand;

    for (final section in sections) {
      if (isSectionActive(tab, section, sections) &&
          section.children.isNotEmpty) {
        sectionToExpand = section.title;
        break;
      }
    }

    final expanded = _expandedSections[tab]!;
    final currentExpanded = _currentlyExpandedSection[tab]!;

    if (sectionToExpand != null && currentExpanded != sectionToExpand) {
      for (final key in expanded.keys.toList()) {
        expanded[key] = false;
      }
      expanded[sectionToExpand] = true;
      _currentlyExpandedSection[tab] = sectionToExpand;
    } else if (sectionToExpand == null && currentExpanded.isNotEmpty) {
      for (final key in expanded.keys.toList()) {
        expanded[key] = false;
      }
      _currentlyExpandedSection[tab] = '';
    }
  }
}
