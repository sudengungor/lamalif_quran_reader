// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'quran_reader_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class QuranReaderLocalizationsId extends QuranReaderLocalizations {
  QuranReaderLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get bookNavTitle => 'Al-Qur\'an';

  @override
  String get bookEnterNumber => 'Masukkan angka...';

  @override
  String get bookGoPage => 'Ke Halaman';

  @override
  String get bookNavigation => 'Navigasi Halaman';

  @override
  String get bookError => 'Kesalahan';

  @override
  String get bookGo => 'Pergi';

  @override
  String get bookCancel => 'Batal';

  @override
  String bookPageShort(String page) {
    return 'hlm. $page';
  }

  @override
  String bookAppBarSubtitle(String cuz, String page) {
    return 'Juz $cuz · hlm. $page';
  }

  @override
  String get bookMealNotSpecified => 'Terjemahan belum ditentukan';

  @override
  String get bookSettingsFontSize => 'Ukuran Font';

  @override
  String get bookSettingsLineSpacing => 'Spasi Baris';

  @override
  String get bookSettingsMeal => 'Terjemahan';

  @override
  String get bookSettingsBackgroundColor => 'Latar Belakang';

  @override
  String get bookSettingsTextColor => 'Teks';

  @override
  String get bookFihristTitle => 'Daftar Isi';

  @override
  String get bookFihristSureTab => 'Surah';

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
  String get bookFihristSearchSure => 'Cari nama atau nomor surah';

  @override
  String get bookFihristSearchCuz => 'Cari nomor juz';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get langCode => 'id';
}
