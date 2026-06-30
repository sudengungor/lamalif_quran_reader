import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/book_read_provider.dart';
import 'background_color_settings.dart';
import 'reading_settings_theme.dart';

class ColorPickerRow extends StatelessWidget {
  const ColorPickerRow({
    super.key,
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
  });

  final List<Color> colors;
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  @override
  Widget build(BuildContext context) {
    return Selector<BookReadProvider, (Color, bool)>(
      selector: (_, provider) =>
          (provider.getBackgroundColor(), provider.bgOption.isDark),
      builder: (context, data, _) {
        final (background, isDark) = data;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ReadingSettingsTheme.softSurface(
              background,
              isDark: isDark,
            ),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: ReadingSettingsTheme.softBorder(
                background,
                isDark: isDark,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: colors.map((color) {
              return ColorButton(
                color: color,
                isSelected: selectedColor.toARGB32() == color.toARGB32(),
                onTap: () => onColorSelected(color),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
