import 'package:flutter/foundation.dart';

import '../../domain/service/book_read_preferences.dart';

/// Drawer'daki aktif tab index'ini yönetir ve SharedPreferences'a persist eder.
///
/// Index 0 = Sure, Index 1 = Cüz
class DrawerTabProvider extends ChangeNotifier {
  final BookReadPreferences _preferences;

  late int _selectedTabIndex;

  DrawerTabProvider(this._preferences) {
    _selectedTabIndex = _preferences.getDrawerTabIndex();
  }

  int get selectedTabIndex => _selectedTabIndex;

  Future<void> selectTab(int index) async {
    if (_selectedTabIndex == index) return;
    _selectedTabIndex = index;
    await _preferences.setDrawerTabIndex(index);
    notifyListeners();
  }
}
