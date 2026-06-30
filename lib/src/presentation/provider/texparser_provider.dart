import 'package:flutter/material.dart';

import '../../domain/model/match_text.dart';
import '../widgets/text_styles.dart';

class TextParserProvider {
  late TextStyle style;
  late TextStyles _textStyles;
  late List<MatchText> matchTexts;
  final BuildContext context;
  final String? fontFamily;

  final arabicTextRegExp = r"([~].[^@#]*)@";
  final bookNameTextRegExp = r"([&][^>#]*)>";
  final titleTextRegExp = r"([∑][^>#]*)>";
  final subTitleTextRegExp = r"([€][^>#]*)>";
  final ownerTextRegExp = r"([÷][^>#]*)>";
  final bookmarkTextRegExp = r"([\r\n][,][^>#]*)>";
  final boldTextRegExp = r"([\\][^>#]*)>";
  final mealTextRegExp = r"([∫][^>#]*)>";
  final infoTextRegExp = r"([`][^>#]*)>";
  final centerTextRegExp = r"([<][^>#]*)>";
  final hasiyeTextRegEx = r"([{][^}#]*)}";

  TextParserProvider(this.context, {this.fontFamily, double? lineSpacing}) {
    style = TextStyle(
      height: lineSpacing ?? 1.5,
      fontSize: 18,
      fontFamily: fontFamily,
    );
    _textStyles = TextStyles(style, context);

    matchTexts = [
      MatchText(
        pattern: arabicTextRegExp,
        startWith: "~",
        endWith: "@",
        builder: (text) => _textStyles.arabicSpan(text),
      ),
      MatchText(
        pattern: bookNameTextRegExp,
        startWith: "&",
        endWith: ">",
        builder: (text) => _textStyles.bookNameSpan(text),
      ),
      MatchText(
        pattern: titleTextRegExp,
        startWith: "∑",
        endWith: ">",
        builder: (text) => _textStyles.titleSpan(text),
      ),
      MatchText(
        pattern: subTitleTextRegExp,
        startWith: "€",
        endWith: ">",
        builder: (text) => _textStyles.subTitleSpan(text),
      ),
      MatchText(
        pattern: ownerTextRegExp,
        startWith: "÷",
        endWith: ">",
        builder: (text) => _textStyles.ownerSpan(text),
      ),
      MatchText(
        pattern: bookmarkTextRegExp,
        startWith: ",",
        endWith: ">",
        builder: (text) => _textStyles.bookmarkSpan(text),
      ),
      MatchText(
        pattern: boldTextRegExp,
        startWith: "\\",
        endWith: ">",
        builder: (text) => _textStyles.boldSpan(text),
      ),
      MatchText(
        pattern: infoTextRegExp,
        startWith: "`",
        endWith: ">",
        builder: (text) => _textStyles.infoSpan(text),
      ),
      MatchText(
        pattern: centerTextRegExp,
        startWith: "<",
        endWith: ">",
        builder: (text) => _textStyles.centerSpan(text),
      ),
      MatchText(
        pattern: mealTextRegExp,
        startWith: "∫",
        endWith: ">",
        builder: (text) => _textStyles.infoSpan(text),
      ),
      MatchText(
        pattern: hasiyeTextRegEx,
        startWith: "{*",
        endWith: "}",
        builder: (text) => _textStyles.boldSpan(text),
      ),
    ];
  }

  TextSpan parse(String text, [Color? color]) {
    String newString = text
        .replaceAll(
          RegExp(r"[\n]"),
          "\n\n",
        ) // Her paragraf sonuna boşluk ekler.
        .replaceAll(RegExp(r"^\d+"), "") // En baştaki sayfa numarasını siler.
        .replaceAll(
          RegExp(r"^\s*,", multiLine: true),
          "\n\n   ",
        ) // Paragraf başındaki virgülleri siler
        .replaceAll(
          RegExp(r":\s{2,3}\s"),
          ':',
        ) // Her : işaretinden sonraki fazla boşluğu temizler.
        .trim(); // Baştaki ve sondaki boşlukları siler.

    for (var e in matchTexts) {
      RegExp regExp = RegExp(
        e.pattern,
        multiLine: e.regexOptions.multiLine,
        caseSensitive: e.regexOptions.caseSensitive,
        unicode: e.regexOptions.unicode,
        dotAll: e.regexOptions.dotAll,
      );

      newString = newString.splitMapJoin(
        regExp,
        onMatch: (m) => "%%%%${m.group(0)}%%%%",
        onNonMatch: (m) => m,
      );
    }
    List<String> splits = newString.split("%%%%");

    List<TextSpan> widgets = splits.map<TextSpan>((element) {
      TextSpan widget = TextSpan(text: element);

      for (final e in matchTexts) {
        RegExp customRegExp = RegExp(
          e.pattern,
          multiLine: e.regexOptions.multiLine,
          caseSensitive: e.regexOptions.caseSensitive,
          unicode: e.regexOptions.unicode,
          dotAll: e.regexOptions.dotAll,
        );

        bool matched = customRegExp.hasMatch(element);
        if (matched) {
          element = element
              .replaceAll(e.startWith, "")
              .replaceAll(e.endWith, "");

          if (e.builder != null) {
            widget = e.builder!(element);
          }

          break;
        }
      }

      // Özel karakterleri temizle
      if (widget.text != null) {
        widget = TextSpan(
          text: widget.text!.replaceAll(RegExp(r"[&/><\\{}£€∑`]"), ''),
          style: widget.style,
        );
      }

      return widget;
    }).toList();

    return TextSpan(
      children: <TextSpan>[...widgets],
      style: style.copyWith(color: color, fontSize: 14, height: 1.8),
    );
  }
}
