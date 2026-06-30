import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quran_reader/src/presentation/widgets/reading_settings/color/reading_theme_manager.dart';

class BookReadPreferences {
  BookReadPreferences(this._prefs);

  final SharedPreferences _prefs;

  final String _alignmentKey = 'quran_alignment';
  final String _lastPageKey = 'quran_last_page';
  final String _fontScaleKey = 'quran_font_scale';
  final String _lineSpacingKey = 'quran_line_spacing';
  final String _textAlignmentKey = 'quran_text_alignment';
  final String _textColorKey = 'quran_text_color';
  final String _backgroundColorKey = 'quran_background_color';
  final String _paddingKey = 'quran_padding';
  final String _mealEnabledKey = 'quran_meal_enabled';
  final String _drawerTabIndexKey = 'quran_drawer_tab_index';

  Future<void> setAlignment(double value) async {
    await _prefs.setDouble(_alignmentKey, value);
  }

  double getAlignment() => _prefs.getDouble(_alignmentKey) ?? 0.0;

  Future<void> setLastPage(double value) async {
    await _prefs.setDouble(_lastPageKey, value);
  }

  double getLastPage() => _prefs.getDouble(_lastPageKey) ?? 0.0;

  Future<void> setFontScale(double value) async {
    await _prefs.setDouble(_fontScaleKey, value);
  }

  double getFontScale() => _prefs.getDouble(_fontScaleKey) ?? 1.55;

  Future<void> setLineSpacing(double value) async {
    await _prefs.setDouble(_lineSpacingKey, value);
  }

  double getLineSpacing() => _prefs.getDouble(_lineSpacingKey) ?? 2.5;

  Future<void> setTextAlignment(int value) async {
    await _prefs.setInt(_textAlignmentKey, value);
  }

  int getTextAlignment() =>
      _prefs.getInt(_textAlignmentKey) ?? TextAlign.justify.index;

  Future<void> setTextColor(int value) async {
    await _prefs.setInt(_textColorKey, value);
  }

  int getTextColor() =>
      _prefs.getInt(_textColorKey) ??
      ReadingThemeManager.textPalettes.first.color.toARGB32();

  Future<void> setBackgroundColor(int value) async {
    await _prefs.setInt(_backgroundColorKey, value);
  }

  int getBackgroundColor() =>
      _prefs.getInt(_backgroundColorKey) ??
      ReadingThemeManager.backgroundPalettes.first.color.toARGB32();

  Future<void> setPadding(double value) async {
    await _prefs.setDouble(_paddingKey, value);
  }

  double getPadding() => _prefs.getDouble(_paddingKey) ?? 26.0;

  Future<void> setMealEnabled(bool value) async {
    await _prefs.setBool(_mealEnabledKey, value);
  }

  bool getMealEnabled() => _prefs.getBool(_mealEnabledKey) ?? false;

  Future<void> setDrawerTabIndex(int value) async {
    await _prefs.setInt(_drawerTabIndexKey, value);
  }

  int getDrawerTabIndex() => _prefs.getInt(_drawerTabIndexKey) ?? 0;
}
