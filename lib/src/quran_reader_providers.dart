import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quran_reader/src/core/analytics/quran_reader_analytics.dart';
import 'package:quran_reader/src/domain/service/book_read_preferences.dart';
import 'package:quran_reader/src/domain/service/book_read_repository.dart';
import 'package:quran_reader/src/l10n/generated/quran_reader_localizations.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';
import 'package:quran_reader/src/presentation/provider/drawer_tab_provider.dart';
import 'package:quran_reader/src/presentation/provider/section_provider.dart';

/// Provider listesi; host uygulamada [MultiProvider] ile kullanılır.
List<SingleChildWidget> quranReaderProviders({
  required SharedPreferences sharedPreferences,
  QuranReaderAnalytics analytics = const NoOpQuranReaderAnalytics(),
}) {
  return [
    Provider<QuranReaderAnalytics>.value(value: analytics),
    Provider<BookReadRepository>(create: (_) => BookReadRepository()),
    Provider<BookReadPreferences>(
      create: (_) => BookReadPreferences(sharedPreferences),
    ),
    ChangeNotifierProvider<BookReadProvider>(
      create: (context) => BookReadProvider(
        repository: context.read<BookReadRepository>(),
        preferences: context.read<BookReadPreferences>(),
        analytics: context.read<QuranReaderAnalytics>(),
      ),
    ),
    ChangeNotifierProvider<DrawerTabProvider>(
      create: (context) => DrawerTabProvider(
        context.read<BookReadPreferences>(),
      ),
    ),
    ChangeNotifierProvider<SectionProvider>(create: (_) => SectionProvider()),
  ];
}

/// Paket lokalizasyon delegate'leri.
const List<LocalizationsDelegate<dynamic>> quranReaderLocalizationsDelegates = [
  QuranReaderLocalizations.delegate,
];

/// Paket tarafından desteklenen diller.
const List<Locale> quranReaderSupportedLocales = [
  Locale('az'),
  Locale('de'),
  Locale('en'),
  Locale('es'),
  Locale('fr'),
  Locale('id'),
  Locale('uz'),
  Locale('tr'),
  Locale('ru'),
  Locale('ur'),
  Locale('ar'),
  Locale('fa'),
  Locale('hi'),
  Locale('bn'),
];
