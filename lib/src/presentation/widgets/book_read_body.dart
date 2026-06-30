import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../provider/book_read_provider.dart';
import 'divider.dart';
import 'text_parser.dart';

class BookReadBody extends StatefulWidget {
  const BookReadBody({super.key});

  @override
  State<BookReadBody> createState() => _BookReadBodyState();
}

class _BookReadBodyState extends State<BookReadBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookReadProvider>().loadBookData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookReadProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        return FutureBuilder<List<String>>(
          future: provider.bookDataFuture,
          builder: (context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.hasData) {
              return ScrollablePositionedList.separated(
                itemCount: snapshot.data!.length,
                itemScrollController: provider.itemScrollController,
                itemPositionsListener: provider.itemPositionsListener,
                padding: EdgeInsets.symmetric(
                  horizontal: provider.getPadding(),
                ),
                initialScrollIndex: provider.currentPage,
                initialAlignment: provider.getAlignment(),
                separatorBuilder: (context, index) {
                  // Aynı fiziksel sayfada iki item varsa (sure bölünmesi)
                  // aralarında sayfa çizgisi gösterme.
                  final pages = provider.itemPageNumbers;
                  if (pages.isNotEmpty) {
                    final nextIdx = index + 1;
                    if (nextIdx < pages.length &&
                        pages[index] == pages[nextIdx]) {
                      return const SizedBox(height: 20);
                    }
                    final pageNum = nextIdx < pages.length
                        ? pages[nextIdx]
                        : pages.last;
                    return AppDivider(pageNumber: pageNum);
                  }
                  return AppDivider(
                    pageNumber: index + 1 + provider.selectedBook.firstPage,
                  );
                },
                itemBuilder: (context, index) =>
                    RisaleTextParser(text: snapshot.data![index]),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          },
        );
      },
    );
  }
}
