// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_reader_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class QuranReaderLocalizationsUz extends QuranReaderLocalizations {
  QuranReaderLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get bookNavTitle => 'Qur\'on';

  @override
  String get bookEnterNumber => 'Raqam kiriting...';

  @override
  String get bookGoPage => 'Sahifaga o\'tish';

  @override
  String get bookNavigation => 'Sahifa navigatsiyasi';

  @override
  String get bookError => 'Xato';

  @override
  String get bookGo => 'O\'tish';

  @override
  String get bookCancel => 'Bekor qilish';

  @override
  String bookPageShort(String page) {
    return 'B. $page';
  }

  @override
  String bookAppBarSubtitle(String cuz, String page) {
    return 'Juz $cuz · B. $page';
  }

  @override
  String get bookMealNotSpecified => 'Tarjima ko\'rsatilmagan';

  @override
  String get bookSettingsFontSize => 'Shrift o\'lchami';

  @override
  String get bookSettingsLineSpacing => 'Qator oralig\'i';

  @override
  String get bookSettingsMeal => 'Tarjima';

  @override
  String get bookSettingsBackgroundColor => 'Fon';

  @override
  String get bookSettingsTextColor => 'Matn';

  @override
  String get bookFihristTitle => 'Mundarija';

  @override
  String get bookFihristSureTab => 'Sura';

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
  String get bookFihristSearchSure => 'Sura nomi yoki raqamini qidirish';

  @override
  String get bookFihristSearchCuz => 'Juz raqamini qidirish';

  @override
  String get settingsTitle => 'Sozlamalar';

  @override
  String get langCode => 'uz';
}
