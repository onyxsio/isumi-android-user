import 'package:flutter/material.dart';
import 'package:isumi/app/screens/cart/widgets/item_list.dart';
import 'package:onyxsio/onyxsio.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(text: 'My cart'),
      body: const CartListView(),
      bottomNavigationBar: bottomNavigationBar(
          onTap: () => Navigator.pushNamed(context, '/OrderStatusPage'),
          text: 'Send order'),
    );
  }
}
