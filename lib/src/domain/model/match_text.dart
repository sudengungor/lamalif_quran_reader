import 'package:flutter/material.dart';

import 'regex_options.dart';

class MatchText {
  String pattern;

  String startWith;
  String endWith;

  Function? onTap;

  TextSpan Function(String text)? builder;

  final RegexOptions regexOptions;

  MatchText({
    required this.pattern,
    required this.startWith,
    required this.endWith,
    this.onTap,
    this.builder,
    this.regexOptions = const RegexOptions(),
  });
}
