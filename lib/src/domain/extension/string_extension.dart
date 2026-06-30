import 'package:quran_reader/src/core/assets/quran_reader_assets.dart';

extension StringExtension on String {
  String get toFihristSure => QuranReaderAssets.fihristSure(this);
  String get toFihristCuz => QuranReaderAssets.fihristCuz(this);
}
