// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_reader_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class QuranReaderLocalizationsHi extends QuranReaderLocalizations {
  QuranReaderLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get bookNavTitle => 'क़ुरआन';

  @override
  String get bookEnterNumber => 'संख्या दर्ज करें...';

  @override
  String get bookGoPage => 'पृष्ठ पर जाएँ';

  @override
  String get bookNavigation => 'पृष्ठ नेविगेशन';

  @override
  String get bookError => 'त्रुटि';

  @override
  String get bookGo => 'जाएँ';

  @override
  String get bookCancel => 'रद्द करें';

  @override
  String bookPageShort(String page) {
    return 'पृ. $page';
  }

  @override
  String bookAppBarSubtitle(String cuz, String page) {
    return 'पारा $cuz · पृ. $page';
  }

  @override
  String get bookMealNotSpecified => 'अनुवाद निर्दिष्ट नहीं';

  @override
  String get bookSettingsFontSize => 'फ़ॉन्ट आकार';

  @override
  String get bookSettingsLineSpacing => 'पंक्ति अंतराल';

  @override
  String get bookSettingsMeal => 'अनुवाद';

  @override
  String get bookSettingsBackgroundColor => 'पृष्ठभूमि';

  @override
  String get bookSettingsTextColor => 'पाठ';

  @override
  String get bookFihristTitle => 'अनुक्रमणिका';

  @override
  String get bookFihristSureTab => 'सूरह';

  @override
  String get bookFihristCuzTab => 'पारा';

  @override
  String get bookFihristHizb => 'हिज़्ब';

  @override
  String bookFihristCuzLabel(String number) {
    return 'पारा $number';
  }

  @override
  String bookFihristHizbLabel(String number) {
    return 'हिज़्ब $number';
  }

  @override
  String get bookFihristSearchSure => 'सूरह का नाम या संख्या खोजें';

  @override
  String get bookFihristSearchCuz => 'पारा संख्या खोजें';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get langCode => 'hi';
}
