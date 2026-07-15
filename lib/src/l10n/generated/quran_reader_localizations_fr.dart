// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_reader_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class QuranReaderLocalizationsFr extends QuranReaderLocalizations {
  QuranReaderLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get bookNavTitle => 'Coran';

  @override
  String get bookEnterNumber => 'Entrer un numéro...';

  @override
  String get bookGoPage => 'Aller à la page';

  @override
  String get bookNavigation => 'Navigation des pages';

  @override
  String get bookError => 'Erreur';

  @override
  String get bookGo => 'Aller';

  @override
  String get bookCancel => 'Annuler';

  @override
  String bookPageShort(String page) {
    return 'p. $page';
  }

  @override
  String bookAppBarSubtitle(String cuz, String page) {
    return 'Juz $cuz · p. $page';
  }

  @override
  String get bookMealNotSpecified => 'Traduction non spécifiée';

  @override
  String get bookSettingsFontSize => 'Taille de police';

  @override
  String get bookSettingsLineSpacing => 'Espacement des lignes';

  @override
  String get bookSettingsMeal => 'Traduction';

  @override
  String get bookSettingsBackgroundColor => 'Arrière-plan';

  @override
  String get bookSettingsTextColor => 'Texte';

  @override
  String get bookFihristTitle => 'Table des matières';

  @override
  String get bookFihristSureTab => 'Sourate';

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
  String get bookFihristSearchSure =>
      'Rechercher une sourate par nom ou numéro';

  @override
  String get bookFihristSearchCuz => 'Rechercher un numéro de juz';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get langCode => 'fr';
}
