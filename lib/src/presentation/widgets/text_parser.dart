import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/book_read_provider.dart';
import '../provider/texparser_provider.dart';

class RisaleTextParser extends StatelessWidget {
  const RisaleTextParser({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Consumer<BookReadProvider>(
      builder: (context, provider, child) {
        final textParser = TextParserProvider(
          context,
          lineSpacing: provider.getLineSpacing(),
        );

        return Text.rich(
          textParser.parse(text, provider.getTextColor()),
          textScaler: TextScaler.linear(provider.getFontScale()),
          textAlign: TextAlign.left, // sadece meal için
        );
      },
    );
  }
}
