import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/book_read_provider.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, required this.pageNumber});
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return Consumer<BookReadProvider>(
      builder: (context, provider, child) {
        return Row(
          children: [
            _BookDivider(color: provider.getIconColor()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  "\n$pageNumber\n",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: provider.getIconColor(),
                  ),
                ),
              ),
            ),
            _BookDivider(color: provider.getIconColor()),
          ],
        );
      },
    );
  }
}

class _BookDivider extends StatelessWidget {
  const _BookDivider({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Divider(color: color, height: 0, thickness: 0.3));
  }
}
