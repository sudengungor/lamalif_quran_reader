import 'package:flutter/material.dart';

import '../bottom_sheet_base.dart';
import 'book_navigation_slider.dart';

class BookNavigationActionIcon extends StatelessWidget {
  const BookNavigationActionIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          barrierColor: Colors.black.withValues(alpha: 0.25),
          useSafeArea: true,
          constraints: ResponsiveBottomSheetConstraints.compact(context),
          builder: (context) => BookNavigationSlider(),
        );
      },
      icon: const Icon(Icons.navigation_outlined),
    );
  }
}
