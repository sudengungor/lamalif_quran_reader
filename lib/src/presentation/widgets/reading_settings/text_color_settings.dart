import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/core/analytics/analytics_context.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/color_picker_row.dart';

class TextColorSettings extends StatelessWidget {
  const TextColorSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<BookReadProvider, Color>(
      selector: (_, provider) => provider.getTextColor(),
      builder: (context, selectedColor, _) {
        final availableColors = context
            .read<BookReadProvider>()
            .getAvailableTextColors();

        return ColorPickerRow(
          colors: availableColors,
          selectedColor: selectedColor,
          onColorSelected: (color) {
            context.read<BookReadProvider>().saveTextColor(color);
            context.quranAnalytics.logEvent('quran_text_color_changed');
          },
        );
      },
    );
  }
}
