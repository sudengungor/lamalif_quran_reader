import 'package:flutter/material.dart';

import 'package:quran_reader/src/core/analytics/analytics_context.dart';
import 'package:quran_reader/src/core/assets/quran_reader_assets.dart';
import 'package:quran_reader/src/core/extension/context_extension.dart';
import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';

class OpenQuranButton extends StatelessWidget {
  const OpenQuranButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.quranAnalytics.logEvent('book_open');
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: context.colorScheme.secondary,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                context.quranL10n.bookNavTitle,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSecondary,
                ),
              ),
            ),
            Image.asset(
              QuranReaderAssets.coverImage,
              package: QuranReaderAssets.package,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
