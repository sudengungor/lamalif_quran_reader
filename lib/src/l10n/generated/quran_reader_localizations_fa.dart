// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_reader_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class QuranReaderLocalizationsFa extends QuranReaderLocalizations {
  QuranReaderLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get bookNavTitle => 'قرآن کریم';

  @override
  String get bookEnterNumber => 'عدد وارد کنید...';

  @override
  String get bookGoPage => 'رفتن به صفحه';

  @override
  String get bookNavigation => 'پیمایش صفحات';

  @override
  String get bookError => 'خطا';

  @override
  String get bookGo => 'برو';

  @override
  String get bookCancel => 'لغو';

  @override
  String bookPageShort(String page) {
    return 'ص. $page';
  }

  @override
  String bookAppBarSubtitle(String cuz, String page) {
    return 'جزء $cuz · ص. $page';
  }

  @override
  String get bookMealNotSpecified => 'ترجمه مشخص نشده';

  @override
  String get bookSettingsFontSize => 'اندازه قلم';

  @override
  String get bookSettingsLineSpacing => 'فاصله خطوط';

  @override
  String get bookSettingsMeal => 'ترجمه';

  @override
  String get bookSettingsBackgroundColor => 'پس‌زمینه';

  @override
  String get bookSettingsTextColor => 'متن';

  @override
  String get bookFihristTitle => 'فهرست';

  @override
  String get bookFihristSureTab => 'سوره';

  @override
  String get bookFihristCuzTab => 'جزء';

  @override
  String get bookFihristHizb => 'حزب';

  @override
  String bookFihristCuzLabel(String number) {
    return 'جزء $number';
  }

  @override
  String bookFihristHizbLabel(String number) {
    return 'حزب $number';
  }

  @override
  String get bookFihristSearchSure => 'جستجوی نام یا شماره سوره';

  @override
  String get bookFihristSearchCuz => 'جستجوی شماره جزء';

  @override
  String get settingsTitle => 'تنظیمات';

  @override
  String get langCode => 'fa';
}
