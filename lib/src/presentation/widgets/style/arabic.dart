import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_reader/src/core/assets/quran_reader_assets.dart';

import '../../provider/book_read_provider.dart';
import '../reading_settings/color/reading_theme_manager.dart';

// Ayet numarası parantez deseni: ﴿١﴾ veya ١﴾ (sure başlığındaki format)
final _verseNumberRegex = RegExp(r'﴿?[\u0660-\u0669]+﴾');

// Hizb + secde inline badge deseni
// Hizb: «حزب ١» … «حزب ٤»  |  Secde: «سجدة»
final _inlineBadgeRegex = RegExp(r'«(?:حزب [١٢٣٤]|سجدة)»');

// Vakıf (durak) işaretleri — her biri ayrı WidgetSpan olarak render edilir.
// U+06D6 ۖ  لا  Durma (geç)
// U+06D7 ۗ  (diğer durak formu)
// U+06D8 ۘ  م   Lâzım (alternatif form)
// U+06D9 ۙ  وصل Geçme/bağla (vasıl)
// U+06DA ۚ  ج   Câiz
// U+06DB ۛ  ز   Mücevvez
// U+06DC ۜ  ط   (kuran.ttf: hightah)
// U+06DF ۟  ع   (kuran.ttf: highain) — ayet sonu durak
// U+06E0 ۠  (kuran.ttf: highqaf.feh) ← baseline'da render edildiği için WidgetSpan gerekir
// U+06E2 ۢ  (diğer)
final _vakifMarkRegex = RegExp(r'[\u06D6-\u06DC\u06DF\u06E0\u06E2]');

// Tecvid kümesi (U+06ED imâle / idğâm işareti) sonrası gelen vakıf işaretleri
// kelimenin ortasında kalır; WidgetSpan ile ayrılırsa harf birleşimi bozulur.
const _tajweedClusterMark = 0x06ED; // Arabic Small High Meem (lowmeem)
const _subscriptAlefMark =
    0x06EA; // Arabic Empty Centre Low Stop (subscriptalef)
const _baselineVakifMark =
    0x06E0; // WidgetSpan ile üst hizaya alınması gereken işaret

/// Vakıf işaretinin anlamsal türü.
enum WaqfType {
  lazim, // ع  — ayet sonu durak    (U+06DF, kuran.ttf: highain; U+06D8)
  mutlak, // U+06E0 — baseline sorunu olan işaret
  caiz, // ج  — durmak/geçmek serb.(U+06DA)
  mucevvez, // ز  — geçmek evla        (U+06DB)
  murahhas, // ط  — kelime arası durak (U+06DC, kuran.ttf: hightah)
  durma, // لا — durma (geç)        (U+06D6, U+06D7)
  vasl, //     geçme/bağla (vasıl) (U+06D9)
  other,
}

/// Vakıf işaretinin satır tepesine WidgetSpan olarak çıkarılıp
/// çıkarılmayacağını belirler.
///
/// Mushaf metninde bazı vakıf işaretleri kelime ortasında yer alır
/// (ör. imâle: `مَجْرٰۭۙيهَا`). Bunlar normal metin akışında kalmalıdır;
/// aksi hâlde Kuran fontu harf birleşimini doğru üretemez.
bool _isVakifMarkCodeUnit(int codeUnit) =>
    (codeUnit >= 0x06D6 && codeUnit <= 0x06E2);

bool _isWordBoundaryVakif(String input, int index) {
  if (index > 0 && input.codeUnitAt(index - 1) == _tajweedClusterMark) {
    return false;
  }
  // Ardışık vakıf çiftleri (ör. 33:60 `ۚۛ`) birlikte kalmalı; aksi hâlde
  // ikinci işaret ayrı span'e düşer ve üst üste binerek okunmaz hale gelir.
  if (index > 0 && _isVakifMarkCodeUnit(input.codeUnitAt(index - 1))) {
    return false;
  }

  if (index + 1 >= input.length) return true;

  final next = input.codeUnitAt(index + 1);

  // Boşluk ve ayraçlar — kelime sonu
  if (next <= 0x20 || next == 0x7C || next == 0x40 || next == 0x23) {
    return true;
  }
  // Ayet numarası parantezleri ﴿ ﴾
  if (next == 0xFD3E || next == 0xFD3F) return true;
  // ۪ (subscript alef) — vakıf kelime sonunda, sonraki harf eki
  if (next == _subscriptAlefMark) return true;
  // Tecvid / vakıf kümesi devam ediyor
  if (next >= 0x06D6 && next <= _tajweedClusterMark) return false;
  // Arapça harf — kelime ortası (ör. majreha: ...ۙي...)
  if ((next >= 0x0621 && next <= 0x064A) || next == 0x0670 || next == 0x06E8) {
    return false;
  }

  return true;
}

