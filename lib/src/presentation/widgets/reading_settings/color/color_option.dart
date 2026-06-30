import 'package:flutter/material.dart';

class ColorOption {
  final Color color;
  final bool isDark;

  const ColorOption({required this.color, this.isDark = true});

  /// [this] seçilen renk için kullanılabilir renkleri döndürür
  List<ColorOption> getAvailableColorsBy(List<ColorOption> colors) {
    return colors.where((color) => color.isDark != isDark).toList();
  }

  /// [this] seçilen renk için kullanılabilir tek bir renk döndürür
  ColorOption getAvailableColorBy(List<ColorOption> colors) {
    return colors.firstWhere((color) => color.isDark != isDark);
  }
}
