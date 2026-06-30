import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';
import 'package:quran_reader/src/presentation/provider/drawer_tab_provider.dart';
import 'package:quran_reader/src/presentation/provider/section_provider.dart';
import 'package:quran_reader/src/presentation/widgets/fihrist_sections/drawer_section_list_view.dart';
import 'package:quran_reader/src/presentation/widgets/fihrist_sections/drawer_tab_bar.dart';
import 'package:quran_reader/src/presentation/widgets/fihrist_sections/fihrist_drawer_colors.dart';

class BookReadDrawer extends StatefulWidget {
  const BookReadDrawer({super.key});

  @override
  State<BookReadDrawer> createState() => _BookReadDrawerState();
}

class _BookReadDrawerState extends State<BookReadDrawer>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<String> _searchQuery = ValueNotifier('');
  bool _searchUpdateScheduled = false;

  @override
  void initState() {
    super.initState();
    final initialIndex = context.read<DrawerTabProvider>().selectedTabIndex;
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: initialIndex,
    );
    _tabController.addListener(_onTabChanged);
    _searchController.addListener(_onSearchChanged);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    context.read<DrawerTabProvider>().selectTab(_tabController.index);
  }

  void _onSearchChanged() {
    if (_searchUpdateScheduled) return;
    _searchUpdateScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchUpdateScheduled = false;
      if (!mounted) return;
      _searchQuery.value = _searchController.text;
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchQuery.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<BookReadProvider, Color>(
      selector: (_, provider) => provider.getBackgroundColor(),
      builder: (context, background, _) {
        final provider = context.read<BookReadProvider>();
        final colors = FihristDrawerColors.fromProvider(provider);

        return FihristDrawerTheme(
          colors: colors,
          child: Drawer(
            backgroundColor: colors.background,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  DrawerTabBar(controller: _tabController),
                  AnimatedBuilder(
                    animation: _tabController,
                    builder: (context, _) {
                      return _DrawerSearchBar(
                        key: const ValueKey('drawer_search_bar'),
                        controller: _searchController,
                        isSureTab: _tabController.index == 0,
                      );
                    },
                  ),
                  Expanded(
                    child: AnimatedBuilder(
                      animation: _tabController,
                      builder: (context, _) {
                        final activeIndex = _tabController.index;
                        return TabBarView(
                          controller: _tabController,
                          children: [
                            _DrawerSearchableList(
                              type: FihristType.sure,
                              isActiveTab: activeIndex == 0,
                              searchQuery: _searchQuery,
                            ),
                            _DrawerSearchableList(
                              type: FihristType.cuz,
                              isActiveTab: activeIndex == 1,
                              searchQuery: _searchQuery,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DrawerSearchableList extends StatelessWidget {
  const _DrawerSearchableList({
    required this.type,
    required this.isActiveTab,
    required this.searchQuery,
  });

  final FihristType type;
  final bool isActiveTab;
  final ValueNotifier<String> searchQuery;

  @override
  Widget build(BuildContext context) {
    if (!isActiveTab) {
      return DrawerSectionListView(
        type: type,
        isActiveTab: false,
        searchQuery: '',
      );
    }

    return ValueListenableBuilder<String>(
      valueListenable: searchQuery,
      builder: (context, query, _) {
        return DrawerSectionListView(
          type: type,
          isActiveTab: true,
          searchQuery: query,
        );
      },
    );
  }
}

class _DrawerSearchBar extends StatefulWidget {
  const _DrawerSearchBar({
    super.key,
    required this.controller,
    required this.isSureTab,
  });

  final TextEditingController controller;
  final bool isSureTab;

  @override
  State<_DrawerSearchBar> createState() => _DrawerSearchBarState();
}

class _DrawerSearchBarState extends State<_DrawerSearchBar> {
  late final FocusNode _focusNode;
  ThemeData? _inputTheme;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  ThemeData _buildInputTheme(BuildContext context, FihristDrawerColors colors) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: _noBorder,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.searchIcon,
        selectionColor: colors.searchSelection,
        selectionHandleColor: colors.searchIcon,
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  static const _noBorder = InputDecorationTheme(
    filled: false,
    border: InputBorder.none,
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
    contentPadding: EdgeInsets.zero,
    isDense: true,
  );

  @override
  Widget build(BuildContext context) {
    final colors = FihristDrawerTheme.of(context);
    _inputTheme ??= _buildInputTheme(context, colors);
    final l10n = context.quranL10n;
    final hintText = widget.isSureTab
        ? l10n.bookFihristSearchSure
        : l10n.bookFihristSearchCuz;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.searchBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.searchBorder, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.search, size: 16, color: colors.searchIcon),
              const SizedBox(width: 8),
              Expanded(
                child: Theme(
                  data: _inputTheme!,
                  child: TextField(
                    key: const ValueKey('fihrist_drawer_search_field'),
                    controller: widget.controller,
                    focusNode: _focusNode,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.2,
                      color: colors.searchText,
                    ),
                    cursorWidth: 1.5,
                    decoration: InputDecoration.collapsed(
                      hintText: hintText,
                      fillColor: colors.searchBackground,
                      focusColor: colors.searchBackground,
                      hoverColor: colors.searchBackground,
                      filled: true,
                      hintStyle: TextStyle(
                        fontSize: 13,
                        height: 1.2,
                        color: colors.searchHint,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
