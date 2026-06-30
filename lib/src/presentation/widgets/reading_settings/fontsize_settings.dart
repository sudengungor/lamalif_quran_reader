import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/core/analytics/analytics_context.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/settings_control_card.dart';

class FontsizeSettings extends StatelessWidget {
  const FontsizeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsControlCard(
      onDecrease: () {
        context.read<BookReadProvider>().decreaseFontSize();
        context.quranAnalytics.logEvent('quran_font_size_decrease');
      },
      onIncrease: () {
        context.read<BookReadProvider>().increaseFontSize();
        context.quranAnalytics.logEvent('quran_font_size_increase');
      },
    );
  }
}
