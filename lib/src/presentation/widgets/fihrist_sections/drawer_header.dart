import 'package:flutter/material.dart';

import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';

class DrawerHeaderSection extends StatelessWidget {
  const DrawerHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(
          bottom: BorderSide(
            color: scheme.outline.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
      ),
      child: Text(
        context.quranL10n.bookFihristTitle,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
