import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';
import 'package:quran_reader/src/presentation/widgets/bottom_sheet_base.dart';
import 'package:quran_reader/src/presentation/widgets/fihrist_sections/drawer_bottom_section.dart';
import 'package:quran_reader/src/presentation/widgets/sheet_title.dart';
import 'package:quran_reader/src/presentation/widgets/slider/slider_book_page.dart';

class BookNavigationSlider extends StatelessWidget {
  const BookNavigationSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.quranL10n;

    return Consumer<BookReadProvider>(
      builder: (context, provider, child) {
        final bookFileLength = provider.bookFileLength;

        if (bookFileLength == null || bookFileLength <= 0) {
          return const SizedBox.shrink();
        }

        final sliderValue = (provider.currentPage / (bookFileLength - 1)).clamp(
          0.0,
          1.0,
        );

        return BottomSheetBase(
          backgroundColor: provider.getBackgroundColor(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomSheetTitle(title: l10n.bookNavigation),
                SizedBox(
                  height: 24,
                  child: Slider(
                    value: sliderValue,
                    min: 0.0,
                    max: 1.0,
                    padding: EdgeInsets.zero,
                    onChanged: provider.onTabSlider,
                    activeColor: provider.getTextColor(),
                    inactiveColor: provider.getTextColor().withValues(
                      alpha: 0.2,
                    ),
                  ),
                ),
                SliderBookPage(textColor: provider.getTextColor()),
                const SizedBox(height: 10),
                DrawerBottomSection(textColor: provider.getTextColor()),
              ],
            ),
          ),
        );
      },
    );
  }
}
