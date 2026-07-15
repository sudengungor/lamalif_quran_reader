import 'package:flutter/material.dart';

import 'color_option.dart';

class ReadingThemeManager {
  // Tüm arka plan seçenekleri
  static final List<ColorOption> backgroundPalettes = const [
    ColorOption(color: Color(0xffF5E8D3), isDark: false),
    ColorOption(color: Color(0xffFDF6E3), isDark: false),
    ColorOption(color: Color(0xff1C1C1C)),
    ColorOption(color: Color(0xff111111)),
  ];

  // Tüm metin rengi havuzu
  static final List<ColorOption> textPalettes = const [
    ColorOption(color: Colors.black),
    ColorOption(color: Color(0xff6B3A1F)),
    ColorOption(color: Color(0xff1B3A2D)),
    ColorOption(color: Color.fromARGB(255, 78, 31, 31)),

    // Light text colors
    ColorOption(color: Color.fromARGB(255, 244, 244, 244), isDark: false),
    ColorOption(color: Color.fromARGB(255, 184, 184, 184), isDark: false),
    ColorOption(color: Color(0xffD4B483), isDark: false),
    ColorOption(color: Color(0xffD8C8A8), isDark: false),
  ];

  // Tüm arapça ayet numarası renk havuzu
  static final List<ColorOption> verseNumberPalettes = const [
    ColorOption(color: Color.fromARGB(255, 255, 153, 146), isDark: false),
    ColorOption(color: Colors.red),
  ];

  // Tüm hizb badge renk havuzu
  static final List<ColorOption> hizbPalettes = const [
    ColorOption(color: Colors.deepOrange),
    ColorOption(color: Colors.red, isDark: false),
  ];

  // Tüm secde badge renk havuzu
  static final List<ColorOption> secdePalettes = const [
    ColorOption(color: Colors.teal),
    ColorOption(color: Colors.red, isDark: false),
  ];

  // Arayüz, iconlar ve diğer renkler için havuz
  static final List<ColorOption> uiPalettes = const [
    ColorOption(color: Color(0xff362C25)),
    ColorOption(color: Colors.white, isDark: false),
  ];

  static String? backgroundColorEvent(Color color) {
    final option = _findOption(backgroundPalettes, color);
    if (option == null) return null;

    final prefix = option.isDark ? 'dark' : 'light';
    final groupIndex = _groupIndex(backgroundPalettes, option);
    return 'quran_${prefix}_background_color_$groupIndex';
  }

  static ColorOption? _findOption(List<ColorOption> palettes, Color color) {
    for (final option in palettes) {
      if (option.color.toARGB32() == color.toARGB32()) {
        return option;
      }
    }
    return null;
  }

  static int _groupIndex(List<ColorOption> palettes, ColorOption option) {
    final group = palettes.where((o) => o.isDark == option.isDark).toList();
    return group.indexWhere(
      (o) => o.color.toARGB32() == option.color.toARGB32(),
    );
  }
}
