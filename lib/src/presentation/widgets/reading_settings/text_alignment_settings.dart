import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/book_read_provider.dart';

class TextAlignmentSettings extends StatelessWidget {
  const TextAlignmentSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Selector<BookReadProvider, TextAlign>(
      selector: (context, provider) => provider.getTextAlignment(),
      builder: (context, currentAlignment, child) {
        return Container(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: scheme.outline.withValues(alpha: 0.15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 16,
            children: [
              _AlignmentButton(
                icon: Icons.format_align_justify,
                alignment: TextAlign.justify,
                currentAlignment: currentAlignment,
                onTap: () => _updateAlignment(context, TextAlign.justify),
              ),
              _AlignmentButton(
                icon: Icons.format_align_center,
                alignment: TextAlign.center,
                currentAlignment: currentAlignment,
                onTap: () => _updateAlignment(context, TextAlign.center),
              ),
              _AlignmentButton(
                icon: Icons.format_align_right,
                alignment: TextAlign.right,
                currentAlignment: currentAlignment,
                onTap: () => _updateAlignment(context, TextAlign.right),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateAlignment(BuildContext context, TextAlign alignment) {
    context.read<BookReadProvider>().saveTextAlignment(alignment);
  }
}

class _AlignmentButton extends StatelessWidget {
  const _AlignmentButton({
    required this.icon,
    required this.alignment,
    required this.currentAlignment,
    required this.onTap,
  });

  final IconData icon;
  final TextAlign alignment;
  final TextAlign currentAlignment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = alignment == currentAlignment;
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? scheme.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isSelected
              ? scheme.onPrimaryContainer
              : scheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}
