import 'package:flutter/widgets.dart';

import '../l10n/generated/quran_reader_localizations.dart';

extension QuranReaderL10nExtension on BuildContext {
  QuranReaderLocalizations get quranL10n => QuranReaderLocalizations.of(this);
}
