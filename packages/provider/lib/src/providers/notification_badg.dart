import 'package:flutter/material.dart';

class NotificationBadge extends ChangeNotifier {
  bool badge = false;
  void setValue(bool value) => badge = value;
}