/// Metin parçasının sonundaki ardışık vakıf kümesini döndürür.
/// Örn. `…قَلِيلًاۚۛ ` → `ۚۛ`
String? _trailingVakifCluster(String text) {
  final trimmed = text.replaceFirst(RegExp(r'\s+$'), '');
  if (trimmed.isEmpty) return null;

  var start = trimmed.length;
  while (start > 0 && _isVakifMarkCodeUnit(trimmed.codeUnitAt(start - 1))) {
    start--;
  }
  if (start == trimmed.length) return null;
  return trimmed.substring(start);
}

void _appendTextChunk(
  List<InlineSpan> spans,
  String text,
  TextStyle baseStyle,
  TextStyle verseStyle,
) {
  if (text.isEmpty) return;

  final trailingMarks = _trailingVakifCluster(text);
  if (trailingMarks == null) {
    spans.add(TextSpan(text: text, style: baseStyle));
    return;
  }

  final trimmed = text.replaceFirst(RegExp(r'\s+$'), '');
  final trailingSpace = text.substring(trimmed.length);
  final baseText = trimmed.substring(0, trimmed.length - trailingMarks.length);

  if (baseText.isNotEmpty) {
    spans.add(TextSpan(text: baseText, style: baseStyle));
  }
  spans.add(
    TextSpan(text: trailingMarks, style: verseStyle.copyWith(height: 1.0)),
  );
  if (trailingSpace.isNotEmpty) {
    spans.add(TextSpan(text: trailingSpace, style: baseStyle));
  }
}

WaqfType _waqfTypeOf(String ch) {
  switch (ch.codeUnitAt(0)) {
    case 0x06D6:
    case 0x06D7:
      return WaqfType.durma;
    case 0x06D8:
    case 0x06DF:
      return WaqfType.lazim;
    case 0x06D9:
      return WaqfType.vasl;
    case 0x06DA:
      return WaqfType.caiz;
    case 0x06DB:
      return WaqfType.mucevvez;
    case 0x06DC:
      return WaqfType.murahhas;
    case 0x06E0:
      return WaqfType.mutlak;
    default:
      return WaqfType.other;
  }
}

class ArabicText extends StatelessWidget {
  final String text;
  final String meal;
  const ArabicText({super.key, required this.text, required this.meal});

  /// Vakıf işaretini satır tepesinde konumlandırılmış [WidgetSpan] olarak üretir.
  ///
  /// [PlaceholderAlignment.top] sayesinde tüm vakıf işaretleri — özellikle
  /// Kuran fontunda baseline'da render edilen ط (U+06E0) — satırın üst
  /// kesimine hizalanır ve son harfin harekesiyle üst üste gelmez.
  WidgetSpan _buildVakifMarkSpan(
    String mark,
    TextStyle baseStyle,
    double fontScale,
  ) {
    final type = _waqfTypeOf(mark);
    return WidgetSpan(
      alignment: PlaceholderAlignment.top,
      child: Text(
        mark,
        semanticsLabel: type.name,
        style: baseStyle.copyWith(height: 1.0, fontSize: 16),
        textDirection: TextDirection.rtl,
      ),
    );
  }

