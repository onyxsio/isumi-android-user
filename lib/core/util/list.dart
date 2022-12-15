import 'package:flutter/material.dart';
import 'package:isumi/app/screens/cart/view/cart_page.dart';
import 'package:isumi/app/screens/home/home_page.dart';

List<Widget> mainPages = [
  const HomePage(),
  const CartPage(),
  // const NotificationPage(),
  // const SettingsPage(),
  Container(color: Colors.red),
  Container(color: Colors.blue),
];
List<String> currencyList = ["USD", "JPY", "LKR"];
List<String> weightUnitList = ["kg", "g", "oz", 'lbs'];
