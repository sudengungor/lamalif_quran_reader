import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';
import 'package:quran_reader/src/presentation/widgets/style/arabic.dart';
import 'package:quran_reader/src/presentation/widgets/style/book_name.dart';
import 'package:quran_reader/src/presentation/widgets/style/subtitle.dart';

class TextStyles {
  TextStyles(this.style, this.context);

  final TextStyle style;
  final BuildContext context;

  TextSpan arabicSpan(String content) {
    final splits = content.split('|');
    final mealFallback = context.quranL10n.bookMealNotSpecified;
    final secondPart = splits.length > 1 && splits[1].isNotEmpty
        ? splits[1]
        : mealFallback;

    return TextSpan(
      children: [
        WidgetSpan(
          child: ArabicText(text: splits.first, meal: secondPart),
        ),
      ],
    );
  }

  TextSpan centerSpan(String content) {
    return TextSpan(
      children: [WidgetSpan(child: SureNameText(text: content))],
    );
  }

  TextSpan titleSpan(String content) {
    return TextSpan(
      style: currentStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
      text: '\n$content\n',
    );
  }

  TextSpan subTitleSpan(String content) {
    return TextSpan(
      children: [WidgetSpan(child: SubTitleText(text: content))],
    );
  }

  TextSpan bookNameSpan(String content) {
    return TextSpan(
      children: [WidgetSpan(child: SureNameText(text: content))],
    );
  }

  TextSpan ownerSpan(String content) {
    return TextSpan(style: style, text: '\n$content');
  }

  TextSpan bookmarkSpan(String content) {
    return TextSpan(style: currentStyle, text: '\n$content');
  }

  TextSpan boldSpan(String content) {
    return TextSpan(
      style: currentStyle.copyWith(fontWeight: FontWeight.bold),
      text: ' $content ',
    );
  }

  TextSpan infoSpan(String content) {
    return TextSpan(
      style: currentStyle.copyWith(fontWeight: FontWeight.bold),
      text: '$content ',
    );
  }

  TextStyle get currentStyle {
    final bookReadProvider = context.read<BookReadProvider>();
    return style.copyWith(color: bookReadProvider.getTextColor());
  }
}
