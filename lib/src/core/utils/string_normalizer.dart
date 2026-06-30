class StringNormalizer {
  static String normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll('ı', 'i')
        .replaceAll('ğ', 'g')
        .replaceAll('ü', 'u')
        .replaceAll('ş', 's')
        .replaceAll('ö', 'o')
        .replaceAll('ç', 'c')
        .replaceAll('İ', 'i')
        .trim();
  }

  static bool matches(String text1, String text2) {
    return normalize(text1) == normalize(text2);
  }

  static bool contains(String text, String search) {
    return normalize(text).contains(normalize(search));
  }

  static String normalizeForSearch(String text) {
    return text
        .trim()
        .replaceAll('İ', 'i')
        .replaceAll('I', 'i')
        .toLowerCase()
        .replaceAll("'", '')
        .replaceAll('ğ', 'g')
        .replaceAll('ü', 'u')
        .replaceAll('ş', 's')
        .replaceAll('ı', 'i')
        .replaceAll('ö', 'o')
        .replaceAll('ç', 'c')
        .replaceAll('â', 'a')
        .replaceAll('û', 'u')
        .replaceAll('î', 'i');
  }

  static String slugify(String text, {bool removeNumbers = false}) {
    text = normalizeForSearch(text);
    text = text.replaceAll(' ', '_');
    text = text.replaceAll('.', '_');
    text = text.replaceAll('-', '_');
    text = text.replaceAll('/', '_');
    if (removeNumbers) {
      text = text.replaceAll(RegExp(r'[0-9]'), '');
    }
    return text;
  }
}
