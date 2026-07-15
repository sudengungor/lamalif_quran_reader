import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/core/events/book_read_events.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/settings_control_card.dart';

class FontsizeSettings extends StatelessWidget {
  const FontsizeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsControlCard(
      onDecrease: () {
        context.read<BookReadProvider>().decreaseFontSize();
        context.bookReadEvent(BookReadEvents.fontSizeDecrease);
      },
      onIncrease: () {
        context.read<BookReadProvider>().increaseFontSize();
        context.bookReadEvent(BookReadEvents.fontSizeIncrease);
      },
    );
  }
}
