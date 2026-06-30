class Section {
  final String title;
  final int page;
  final int tabCount;
  List<Section> children = [];

  Section(this.title, [this.page = 0, this.tabCount = 1]);

  void add(Section section) {
    children.add(section);
  }
}

/// Satır başındaki girintiye göre derinlik seviyesini döner.
///
/// Tab karakterlerini (`\t`) ve boşluk gruplarını (4 boşluk = 1 seviye)
/// destekler; böylece farklı formatlardaki fihrist dosyaları doğru parse edilir.
int tabCount(String data) {
  int tabChars = 0;
  for (var i = 0; i < data.length; i++) {
    if (data[i] == '\t') {
      tabChars++;
    } else {
      break;
    }
  }
  if (tabChars > 0) return tabChars;

  int spaceChars = 0;
  for (var i = 0; i < data.length; i++) {
    if (data[i] == ' ') {
      spaceChars++;
    } else {
      break;
    }
  }
  return spaceChars ~/ 4;
}
