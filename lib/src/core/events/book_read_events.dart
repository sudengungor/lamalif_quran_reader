import 'package:flutter/material.dart';

typedef BookReadEventCallback = void Function(String event);

/// [BookReadView] içindeki kullanıcı etkileşimleri için event adları.
abstract final class BookReadEvents {
  static const viewOpen = 'quran_view_open';
  static const back = 'quran_back';
  static const fihristOpen = 'quran_fihrist_open';
  static const fihristSureTab = 'quran_fihrist_sure_tab';
  static const fihristCuzTab = 'quran_fihrist_cuz_tab';
  static const fihristSectionSelect = 'quran_fihrist_section_select';
  static const settingsOpen = 'quran_settings_open';
  static const fontSizeDecrease = 'quran_font_size_decrease';
  static const fontSizeIncrease = 'quran_font_size_increase';
  static const lineSpacingDecrease = 'quran_line_spacing_decrease';
  static const lineSpacingIncrease = 'quran_line_spacing_increase';
  static const goToPage = 'quran_go_to_page';
  static const textColorChanged = 'quran_text_color_changed';
  static const mealEnabled = 'quran_meal_enabled';
  static const mealDisabled = 'quran_meal_disabled';
}

class BookReadEventScope extends InheritedWidget {
  const BookReadEventScope({
    super.key,
    required this.onEvent,
    required super.child,
  });

  final BookReadEventCallback? onEvent;

  static BookReadEventScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BookReadEventScope>();
  }

  void notify(String event) => onEvent?.call(event);

  @override
  bool updateShouldNotify(BookReadEventScope oldWidget) =>
      onEvent != oldWidget.onEvent;
}

extension BookReadEventContext on BuildContext {
  void bookReadEvent(String event) {
    BookReadEventScope.maybeOf(this)?.notify(event);
  }
}