  /// Hizb ve secde için ortak küçük badge container'ı.
  Widget _buildSmallBadgeContainer(
    String label,
    Color base, {
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: base.withValues(alpha: isDark ? 0.15 : 0.10),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: base.withValues(alpha: isDark ? 0.50 : 0.45),
          width: 0.5,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: QuranReaderAssets.quranFontFamily,
          package: QuranReaderAssets.package,
          fontSize: 10,
          color: base.withValues(alpha: isDark ? 0.85 : 1.0),
          height: 1.2,
        ),
      ),
    );
  }

  /// Secde badge'ini inline WidgetSpan olarak oluşturur.
  /// PlaceholderAlignment.top + Transform ile satırın üstüne taşınır.
  WidgetSpan _buildSajdaBadgeSpan({required bool isDark}) {
    final base = ReadingThemeManager.secdePalettes
        .firstWhere((c) => c.isDark == isDark)
        .color;

    return WidgetSpan(
      alignment: PlaceholderAlignment.top,
      child: Transform.translate(
        offset: const Offset(0, -14),
        child: _buildSmallBadgeContainer('سجدة', base, isDark: isDark),
      ),
    );
  }

  /// Hizb işaretini metnin sağ üstünde küçük bir etiket olarak oluşturur.
  /// RichText akışına dahil edilmez; Stack + Positioned ile overlay render edilir.
  Widget _buildHizbOverlay(String label, {required bool isDark}) {
    final base = ReadingThemeManager.hizbPalettes
        .firstWhere((c) => c.isDark == isDark)
        .color;

    return _buildSmallBadgeContainer(label, base, isDark: isDark);
  }

  List<InlineSpan> _buildSpans(
    String input,
    TextStyle baseStyle,
    TextStyle verseStyle,
    Brightness brightness,
    double fontScale,
  ) {
    final spans = <InlineSpan>[];

    // Tüm eşleşmeleri (ayet no + secde badge + vakıf işaretleri) konuma göre sırala.
    // Hizb badge'leri burada işlenmez; build() metodunda overlay olarak render edilir.
    final allMatches = [
      ..._verseNumberRegex.allMatches(input),
      ..._inlineBadgeRegex.allMatches(input),
      ..._vakifMarkRegex
          .allMatches(input)
          .where((m) => _isWordBoundaryVakif(input, m.start)),
    ]..sort((a, b) => a.start.compareTo(b.start));

    final isDark = brightness == Brightness.dark;

    int lastEnd = 0;
    for (final match in allMatches) {
      if (match.start > lastEnd) {
        _appendTextChunk(
          spans,
          input.substring(lastEnd, match.start),
          baseStyle,
          verseStyle,
        );
      }

      final matchText = match.group(0)!;
      if (_inlineBadgeRegex.hasMatch(matchText)) {
        final label = matchText.replaceAll('«', '').replaceAll('»', '').trim();
        // Yalnızca secde inline badge olarak eklenir; hizb overlay ile gösterilir.
        if (label == 'سجدة') {
          spans.add(_buildSajdaBadgeSpan(isDark: isDark));
        }
      } else if (_vakifMarkRegex.hasMatch(matchText)) {
        // Vakıf işaretlerini WidgetSpan ile ayırmak OpenType birleşimini bozar;
        // aynı satırda birden fazla işaret olduğunda (ör. 17:100) kelime-işaret
        // eşleşmesi ters görünür. Yalnızca baseline sorunu olan U+06E0 ayrılır.
        if (matchText.codeUnitAt(0) == _baselineVakifMark) {
          spans.add(_buildVakifMarkSpan(matchText, verseStyle, fontScale));
        } else {
          spans.add(
            TextSpan(text: matchText, style: verseStyle.copyWith(height: 1.0)),
          );
        }
      } else {
        spans.add(TextSpan(text: matchText, style: verseStyle));
      }

      lastEnd = match.end;
    }

    if (lastEnd < input.length) {
      _appendTextChunk(spans, input.substring(lastEnd), baseStyle, verseStyle);
    }

    return spans.isEmpty ? [TextSpan(text: input, style: baseStyle)] : spans;
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Consumer<BookReadProvider>(
      builder: (context, provider, child) {
        final isDark = brightness == Brightness.dark;
        final baseStyle = TextStyle(
          color: provider.getTextColor(),
          fontFamily: QuranReaderAssets.quranFontFamily,
          package: QuranReaderAssets.package,
          height: provider.getLineSpacing(),
          locale: const Locale("ar"),
        );
        final verseStyle = baseStyle.copyWith(
          color: provider.getVerseNumberColor(),
        );
        final fontScale = provider.getFontScale();

        // Metnin başındaki hizb badge'ini tespit et ve metinden ayır.
        // Satır akışını bozmamak için overlay olarak render edilecek.
        final hizbMatch = _inlineBadgeRegex.firstMatch(text);
        String? hizbLabel;
        String mainText = text;

        if (hizbMatch != null && hizbMatch.start == 0) {
          final rawLabel = hizbMatch
              .group(0)!
              .replaceAll('«', '')
              .replaceAll('»', '')
              .trim();
          if (rawLabel != 'سجدة') {
            hizbLabel = rawLabel;
            mainText = text.substring(hizbMatch.end);
            if (mainText.startsWith(' ')) mainText = mainText.substring(1);
          }
        }

        final richText = RichText(
          text: TextSpan(
            children: _buildSpans(
              mainText,
              baseStyle,
              verseStyle,
              brightness,
              fontScale,
            ),
          ),
          textAlign: provider.getTextAlignment(),
          textScaler: TextScaler.linear(fontScale),
          textDirection: TextDirection.rtl,
        );

        if (hizbLabel != null) {
          // Hizb badge'i metnin sağ üstüne küçük superscript olarak konumlanır.
          // clipBehavior: Clip.none sayesinde satırlar arası boşluğa taşabilir.
          return Container(
            alignment: Alignment.center,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                richText,
                Positioned(
                  top: -14,
                  right: 0,
                  child: _buildHizbOverlay(hizbLabel, isDark: isDark),
                ),
              ],
            ),
          );
        }

        return Container(alignment: Alignment.center, child: richText);
      },
    );
  }
}
