// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_reader_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class QuranReaderLocalizationsRu extends QuranReaderLocalizations {
  QuranReaderLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get bookNavTitle => 'Коран';

  @override
  String get bookEnterNumber => 'Введите номер...';

  @override
  String get bookGoPage => 'Перейти на страницу';

  @override
  String get bookNavigation => 'Навигация по страницам';

  @override
  String get bookError => 'Ошибка';

  @override
  String get bookGo => 'Перейти';

  @override
  String get bookCancel => 'Отмена';

  @override
  String bookPageShort(String page) {
    return 'стр. $page';
  }

  @override
  String bookAppBarSubtitle(String cuz, String page) {
    return 'Джуз $cuz · стр. $page';
  }

  @override
  String get bookMealNotSpecified => 'Перевод не указан';

  @override
  String get bookSettingsFontSize => 'Размер шрифта';

  @override
  String get bookSettingsLineSpacing => 'Межстрочный интервал';

  @override
  String get bookSettingsMeal => 'Перевод';

  @override
  String get bookSettingsBackgroundColor => 'Фон';

  @override
  String get bookSettingsTextColor => 'Текст';

  @override
  String get bookFihristTitle => 'Оглавление';

  @override
  String get bookFihristSureTab => 'Сура';

  @override
  String get bookFihristCuzTab => 'Джуз';

  @override
  String get bookFihristHizb => 'Хизб';

  @override
  String bookFihristCuzLabel(String number) {
    return 'Джуз $number';
  }

  @override
  String bookFihristHizbLabel(String number) {
    return 'Хизб $number';
  }

  @override
  String get bookFihristSearchSure => 'Поиск суры по названию или номеру';

  @override
  String get bookFihristSearchCuz => 'Поиск номера джуза';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get langCode => 'ru';
}
