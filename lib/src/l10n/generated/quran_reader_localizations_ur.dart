// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_reader_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class QuranReaderLocalizationsUr extends QuranReaderLocalizations {
  QuranReaderLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get bookNavTitle => 'قرآن';

  @override
  String get bookEnterNumber => 'نمبر درج کریں...';

  @override
  String get bookGoPage => 'صفحے پر جائیں';

  @override
  String get bookNavigation => 'صفحہ نیویگیشن';

  @override
  String get bookError => 'خرابی';

  @override
  String get bookGo => 'جائیں';

  @override
  String get bookCancel => 'منسوخ';

  @override
  String bookPageShort(String page) {
    return 'ص. $page';
  }

  @override
  String bookAppBarSubtitle(String cuz, String page) {
    return 'پارہ $cuz · ص. $page';
  }

  @override
  String get bookMealNotSpecified => 'ترجمہ درج نہیں';

  @override
  String get bookSettingsFontSize => 'فونٹ سائز';

  @override
  String get bookSettingsLineSpacing => 'لائن وقفہ';

  @override
  String get bookSettingsMeal => 'ترجمہ';

  @override
  String get bookSettingsBackgroundColor => 'پس منظر';

  @override
  String get bookSettingsTextColor => 'متن';

  @override
  String get bookFihristTitle => 'فہرست';

  @override
  String get bookFihristSureTab => 'سورہ';

  @override
  String get bookFihristCuzTab => 'پارہ';

  @override
  String get bookFihristHizb => 'حزب';

  @override
  String bookFihristCuzLabel(String number) {
    return 'پارہ $number';
  }

  @override
  String bookFihristHizbLabel(String number) {
    return 'حزب $number';
  }

  @override
  String get bookFihristSearchSure => 'سورہ کا نام یا نمبر تلاش کریں';

  @override
  String get bookFihristSearchCuz => 'پارہ نمبر تلاش کریں';

  @override
  String get settingsTitle => 'ترتیبات';

  @override
  String get langCode => 'ur';
}
