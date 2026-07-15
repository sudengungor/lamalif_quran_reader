// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_reader_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class QuranReaderLocalizationsBn extends QuranReaderLocalizations {
  QuranReaderLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get bookNavTitle => 'কুরআন';

  @override
  String get bookEnterNumber => 'একটি সংখ্যা লিখুন...';

  @override
  String get bookGoPage => 'পৃষ্ঠায় যান';

  @override
  String get bookNavigation => 'পৃষ্ঠা নেভিগেশন';

  @override
  String get bookError => 'ত্রুটি';

  @override
  String get bookGo => 'যান';

  @override
  String get bookCancel => 'বাতিল';

  @override
  String bookPageShort(String page) {
    return 'পৃ. $page';
  }

  @override
  String bookAppBarSubtitle(String cuz, String page) {
    return 'পারা $cuz · পৃ. $page';
  }

  @override
  String get bookMealNotSpecified => 'অনুবাদ উল্লেখ করা হয়নি';

  @override
  String get bookSettingsFontSize => 'ফন্টের আকার';

  @override
  String get bookSettingsLineSpacing => 'লাইন ব্যবধান';

  @override
  String get bookSettingsMeal => 'অনুবাদ';

  @override
  String get bookSettingsBackgroundColor => 'পটভূমি';

  @override
  String get bookSettingsTextColor => 'লেখা';

  @override
  String get bookFihristTitle => 'সূচিপত্র';

  @override
  String get bookFihristSureTab => 'সূরা';

  @override
  String get bookFihristCuzTab => 'পারা';

  @override
  String get bookFihristHizb => 'হিজব';

  @override
  String bookFihristCuzLabel(String number) {
    return 'পারা $number';
  }

  @override
  String bookFihristHizbLabel(String number) {
    return 'হিজব $number';
  }

  @override
  String get bookFihristSearchSure => 'সূরার নাম বা নম্বর অনুসন্ধান';

  @override
  String get bookFihristSearchCuz => 'পারা নম্বর অনুসন্ধান';

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get langCode => 'bn';
}
