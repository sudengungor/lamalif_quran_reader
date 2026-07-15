import 'package:flutter/material.dart';

import 'package:quran_reader/src/core/events/book_read_events.dart';
import 'package:quran_reader/src/l10n/quran_reader_l10n_extension.dart';
import 'package:quran_reader/src/presentation/widgets/fihrist_sections/fihrist_drawer_colors.dart';

class DrawerTabBar extends StatelessWidget {
  const DrawerTabBar({super.key, required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final colors = FihristDrawerTheme.of(context);
    final l10n = context.quranL10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: colors.tabBarBackground,
          borderRadius: BorderRadius.circular(999),
        ),
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Row(
              children: [
                _TabSegment(
                  label: l10n.bookFihristSureTab,
                  isSelected: controller.index == 0,
                  onTap: () => _selectTab(context, controller, 0),
                ),
                _TabSegment(
                  label: l10n.bookFihristCuzTab,
                  isSelected: controller.index == 1,
                  onTap: () => _selectTab(context, controller, 1),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _selectTab(BuildContext context, TabController controller, int index) {
    if (controller.index == index) return;
    controller.animateTo(index);
    context.bookReadEvent(
      index == 0 ? BookReadEvents.fihristSureTab : BookReadEvents.fihristCuzTab,
    );
  }
}

class _TabSegment extends StatelessWidget {
  const _TabSegment({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = FihristDrawerTheme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: isSelected ? colors.tabActiveBackground : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isSelected ? colors.tabActiveText : colors.tabInactiveText,
            ),
          ),
        ),
      ),
    );
  }
}
