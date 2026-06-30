import 'package:flutter/material.dart';

class BookBackButton extends StatelessWidget {
  const BookBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back_ios_new_rounded),
    );
  }
}
