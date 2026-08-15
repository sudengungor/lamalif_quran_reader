import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';
import '../../provider/book_read_provider.dart';

/// Sure isminin stili için.
class SureNameText extends StatelessWidget {
  const SureNameText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final localeName = context.quranL10n.localeName;

    return Consumer<BookReadProvider>(
      builder: (context, provider, child) {
        return Container(
          alignment: Alignment.center,
          child: Text(
            provider.localizedInlineSureName(text, localeName),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              height: 1,
              color: provider.getIconColor(),
            ),
          ),
        );
      },
    );
  }
}
