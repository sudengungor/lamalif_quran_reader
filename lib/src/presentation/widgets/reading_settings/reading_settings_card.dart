import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/book_read_provider.dart';
import 'reading_settings_theme.dart';

enum ReadingSettingsCardType {
  top(16, 16, 0, 0),
  middle(0, 0, 0, 0),
  bottom(0, 0, 16, 16);

  const ReadingSettingsCardType(
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
  );

  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;
}

class ReadingSettingsCard extends StatelessWidget {
  const ReadingSettingsCard({
    super.key,
    required this.child,
    required this.icon,
    required this.title,
    this.type = ReadingSettingsCardType.middle,
    this.stackControls = false,
  });
  final Widget child;
  final IconData icon;
  final String title;
  final ReadingSettingsCardType type;
  final bool stackControls;

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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: ReadingSettingsTheme.softSurface(
              background,
              isDark: isDark,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(type.topLeft),
              topRight: Radius.circular(type.topRight),
              bottomLeft: Radius.circular(type.bottomLeft),
              bottomRight: Radius.circular(type.bottomRight),
            ),
          ),
          child: stackControls
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _TitleRow(icon: icon, title: title, textColor: textColor),
                    const SizedBox(height: 10),
                    child,
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _TitleRow(
                        icon: icon,
                        title: title,
                        textColor: textColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    child,
                  ],
                ),
        );
      },
    );
  }
}

class _TitleRow extends StatelessWidget {
  const _TitleRow({
    required this.icon,
    required this.title,
    required this.textColor,
  });

  final IconData icon;
  final String title;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Icon(icon, color: textColor.withValues(alpha: 0.7)),
        Expanded(
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
