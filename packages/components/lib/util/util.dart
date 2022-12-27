import 'dart:io';
import 'package:components/custom/curruncy.dart';

// import 'package:onyxsio/onyxsio.dart';

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
  static const String heart = 'assets/icons/heart.svg';
}

class Utils {
  static currency({name, amount}) => CurrencyFormat.simpleCurrency(
        locale: Platform.localeName,
        name: name,
        customPattern: '\u00a4 #,###', //
      ).format(amount);
}
