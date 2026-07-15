// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_reader_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class QuranReaderLocalizationsAr extends QuranReaderLocalizations {
  QuranReaderLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get bookNavTitle => 'القرآن الكريم';

  @override
  String get bookEnterNumber => 'أدخل رقماً...';

  @override
  String get bookGoPage => 'الانتقال إلى الصفحة';

  @override
  String get bookNavigation => 'التنقل بين الصفحات';

  @override
  String get bookError => 'خطأ';

  @override
  String get bookGo => 'انتقال';

  @override
  String get bookCancel => 'إلغاء';

  @override
  String bookPageShort(String page) {
    return 'ص. $page';
  }

  @override
  String bookAppBarSubtitle(String cuz, String page) {
    return 'جزء $cuz · ص. $page';
  }

  @override
  String get bookMealNotSpecified => 'لم يتم تحديد التفسير';

  @override
  String get bookSettingsFontSize => 'حجم الخط';

  @override
  String get bookSettingsLineSpacing => 'تباعد الأسطر';

  @override
  String get bookSettingsMeal => 'التفسير';

  @override
  String get bookSettingsBackgroundColor => 'الخلفية';

  @override
  String get bookSettingsTextColor => 'النص';

  @override
  String get bookFihristTitle => 'الفهرس';

  @override
  String get bookFihristSureTab => 'سورة';

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
  String get bookFihristSearchSure => 'ابحث عن اسم أو رقم السورة';

  @override
  String get bookFihristSearchCuz => 'ابحث عن رقم الجزء';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get langCode => 'ar';
}
