import 'package:flutter/material.dart';

class Validation extends ChangeNotifier {
  bool isvalid = true;
  void validation(bool index) => isvalid = index;
}
