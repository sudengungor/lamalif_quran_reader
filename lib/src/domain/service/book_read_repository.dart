import 'package:flutter/services.dart';

import 'package:quran_reader/src/core/assets/quran_reader_assets.dart';
import 'package:quran_reader/src/domain/extension/string_extension.dart';
import 'package:quran_reader/src/domain/model/book.dart';
import 'package:quran_reader/src/domain/model/drawer_component.dart';

final class BookReadRepository {
  static const _hizbSplitMarkers = {
    'ڛ': '«حزب ١»',
    'ڝ': '«حزب ٢»',
    'ڞ': '«حزب ٣»',
    'ڟ': '«حزب ٤»',
  };

  static const _inlineMarkers = {
    'ښ': '«سجدة»',
  };

  Future<({List<String> items, List<int> pageNumbers})> getBookData(
    Book book,
  ) async {
    var rawData = await rootBundle.loadString(
      QuranReaderAssets.quranText(book.fileName),
    );

    _hizbSplitMarkers.forEach((marker, label) {
      rawData = rawData.replaceAll(marker, '|@\n~$label ');
    });
    _inlineMarkers.forEach((marker, label) {
      rawData = rawData.replaceAll(marker, label);
    });
    rawData = rawData.replaceAll('ۭۗ ', 'ۭۗ\u00A0');
    rawData = rawData.replaceAll('~|@', '');

    final rawPages = rawData.split('#');
    final items = <String>[];
    final pageNumbers = <int>[];

    for (final rawPage in rawPages) {
      final pageNumMatch = RegExp(r'^(\d+)').firstMatch(rawPage);
      final pageNum = int.tryParse(pageNumMatch?.group(1) ?? '') ?? 0;

      final parts = rawPage.split(RegExp(r'\n(?=<\d+-|~«حزب)'));

      for (int i = 0; i < parts.length; i++) {
        final itemText = i == 0 ? parts[i] : '$pageNum\n${parts[i]}';
        final strippedContent = itemText
            .replaceFirst(RegExp(r'^\d+'), '')
            .trim();
        if (strippedContent.isEmpty) continue;
        items.add(itemText);
        pageNumbers.add(pageNum);
      }
    }

    return (items: items, pageNumbers: pageNumbers);
  }

  Future<List<Section>> getFihristData(Book book) async {
    return _groupSections(
      await _loadSections(book.fileName.toFihristSure),
    );
  }

  Future<List<Section>> getFihristCuzData(Book book) async {
    return _groupSections(
      await _loadSections(book.fileName.toFihristCuz),
    );
  }

  Future<List<Section>> _loadSections(String filePath) async {
    final data = await rootBundle.loadString(filePath);
    final lines = data.split('\n');
    final sections = <Section>[];

    for (final element in lines) {
      final item = element.split('|');
      final title = item[0].split('@')[0];
      final section = Section(
        title.trim(),
        int.tryParse(item[1]) ?? 0,
        tabCount(item[0]),
      );
      sections.add(section);
    }

    return sections;
  }

  Future<List<Section>> _groupSections(List<Section> sections) async {
    if (sections.isEmpty) return [];

    final root = <Section>[];
    final stack = <Section>[];

    for (final section in sections) {
      while (stack.isNotEmpty && stack.last.tabCount >= section.tabCount) {
        stack.removeLast();
      }
      if (stack.isNotEmpty) {
        stack.last.add(section);
      } else {
        root.add(section);
      }
      stack.add(section);
    }

    return root;
  }
}
