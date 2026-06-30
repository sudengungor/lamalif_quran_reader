# quran_reader

Bağımsız Kur'an okuma modülü. Fihrist navigasyonu, okuma ayarları ve meal desteği içerir.

## Kurulum

Host uygulamanızın `pubspec.yaml` dosyasına ekleyin:

```yaml
dependencies:
  quran_reader:
    path: modules/quran_reader
```

## Lokalizasyon

`MaterialApp` içinde paket delegate'lerini kaydedin:

```dart
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quran_reader/quran_reader.dart';

MaterialApp(
  localizationsDelegates: const [
    ...quranReaderLocalizationsDelegates,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: quranReaderSupportedLocales,
  // ...
)
```

## Provider kurulumu

```dart
MultiProvider(
  providers: [
    ...quranReaderProviders(
      sharedPreferences: sharedPreferences,
      analytics: myAnalytics, // opsiyonel
    ),
    // diğer provider'lar...
  ],
  child: MyApp(),
)
```

## Kullanım

```dart
import 'package:quran_reader/quran_reader.dart';

// Okuma ekranı
Navigator.push(context, MaterialPageRoute(builder: (_) => const BookReadView()));

// Ana sayfa butonu
OpenQuranButton(onTap: () => Navigator.push(...));
```

## Asset yolları

Paket içi asset'ler `QuranReaderAssets` sınıfı üzerinden yönetilir:

- `packages/quran_reader/assets/data/quran/kuran.txt`
- `packages/quran_reader/assets/images/quran.png`

Host uygulamada ek asset tanımı gerekmez; paket kendi asset'lerini taşır.
