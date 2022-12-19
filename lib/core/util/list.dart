import 'package:flutter/material.dart';
import 'package:isumi/app/screens/cart/view/cart_page.dart';
import 'package:isumi/app/screens/home/home_page.dart';
import 'package:isumi/app/screens/order/view/order_page.dart';
import 'package:isumi/app/screens/profile/view/profile_page.dart';

List<Widget> mainPages = [
  const HomePage(),
  const OrderPage(),
  const CartPage(),
  const ProfilePage(),
  Container(color: Colors.blue),
];
List<String> currencyList = ["USD", "JPY", "LKR"];
List<String> weightUnitList = ["kg", "g", "oz", 'lbs'];
