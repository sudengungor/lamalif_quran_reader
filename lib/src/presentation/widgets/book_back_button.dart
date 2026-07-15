import 'package:flutter/material.dart';

import 'package:quran_reader/src/core/events/book_read_events.dart';

class BookBackButton extends StatelessWidget {
  const BookBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.bookReadEvent(BookReadEvents.back);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back_ios_new_rounded),
    );
  }
}
