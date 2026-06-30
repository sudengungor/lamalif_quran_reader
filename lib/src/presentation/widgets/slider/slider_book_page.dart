import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quran_reader/src/core/extension/context_extension.dart';
import 'package:quran_reader/src/presentation/provider/book_read_provider.dart';

class SliderBookPage extends StatelessWidget {
  const SliderBookPage({super.key, this.textColor});

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BookReadProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Selector<BookReadProvider, String>(
          selector: (context, provider) =>
              provider.getCurrentPageForNavigation(),
          builder: (context, currentPage, child) {
            if (provider.isLoading) return const CircularProgressIndicator();

            return Text(
              currentPage,
              style: context.textTheme.bodyMedium?.copyWith(
                color: textColor ?? context.colorScheme.onSurface,
              ),
            );
          },
        ),
        Text(
          '${provider.bookPageLength}',
          style: context.textTheme.bodyMedium?.copyWith(
            color: textColor ?? context.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
