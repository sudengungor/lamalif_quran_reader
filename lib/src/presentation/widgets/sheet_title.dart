import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/book_read_provider.dart';

class BottomSheetTitle extends StatelessWidget {
  const BottomSheetTitle({super.key, required this.title, this.textColor});
  final String title;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color:
                  textColor ?? context.read<BookReadProvider>().getTextColor(),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color:
                  textColor ?? context.read<BookReadProvider>().getTextColor(),
            ),
          ),
        ],
      ),
    );
  }
}
