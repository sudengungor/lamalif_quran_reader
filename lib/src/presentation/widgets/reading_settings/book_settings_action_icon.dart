import 'package:flutter/material.dart';

import 'package:quran_reader/src/core/events/book_read_events.dart';
import 'package:quran_reader/src/presentation/widgets/bottom_sheet_base.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/reading_settings_view.dart';

class BookSettingsActionIcon extends StatelessWidget {
  const BookSettingsActionIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        context.bookReadEvent(BookReadEvents.settingsOpen);
        final onEvent = BookReadEventScope.maybeOf(context)?.onEvent;
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: true,
          enableDrag: true,
          useSafeArea: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.black.withValues(alpha: 0.25),
          constraints: ResponsiveBottomSheetConstraints.of(context),
          builder: (context) => BookReadEventScope(
            onEvent: onEvent,
            child: const ReadingSettingsView(),
          ),
        );
      },
      icon: const Icon(Icons.settings_outlined),
    );
  }
}
