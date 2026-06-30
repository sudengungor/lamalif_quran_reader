import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/book_read_provider.dart';
import 'settings_control_card.dart';

class PaddingSettings extends StatelessWidget {
  const PaddingSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsControlCard(
      onDecrease: () {
        final provider = context.read<BookReadProvider>();
        final currentPadding = provider.getPadding();
        if (currentPadding > 0) {
          provider.savePadding(currentPadding - 2);
        }
      },
      onIncrease: () {
        final provider = context.read<BookReadProvider>();
        final currentPadding = provider.getPadding();
        if (currentPadding < 50) {
          provider.savePadding(currentPadding + 2);
        }
      },
    );
  }
}
