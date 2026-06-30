import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';

class SubTitleText extends StatelessWidget {
  const SubTitleText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    var fontFamily = 'Roboto';

    if (context.quranL10n.langCode == 'bn') {
      fontFamily = 'Hindi1';
    }

    return Consumer<BookReadProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: fontFamily,
              color: provider.getTextColor().withValues(alpha: 0.8),
            ),
          ),
        );
      },
    );
  }
}
