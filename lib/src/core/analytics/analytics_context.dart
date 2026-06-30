import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/core/analytics/quran_reader_analytics.dart';

extension QuranReaderAnalyticsContext on BuildContext {
  QuranReaderAnalytics get quranAnalytics => read<QuranReaderAnalytics>();
}
