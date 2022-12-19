import 'package:flutter/material.dart';
import 'package:remote_data/remote_data.dart';

class SelectedList extends ChangeNotifier {
  List<Product> selectedItems = [];
  void add(Product value) => selectedItems.add(value);
  void remove(Product value) => selectedItems.remove(value);
}

class ScanPageProvider extends ChangeNotifier {
  final PageController controller = PageController();

  void jumpTo(int index) => controller.jumpToPage(index);
}
