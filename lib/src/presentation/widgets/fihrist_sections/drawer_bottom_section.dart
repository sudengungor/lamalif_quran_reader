import 'package:flutter/material.dart';

import 'package:quran_reader/src/core/events/book_read_events.dart';
import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/go_to_page_dialog.dart';

class DrawerBottomSection extends StatelessWidget {
  const DrawerBottomSection({super.key, this.textColor});

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () async {
        final navigated = await showGoToPageDialog(context);
        if (!navigated || !context.mounted) return;
        context.bookReadEvent(BookReadEvents.goToPage);
        Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? Theme.of(context).colorScheme.onSurface,
        textStyle: Theme.of(context).textTheme.bodyMedium,
      ),
      icon: const Icon(Icons.arrow_forward_ios_rounded),
      label: Text(context.quranL10n.bookGoPage),
    );
  }
}
