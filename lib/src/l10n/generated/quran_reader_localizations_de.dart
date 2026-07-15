// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_reader_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class QuranReaderLocalizationsDe extends QuranReaderLocalizations {
  QuranReaderLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get bookNavTitle => 'Koran';

  @override
  String get bookEnterNumber => 'Nummer eingeben...';

  @override
  String get bookGoPage => 'Zur Seite gehen';

  @override
  String get bookNavigation => 'Seitennavigation';

  @override
  String get bookError => 'Fehler';

  @override
  String get bookGo => 'Gehen';

  @override
  String get bookCancel => 'Abbrechen';

  @override
  String bookPageShort(String page) {
    return 'S. $page';
  }

  @override
  String bookAppBarSubtitle(String cuz, String page) {
    return 'Dschuz $cuz · S. $page';
  }

  @override
  String get bookMealNotSpecified => 'Übersetzung nicht angegeben';

  @override
  String get bookSettingsFontSize => 'Schriftgröße';

  @override
  String get bookSettingsLineSpacing => 'Zeilenabstand';

  @override
  String get bookSettingsMeal => 'Übersetzung';

  @override
  String get bookSettingsBackgroundColor => 'Hintergrund';

  @override
  String get bookSettingsTextColor => 'Text';

  @override
  String get bookFihristTitle => 'Inhaltsverzeichnis';

  @override
  String get bookFihristSureTab => 'Sure';

  @override
  String get bookFihristCuzTab => 'Dschuz';

  @override
  String get bookFihristHizb => 'Hizb';

  @override
  String bookFihristCuzLabel(String number) {
    return 'Dschuz $number';
  }

  @override
  String bookFihristHizbLabel(String number) {
    return 'Hizb $number';
  }

  @override
  String get bookFihristSearchSure => 'Sure-Name oder Nummer suchen';

  @override
  String get bookFihristSearchCuz => 'Dschuz-Nummer suchen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get langCode => 'de';
}
