// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_reader_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class QuranReaderLocalizationsEs extends QuranReaderLocalizations {
  QuranReaderLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get bookNavTitle => 'Corán';

  @override
  String get bookEnterNumber => 'Introducir un número...';

  @override
  String get bookGoPage => 'Ir a la página';

  @override
  String get bookNavigation => 'Navegación de páginas';

  @override
  String get bookError => 'Error';

  @override
  String get bookGo => 'Ir';

  @override
  String get bookCancel => 'Cancelar';

  @override
  String bookPageShort(String page) {
    return 'p. $page';
  }

  @override
  String bookAppBarSubtitle(String cuz, String page) {
    return 'Yuz $cuz · p. $page';
  }

  @override
  String get bookMealNotSpecified => 'Traducción no especificada';

  @override
  String get bookSettingsFontSize => 'Tamaño de fuente';

  @override
  String get bookSettingsLineSpacing => 'Espaciado entre líneas';

  @override
  String get bookSettingsMeal => 'Traducción';

  @override
  String get bookSettingsBackgroundColor => 'Fondo';

  @override
  String get bookSettingsTextColor => 'Texto';

  @override
  String get bookFihristTitle => 'Índice';

  @override
  String get bookFihristSureTab => 'Sura';

  @override
  String get bookFihristCuzTab => 'Yuz';

  @override
  String get bookFihristHizb => 'Hizb';

  @override
  String bookFihristCuzLabel(String number) {
    return 'Yuz $number';
  }

  @override
  String bookFihristHizbLabel(String number) {
    return 'Hizb $number';
  }

  @override
  String get bookFihristSearchSure => 'Buscar nombre o número de sura';

  @override
  String get bookFihristSearchCuz => 'Buscar número de yuz';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get langCode => 'es';
}
