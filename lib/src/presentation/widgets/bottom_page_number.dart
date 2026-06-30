import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';

class BottomBookPage extends StatelessWidget {
  const BottomBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    const scale = TextScaler.linear(0.9);
    final l10n = context.quranL10n;

    return Consumer<BookReadProvider>(
      builder: (context, provider, child) {
        return Container(
          color: provider.getBackgroundColor(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  provider.getCurrentLocationInfo(l10n),
                  textScaler: scale,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: provider.getIconColor(),
                  ),
                ),
              ),
              Text(
                provider.getCurrentPage(),
                textScaler: scale,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: provider.getIconColor(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
