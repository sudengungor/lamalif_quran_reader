// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_reader_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class QuranReaderLocalizationsAz extends QuranReaderLocalizations {
  QuranReaderLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get bookNavTitle => 'Qurani-Kərim';

  @override
  String get bookEnterNumber => 'Nömrə daxil edin...';

  @override
  String get bookGoPage => 'Səhifəyə Get';

  @override
  String get bookNavigation => 'Səhifə Naviqasiyası';

  @override
  String get bookError => 'Xəta';

  @override
  String get bookGo => 'Get';

  @override
  String get bookCancel => 'Ləğv et';

  @override
  String bookPageShort(String page) {
    return 'S. $page';
  }

  @override
  String bookAppBarSubtitle(String cuz, String page) {
    return 'Cüz $cuz · S. $page';
  }

  @override
  String get bookMealNotSpecified => 'Tərcümə göstərilməyib';

  @override
  String get bookSettingsFontSize => 'Şrift ölçüsü';

  @override
  String get bookSettingsLineSpacing => 'Sətir aralığı';

  @override
  String get bookSettingsMeal => 'Tərcümə';

  @override
  String get bookSettingsBackgroundColor => 'Fon';

  @override
  String get bookSettingsTextColor => 'Mətn';

  @override
  String get bookFihristTitle => 'Mündəricat';

  @override
  String get bookFihristSureTab => 'Surə';

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
  String get bookFihristSearchSure => 'Surə adı və ya nömrəsi axtar';

  @override
  String get bookFihristSearchCuz => 'Cüz nömrəsi axtar';

  @override
  String get settingsTitle => 'Parametrlər';

  @override
  String get langCode => 'az';
}
