import 'package:flutter/material.dart';

/// Bottom sheet boyutlarını ekran yönüne göre hesaplar.
abstract final class ResponsiveBottomSheetConstraints {
  static const _landscapeMaxWidth = 420.0;

  static BoxConstraints of(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final isLandscape = size.width > size.height;
    final horizontalPadding = mediaQuery.padding.horizontal;

    if (isLandscape) {
      final maxWidth = (_landscapeMaxWidth).clamp(
        320.0,
        size.width - horizontalPadding,
      );
      return BoxConstraints(
        maxWidth: maxWidth,
        maxHeight: size.height - mediaQuery.padding.vertical - 16,
      );
    }

    return BoxConstraints(
      maxWidth: size.width,
      maxHeight: size.height * 0.85,
    );
  }

  /// Kısa içerikli bottom sheet'ler (navigasyon vb.) için.
  static BoxConstraints compact(
    BuildContext context, {
    double? heightFraction,
  }) {
    final base = of(context);
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final isLandscape = mediaQuery.size.width > height;
    final fraction = heightFraction ?? (isLandscape ? 0.42 : 0.28);

    return BoxConstraints(
      maxWidth: base.maxWidth,
      maxHeight: height * fraction,
    );
  }

  static bool isLandscape(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.width > size.height;
  }
}

class BottomSheetBase extends StatelessWidget {
  const BottomSheetBase({
    super.key,
    required this.child,
    this.height,
    this.backgroundColor,
  });
  final Widget child;
  final double? height;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final isLandscape = ResponsiveBottomSheetConstraints.isLandscape(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: isLandscape
            ? BorderRadius.circular(20)
            : const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(
          top: BorderSide(color: Colors.deepOrange, width: 4),
        ),
      ),
      child: child,
    );
  }
}
