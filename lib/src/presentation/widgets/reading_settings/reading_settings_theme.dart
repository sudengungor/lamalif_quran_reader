import 'package:flutter/material.dart';

abstract final class ReadingSettingsTheme {
  /// Neutral tint on the reading background — avoids muddy brown from text color.
  static Color softSurface(Color background, {required bool isDark}) {
    return Color.alphaBlend(
      (isDark ? Colors.white : Colors.black).withValues(alpha: isDark ? 0.05 : 0.035),
      background,
    );
  }

  static Color softBorder(Color background, {required bool isDark}) {
    return Color.alphaBlend(
      (isDark ? Colors.white : Colors.black).withValues(alpha: isDark ? 0.08 : 0.055),
      background,
    );
  }

  static Color controlBorder(Color background, {required bool isDark}) {
    return Color.alphaBlend(
      (isDark ? Colors.white : Colors.black).withValues(alpha: isDark ? 0.18 : 0.14),
      background,
    );
  }
}
