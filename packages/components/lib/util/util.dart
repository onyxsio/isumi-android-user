import 'package:intl/intl.dart';

class AppCIcon {
  static const String menu = 'assets/icons/menu.svg';
  static const String backArrow = 'assets/icons/arrow-left.svg';
  static const String search = 'assets/icons/search.svg';
  static const String filter = 'assets/icons/filter.svg';
  static const String grid = 'assets/icons/grid.svg';
  static const String list = 'assets/icons/list.svg';
  static const String add = 'assets/icons/add.svg';
  static const String trash = 'assets/icons/trash.svg';
  static const String logo = 'assets/images/logo.png';
  // static const String camera = 'assets/icons/camera.svg';
}

class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}
