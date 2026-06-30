// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_reader_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class QuranReaderLocalizationsEn extends QuranReaderLocalizations {
  QuranReaderLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get bookNavTitle => 'Qur\'an';

  @override
  String get bookEnterNumber => 'Enter a number...';

  @override
  String get bookGoPage => 'Go to Page';

  @override
  String get bookNavigation => 'Page Navigation';

  @override
  String get bookError => 'Error';

  @override
  String get bookGo => 'Go';

  @override
  String get bookCancel => 'Cancel';

  @override
  String bookPageShort(String page) {
    return 'p. $page';
  }

  @override
  String bookAppBarSubtitle(String cuz, String page) {
    return 'Juz $cuz · p. $page';
  }

  @override
  String get bookMealNotSpecified => 'Translation not specified';

  @override
  String get bookSettingsFontSize => 'Font Size';

  @override
  String get bookSettingsLineSpacing => 'Line Spacing';

  @override
  String get bookSettingsMeal => 'Translation';

  @override
  String get bookSettingsBackgroundColor => 'Background';

  @override
  String get bookSettingsTextColor => 'Text';

  @override
  String get bookFihristTitle => 'Table of Contents';

  @override
  String get bookFihristSureTab => 'Surah';

  @override
  String get bookFihristCuzTab => 'Juz';

  @override
  String get bookFihristHizb => 'Hizb';

  @override
  String bookFihristCuzLabel(String number) {
    return 'Juz $number';
  }

  @override
  String bookFihristHizbLabel(String number) {
    return 'Hizb $number';
  }

  @override
  String get bookFihristSearchSure => 'Search surah name or number';

  @override
  String get bookFihristSearchCuz => 'Search juz number';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get langCode => 'en';
}
