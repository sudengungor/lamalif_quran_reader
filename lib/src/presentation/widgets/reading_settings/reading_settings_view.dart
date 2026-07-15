import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_reader/src/core/events/book_read_events.dart';
import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';
import 'package:quran_reader/src/presentation/widgets/bottom_sheet_base.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/background_color_settings.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/fontsize_settings.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/go_to_page_dialog.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/line_spacing_settings.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/reading_settings_card.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/reading_settings_theme.dart';
import 'package:quran_reader/src/presentation/widgets/reading_settings/text_color_settings.dart';
import 'package:quran_reader/src/presentation/widgets/sheet_title.dart';

class ReadingSettingsView extends StatelessWidget {
  const ReadingSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.quranL10n;

    return Consumer<BookReadProvider>(
      builder: (context, provider, _) {
        final showMeal = l10n.langCode == 'tr';
        final bottomInset = MediaQuery.paddingOf(context).bottom;

        return BottomSheetBase(
          backgroundColor: provider.getBackgroundColor(),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: bottomInset + 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomSheetTitle(title: l10n.settingsTitle),
                ReadingSettingsCard(
                  type: ReadingSettingsCardType.top,
                  icon: Icons.format_size_rounded,
                  title: l10n.bookSettingsFontSize,
                  child: const FontsizeSettings(),
                ),
                const CardDivider(),
                ReadingSettingsCard(
                  icon: Icons.format_line_spacing,
                  title: l10n.bookSettingsLineSpacing,
                  type: ReadingSettingsCardType.middle,
                  child: const LineSpacingSettings(),
                ),
                const CardDivider(),
                Selector<BookReadProvider, Color>(
                  selector: (_, provider) => provider.getTextColor(),
                  builder: (context, textColor, _) => ReadingSettingsCard(
                    icon: Icons.menu_book_outlined,
                    title: l10n.bookGoPage,
                    type: showMeal
                        ? ReadingSettingsCardType.middle
                        : ReadingSettingsCardType.bottom,
                    onTap: () async {
                      final navigated = await showGoToPageDialog(context);
                      if (!navigated || !context.mounted) return;
                      context.bookReadEvent(BookReadEvents.goToPage);
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(
                      height: 36,
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: textColor.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ),
                if (showMeal) ...[
                  const CardDivider(),
                  Consumer<BookReadProvider>(
                    builder: (context, provider, _) => ReadingSettingsCard(
                      icon: Icons.translate_rounded,
                      title: l10n.bookSettingsMeal,
                      type: ReadingSettingsCardType.bottom,
                      child: Switch.adaptive(
                        value: provider.getMealEnabled(),
                        onChanged: (_) async {
                          await provider.toggleMeal();
                          if (!context.mounted) return;
                          context.bookReadEvent(
                            provider.getMealEnabled()
                                ? BookReadEvents.mealEnabled
                                : BookReadEvents.mealDisabled,
                          );
                        },
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                ReadingSettingsCard(
                  icon: Icons.format_color_fill_outlined,
                  type: ReadingSettingsCardType.top,
                  title: l10n.bookSettingsBackgroundColor,
                  stackControls: true,
                  child: const BackgroundColorSettings(),
                ),
                const CardDivider(),
                ReadingSettingsCard(
                  icon: Icons.color_lens_outlined,
                  type: ReadingSettingsCardType.bottom,
                  title: l10n.bookSettingsTextColor,
                  stackControls: true,
                  child: const TextColorSettings(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CardDivider extends StatelessWidget {
  const CardDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<BookReadProvider, (Color, bool)>(
      selector: (_, provider) =>
          (provider.getBackgroundColor(), provider.bgOption.isDark),
      builder: (context, data, _) {
        final (background, isDark) = data;
        return Divider(
          color: ReadingSettingsTheme.softBorder(background, isDark: isDark),
          height: 0,
        );
      },
    );
  }
}
