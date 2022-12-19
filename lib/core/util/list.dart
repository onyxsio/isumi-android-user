import 'package:flutter/material.dart';
import 'package:isumi/app/screens/cart/view/cart_page.dart';
import 'package:isumi/app/screens/delete_ths.dart';
import 'package:isumi/app/screens/home/home_page.dart';

List<Widget> mainPages = [
  const HomePage(),
  Container(color: Colors.red),
  const CartPage(),
  // const NotificationPage(),
  // const SettingsPage(),
  const DeleteThis(),
  Container(color: Colors.blue),
];
List<String> currencyList = ["USD", "JPY", "LKR"];
List<String> weightUnitList = ["kg", "g", "oz", 'lbs'];
