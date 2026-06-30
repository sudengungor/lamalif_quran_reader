import 'package:flutter/material.dart';

import 'fihrist_drawer_colors.dart';

/// Cüz altındaki hizb bölümlerini açıp kapatan buton.
class ExpandButton extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onTap;

  const ExpandButton({
    super.key,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = FihristDrawerTheme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
            color: colors.expandIcon,
            size: 20,
          ),
        ),
      ),
    );
  }
}
