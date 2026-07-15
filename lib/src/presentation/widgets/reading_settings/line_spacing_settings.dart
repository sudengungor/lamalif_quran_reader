import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/core/events/book_read_events.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/settings_control_card.dart';

class LineSpacingSettings extends StatelessWidget {
  const LineSpacingSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsControlCard(
      onDecrease: () {
        final provider = context.read<BookReadProvider>();
        final currentSpacing = provider.getLineSpacing();
        if (currentSpacing > 1.9) {
          provider.saveLineSpacing(currentSpacing - 0.1);
          context.bookReadEvent(BookReadEvents.lineSpacingDecrease);
        }
      },
      onIncrease: () {
        final provider = context.read<BookReadProvider>();
        final currentSpacing = provider.getLineSpacing();
        if (currentSpacing < 4.0) {
          provider.saveLineSpacing(currentSpacing + 0.1);
          context.bookReadEvent(BookReadEvents.lineSpacingIncrease);
        }
      },
    );
  }
}
