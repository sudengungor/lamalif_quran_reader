import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'quran_reader_localizations_ar.dart';
import 'quran_reader_localizations_az.dart';
import 'quran_reader_localizations_bn.dart';
import 'quran_reader_localizations_de.dart';
import 'quran_reader_localizations_en.dart';
import 'quran_reader_localizations_es.dart';
import 'quran_reader_localizations_fa.dart';
import 'quran_reader_localizations_fr.dart';
import 'quran_reader_localizations_hi.dart';
import 'quran_reader_localizations_id.dart';
import 'quran_reader_localizations_ru.dart';
import 'quran_reader_localizations_tr.dart';
import 'quran_reader_localizations_ur.dart';
import 'quran_reader_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of QuranReaderLocalizations
/// returned by `QuranReaderLocalizations.of(context)`.
///
/// Applications need to include `QuranReaderLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/quran_reader_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: QuranReaderLocalizations.localizationsDelegates,
///   supportedLocales: QuranReaderLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the QuranReaderLocalizations.supportedLocales
/// property.
abstract class QuranReaderLocalizations {
  QuranReaderLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static QuranReaderLocalizations of(BuildContext context) {
    return Localizations.of<QuranReaderLocalizations>(
      context,
      QuranReaderLocalizations,
    )!;
  }

  static const LocalizationsDelegate<QuranReaderLocalizations> delegate =
      _QuranReaderLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('az'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('ru'),
    Locale('tr'),
    Locale('ur'),
    Locale('uz'),
  ];

  /// No description provided for @bookNavTitle.
  ///
  /// In en, this message translates to:
  /// **'Qur\'an'**
  String get bookNavTitle;

  /// No description provided for @bookEnterNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a number...'**
  String get bookEnterNumber;

  /// No description provided for @bookGoPage.
  ///
  /// In en, this message translates to:
  /// **'Go to Page'**
  String get bookGoPage;

  /// No description provided for @bookNavigation.
  ///
  /// In en, this message translates to:
  /// **'Page Navigation'**
  String get bookNavigation;

  /// No description provided for @bookError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get bookError;

  /// No description provided for @bookGo.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get bookGo;

  /// No description provided for @bookCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get bookCancel;

  /// No description provided for @bookPageShort.
  ///
  /// In en, this message translates to:
  /// **'p. {page}'**
  String bookPageShort(String page);

  /// No description provided for @bookAppBarSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Juz {cuz} · p. {page}'**
  String bookAppBarSubtitle(String cuz, String page);

  /// No description provided for @bookMealNotSpecified.
  ///
  /// In en, this message translates to:
  /// **'Translation not specified'**
  String get bookMealNotSpecified;

  /// No description provided for @bookSettingsFontSize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get bookSettingsFontSize;

  /// No description provided for @bookSettingsLineSpacing.
  ///
  /// In en, this message translates to:
  /// **'Line Spacing'**
  String get bookSettingsLineSpacing;

  /// No description provided for @bookSettingsMeal.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get bookSettingsMeal;

  /// No description provided for @bookSettingsBackgroundColor.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get bookSettingsBackgroundColor;

  /// No description provided for @bookSettingsTextColor.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get bookSettingsTextColor;

  /// No description provided for @bookFihristTitle.
  ///
  /// In en, this message translates to:
  /// **'Table of Contents'**
  String get bookFihristTitle;

  /// No description provided for @bookFihristSureTab.
  ///
  /// In en, this message translates to:
  /// **'Surah'**
  String get bookFihristSureTab;

  /// No description provided for @bookFihristCuzTab.
  ///
  /// In en, this message translates to:
  /// **'Juz'**
  String get bookFihristCuzTab;

  /// No description provided for @bookFihristHizb.
  ///
  /// In en, this message translates to:
  /// **'Hizb'**
  String get bookFihristHizb;

  /// No description provided for @bookFihristCuzLabel.
  ///
  /// In en, this message translates to:
  /// **'Juz {number}'**
  String bookFihristCuzLabel(String number);

  /// No description provided for @bookFihristHizbLabel.
  ///
  /// In en, this message translates to:
  /// **'Hizb {number}'**
  String bookFihristHizbLabel(String number);

  /// No description provided for @bookFihristSearchSure.
  ///
  /// In en, this message translates to:
  /// **'Search surah name or number'**
  String get bookFihristSearchSure;

  /// No description provided for @bookFihristSearchCuz.
  ///
  /// In en, this message translates to:
  /// **'Search juz number'**
  String get bookFihristSearchCuz;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @langCode.
  ///
  /// In en, this message translates to:
  /// **'en'**
  String get langCode;
}

class _QuranReaderLocalizationsDelegate
    extends LocalizationsDelegate<QuranReaderLocalizations> {
  const _QuranReaderLocalizationsDelegate();

  @override
  Future<QuranReaderLocalizations> load(Locale locale) {
    return SynchronousFuture<QuranReaderLocalizations>(
      lookupQuranReaderLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'az',
    'bn',
    'de',
    'en',
    'es',
    'fa',
    'fr',
    'hi',
    'id',
    'ru',
    'tr',
    'ur',
    'uz',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_QuranReaderLocalizationsDelegate old) => false;
}

QuranReaderLocalizations lookupQuranReaderLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return QuranReaderLocalizationsAr();
    case 'az':
      return QuranReaderLocalizationsAz();
    case 'bn':
      return QuranReaderLocalizationsBn();
    case 'de':
      return QuranReaderLocalizationsDe();
    case 'en':
      return QuranReaderLocalizationsEn();
    case 'es':
      return QuranReaderLocalizationsEs();
    case 'fa':
      return QuranReaderLocalizationsFa();
    case 'fr':
      return QuranReaderLocalizationsFr();
    case 'hi':
      return QuranReaderLocalizationsHi();
    case 'id':
      return QuranReaderLocalizationsId();
    case 'ru':
      return QuranReaderLocalizationsRu();
    case 'tr':
      return QuranReaderLocalizationsTr();
    case 'ur':
      return QuranReaderLocalizationsUr();
    case 'uz':
      return QuranReaderLocalizationsUz();
  }

  throw FlutterError(
    'QuranReaderLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
