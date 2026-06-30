/// Asset paths for the [quran_reader] package.
abstract final class QuranReaderAssets {
  static const package = 'quran_reader';
  static const quranFontFamily = 'Kuran';

  static String quranText(String fileName) =>
      'packages/$package/assets/data/quran/$fileName.txt';

  static String fihristSure(String fileName) =>
      'packages/$package/assets/data/quran/fihrist_sure.txt';

  static String fihristCuz(String fileName) =>
      'packages/$package/assets/data/quran/fihrist_cuz.txt';

  static const coverImage = 'packages/$package/assets/images/quran.png';
}
