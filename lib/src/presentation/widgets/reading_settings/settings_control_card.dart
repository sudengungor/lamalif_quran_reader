import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/book_read_provider.dart';
import 'reading_settings_theme.dart';

class SettingsControlCard extends StatelessWidget {
  const SettingsControlCard({
    super.key,
    required this.onDecrease,
    required this.onIncrease,
  });
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;

  @override
  Widget build(BuildContext context) {
    return Selector<BookReadProvider, (Color, Color, bool)>(
      selector: (_, provider) => (
        provider.getBackgroundColor(),
        provider.getTextColor(),
        provider.bgOption.isDark,
      ),
      builder: (context, data, _) {
        final (background, textColor, isDark) = data;
        return Container(
          decoration: BoxDecoration(
            color: ReadingSettingsTheme.softSurface(
              background,
              isDark: isDark,
            ),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: ReadingSettingsTheme.controlBorder(
                background,
                isDark: isDark,
              ),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _CompactIconButton(
                onPressed: onDecrease,
                icon: Icons.remove,
                color: textColor,
              ),
              _CompactIconButton(
                onPressed: onIncrease,
                icon: Icons.add,
                color: textColor,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CompactIconButton extends StatelessWidget {
  const _CompactIconButton({
    required this.onPressed,
    required this.icon,
    required this.color,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      icon: Icon(icon, color: color, size: 20),
    );
  }
}
