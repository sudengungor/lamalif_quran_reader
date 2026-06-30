import 'package:flutter/material.dart';

import '../../provider/book_read_provider.dart';

/// Sûre/Cüz drawer renk paleti. Açık mod mevcut sıcak tonları kullanır;
/// karanlık mod okuma arka planıyla uyumlu koyu tonlara geçer.
@immutable
class FihristDrawerColors {
  final Color background;
  final Color border;

  final Color tabBarBackground;
  final Color tabActiveBackground;
  final Color tabActiveText;
  final Color tabInactiveText;

  final Color searchBackground;
  final Color searchBorder;
  final Color searchIcon;
  final Color searchHint;
  final Color searchText;
  final Color searchSelection;

  final Color badgeBackground;
  final Color badgeText;
  final Color badgeActiveBackground;
  final Color badgeActiveText;

  final Color itemText;
  final Color itemActiveBackground;
  final Color itemActiveText;

  final Color expandIcon;

  const FihristDrawerColors({
    required this.background,
    required this.border,
    required this.tabBarBackground,
    required this.tabActiveBackground,
    required this.tabActiveText,
    required this.tabInactiveText,
    required this.searchBackground,
    required this.searchBorder,
    required this.searchIcon,
    required this.searchHint,
    required this.searchText,
    required this.searchSelection,
    required this.badgeBackground,
    required this.badgeText,
    required this.badgeActiveBackground,
    required this.badgeActiveText,
    required this.itemText,
    required this.itemActiveBackground,
    required this.itemActiveText,
    required this.expandIcon,
  });

  static const _light = FihristDrawerColors(
    background: Color(0xFFF7F1E3),
    border: Color(0xFFD8CCB4),
    tabBarBackground: Color(0xFFEDE4CF),
    tabActiveBackground: Color(0xFF9A4A28),
    tabActiveText: Color(0xFFFBF2E6),
    tabInactiveText: Color(0xFF6E5C44),
    searchBackground: Color(0xFFFFFDF6),
    searchBorder: Color(0xFFDDD1B8),
    searchIcon: Color(0xFF8A7A62),
    searchHint: Color(0xFF9C8B71),
    searchText: Color(0xFF2B2118),
    searchSelection: Color(0x339A4A28),
    badgeBackground: Color(0xFFEDE4CF),
    badgeText: Color(0xFF6E5C44),
    badgeActiveBackground: Color(0xFF9A4A28),
    badgeActiveText: Color(0xFFFBF2E6),
    itemText: Color(0xFF2B2118),
    itemActiveBackground: Color(0xFFF1E0D2),
    itemActiveText: Color(0xFF6B3014),
    expandIcon: Color(0xFF6E5C44),
  );

  static const _dark = FihristDrawerColors(
    background: Color(0xFF1C1C1C),
    border: Color(0xFF3A3A3A),
    tabBarBackground: Color(0xFF2A2A2A),
    tabActiveBackground: Color(0xFFB8734A),
    tabActiveText: Color(0xFFF5F0EB),
    tabInactiveText: Color(0xFF9E9E9E),
    searchBackground: Color(0xFF252525),
    searchBorder: Color(0xFF404040),
    searchIcon: Color(0xFF8A8A8A),
    searchHint: Color(0xFF757575),
    searchText: Color(0xFFE8E8E8),
    searchSelection: Color(0x33B8734A),
    badgeBackground: Color(0xFF2E2E2E),
    badgeText: Color(0xFF9E9E9E),
    badgeActiveBackground: Color(0xFFB8734A),
    badgeActiveText: Color(0xFFF5F0EB),
    itemText: Color(0xFFE0E0E0),
    itemActiveBackground: Color(0xFF3D2E28),
    itemActiveText: Color(0xFFE8A87C),
    expandIcon: Color(0xFF9E9E9E),
  );

  factory FihristDrawerColors.fromProvider(BookReadProvider provider) {
    final isDark = provider.bgOption.isDark;
    final base = isDark ? _dark : _light;
    return FihristDrawerColors(
      background: provider.getBackgroundColor(),
      border: base.border,
      tabBarBackground: base.tabBarBackground,
      tabActiveBackground: base.tabActiveBackground,
      tabActiveText: base.tabActiveText,
      tabInactiveText: base.tabInactiveText,
      searchBackground: base.searchBackground,
      searchBorder: base.searchBorder,
      searchIcon: base.searchIcon,
      searchHint: base.searchHint,
      searchText: base.searchText,
      searchSelection: base.searchSelection,
      badgeBackground: base.badgeBackground,
      badgeText: base.badgeText,
      badgeActiveBackground: base.badgeActiveBackground,
      badgeActiveText: base.badgeActiveText,
      itemText: base.itemText,
      itemActiveBackground: base.itemActiveBackground,
      itemActiveText: base.itemActiveText,
      expandIcon: base.expandIcon,
    );
  }
}

class FihristDrawerTheme extends InheritedWidget {
  final FihristDrawerColors colors;

  const FihristDrawerTheme({
    super.key,
    required this.colors,
    required super.child,
  });

  static FihristDrawerColors of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<FihristDrawerTheme>();
    assert(theme != null, 'FihristDrawerTheme not found in widget tree');
    return theme!.colors;
  }

  @override
  bool updateShouldNotify(FihristDrawerTheme oldWidget) {
    return colors.background != oldWidget.colors.background;
  }
}
