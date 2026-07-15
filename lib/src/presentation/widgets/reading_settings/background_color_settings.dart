import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/core/events/book_read_events.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/color/reading_theme_manager.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/color_picker_row.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/reading_settings_theme.dart';

class BackgroundColorSettings extends StatelessWidget {
  const BackgroundColorSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<BookReadProvider, Color>(
      selector: (context, provider) => provider.getBackgroundColor(),
      builder: (context, currentColor, _) {
        return ColorPickerRow(
          colors: ReadingThemeManager.backgroundPalettes
              .map((option) => option.color)
              .toList(),
          selectedColor: currentColor,
          onColorSelected: (color) => _updateBackgroundColor(context, color),
        );
      },
    );
  }

  void _updateBackgroundColor(BuildContext context, Color color) {
    final provider = context.read<BookReadProvider>();
    provider.saveBackgroundColor(color);

    final event = ReadingThemeManager.backgroundColorEvent(color);
    if (event != null) context.bookReadEvent(event);

    final availableTextColors = provider.getAvailableTextColors();
    final currentTextColor = provider.getTextColor();
    final isCurrentTextColorAvailable = availableTextColors.any(
      (c) => c.toARGB32() == currentTextColor.toARGB32(),
    );

    if (!isCurrentTextColorAvailable && availableTextColors.isNotEmpty) {
      provider.saveTextColor(availableTextColors.first);
    }
  }
}

class ColorButton extends StatelessWidget {
  const ColorButton({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Selector<BookReadProvider, (Color, bool)>(
      selector: (_, provider) =>
          (provider.getBackgroundColor(), provider.bgOption.isDark),
      builder: (context, data, _) {
        final (background, isDark) = data;
        final borderColor = ReadingSettingsTheme.controlBorder(
          background,
          isDark: isDark,
        );

        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 32,
                height: 32,
                margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor, width: 1),
                ),
              ),
              if (isSelected)
                const Positioned(
                  bottom: 0,
                  right: 0,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 18,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
