import 'package:flutter/material.dart';

import 'color_option.dart';

class ReadingThemeManager {
  // Tüm arka plan seçenekleri
  // Tesettür uygulamasındaki açık ve koyu Kur'an okuma arka planları.
  static final List<ColorOption> backgroundPalettes = const [
    // Açık mod seçenekleri
    ColorOption(color: Color(0xFFF5F5F5), isDark: false),
    ColorOption(color: Color(0xFFFFFFFF), isDark: false),

    // Koyu mod seçenekleri
    ColorOption(color: Color(0xFF1E191A)),
    ColorOption(color: Color(0xFF000000)),
  ];

  // Eski Kur'an ekranındaki yazı renkleri.
  static final List<ColorOption> textPalettes = const [
    // Açık arka plan üzerinde kullanılacak koyu yazılar
    ColorOption(color: Colors.black),
    ColorOption(color: Color(0xFFB71C1C)), // bordo
    ColorOption(color: Colors.blue),
    ColorOption(color: Colors.green),
    ColorOption(color: Colors.deepOrange),
    ColorOption(color: Colors.teal),
    ColorOption(color: Colors.deepPurple),

    // Koyu arka plan üzerinde kullanılacak açık yazılar
    ColorOption(color: Colors.white, isDark: false),
    ColorOption(color: Color(0xFFFF9191), isDark: false),
    ColorOption(color: Color(0xFF69BBFF), isDark: false),
    ColorOption(color: Colors.green, isDark: false),
    ColorOption(color: Colors.deepOrange, isDark: false),
    ColorOption(color: Color(0xFF29EDDA), isDark: false),
    ColorOption(color: Color(0xFFBF9AFF), isDark: false),
  ];

  // Âyet numarası renkleri.
  static final List<ColorOption> verseNumberPalettes = const [
    ColorOption(color: Color(0xFFB71C1C)),
    ColorOption(color: Color(0xFFFF9191), isDark: false),
  ];

  // Hizb ve secde işaretleri.
  static final List<ColorOption> hizbPalettes = const [
    ColorOption(color: Colors.deepOrange),
    ColorOption(color: Color(0xFFFF9191), isDark: false),
  ];

  static final List<ColorOption> secdePalettes = const [
    ColorOption(color: Colors.teal),
    ColorOption(color: Color(0xFFFF9191), isDark: false),
  ];

  // Açık modda bordo, koyu modda açık kırmızı arayüz rengi.
  static final List<ColorOption> uiPalettes = const [
    ColorOption(color: Color(0xFFB71C1C)),
    ColorOption(color: Color(0xFFFF9191), isDark: false),
  ];

  static String? backgroundColorAnalyticsEvent(Color color) {
  final option = _findOption(backgroundPalettes, color);
  if (option == null) return null;

  final prefix = option.isDark ? 'dark' : 'light';
  final groupIndex = _groupIndex(backgroundPalettes, option);
  return 'quran_${prefix}_background_color_$groupIndex';
}

static String? textColorAnalyticsEvent(Color color) {
  final option = _findOption(textPalettes, color);
  if (option == null) return null;

  final prefix = option.isDark ? 'dark' : 'light';
  final groupIndex = _groupIndex(textPalettes, option);
  return 'quran_${prefix}_text_color_$groupIndex';
}

  // Paketin bazı ekranları bu eski kısa adı kullanıyor.
static String? backgroundColorEvent(Color color) {
  return backgroundColorAnalyticsEvent(color);
}

// İleride başka ekranlarda aynı durum olursa uyumlu kalsın.
static String? textColorEvent(Color color) {
  return textColorAnalyticsEvent(color);
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
