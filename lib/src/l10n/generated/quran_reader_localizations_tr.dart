// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_reader_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class QuranReaderLocalizationsTr extends QuranReaderLocalizations {
  QuranReaderLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get bookNavTitle => 'Kur\'an-ı Kerim';

  @override
  String get bookEnterNumber => 'Bir sayı girin...';

  @override
  String get bookGoPage => 'Sayfaya Git';

  @override
  String get bookNavigation => 'Sayfa Navigasyonu';

  @override
  String get bookError => 'Hata';

  @override
  String get bookGo => 'Git';

  @override
  String get bookCancel => 'İptal';

  @override
  String bookPageShort(String page) {
    return 'Sf. $page';
  }

  @override
  String bookAppBarSubtitle(String cuz, String page) {
    return 'Cüz $cuz · Sf. $page';
  }

  @override
  String get bookMealNotSpecified => 'Meal belirtilmemiş';

  @override
  String get bookSettingsFontSize => 'Yazı Boyutu';

  @override
  String get bookSettingsLineSpacing => 'Satır Aralığı';

  @override
  String get bookSettingsMeal => 'Meal';

  @override
  String get bookSettingsBackgroundColor => 'Arka Plan';

  @override
  String get bookSettingsTextColor => 'Yazı';

  @override
  String get bookFihristTitle => 'Fihrist';

  @override
  String get bookFihristSureTab => 'Sûre';

  @override
  String get bookFihristCuzTab => 'Cüz';

  @override
  String get bookFihristHizb => 'Hizb';

  @override
  String bookFihristCuzLabel(String number) {
    return 'Cüz $number';
  }

  @override
  String bookFihristHizbLabel(String number) {
    return 'Hizb $number';
  }

  @override
  String get bookFihristSearchSure => 'Sûre adı veya numarası ara';

  @override
  String get bookFihristSearchCuz => 'Cüz numarası ara';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get langCode => 'tr';
}
