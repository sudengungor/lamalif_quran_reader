import 'package:flutter/material.dart';

import 'package:quran_reader/src/core/analytics/analytics_context.dart';
import 'package:quran_reader/src/presentation/widgets/bottom_sheet_base.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/reading_settings_view.dart';

class BookSettingsActionIcon extends StatelessWidget {
  const BookSettingsActionIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: true,
          enableDrag: true,
          useSafeArea: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.black.withValues(alpha: 0.25),
          constraints: ResponsiveBottomSheetConstraints.of(context),
          builder: (context) => const ReadingSettingsView(),
        );
        if (context.mounted) {
          context.quranAnalytics.logEvent('quran_settings_open');
        }
      },
      icon: const Icon(Icons.settings_outlined),
    );
  }
}
