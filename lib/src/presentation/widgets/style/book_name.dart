import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/book_read_provider.dart';

/// Sure isminin stili için.
class SureNameText extends StatelessWidget {
  const SureNameText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Consumer<BookReadProvider>(
      builder: (context, provider, child) {
        return Container(
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center, // Metni ortala
            style: TextStyle(
              fontSize: 18,
              height: 1,
              color: provider.getIconColor(),
            ),
          ),
        );
      },
    );
  }
}
