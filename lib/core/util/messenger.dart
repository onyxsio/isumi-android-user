import 'package:flutter/material.dart';

class AppMessenger {
  static showSnackBar({context, message}) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
