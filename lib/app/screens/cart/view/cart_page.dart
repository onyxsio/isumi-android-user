import 'package:flutter/material.dart';
import 'package:isumi/app/screens/cart/widgets/item_list.dart';
import 'package:onyxsio/onyxsio.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading = false;
  List<Cart> carts = [];

  String quantity = '0';
  @override
  void initState() {
    refreshCartData();
    super.initState();
  }

  Future refreshCartData() async {
    setState(() => isLoading = true);
    carts = await SQFLiteDB.readAllData();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(text: 'Shopping Cart'),
      body: isLoading
          ? const Center(child: HRDots())
          : carts.isEmpty
              ? Center(
                  child: Text(
                    'Your Shopping Cart Is Empty.',
                    style: TxtStyle.b8,
                  ),
                )
              : _buildItemList(),
      bottomNavigationBar: carts.isEmpty
          ? null
          : bottomNavigationBar(
              onTap: () => Navigator.pushNamed(context, '/OrderStatusPage'),
              text: 'Proceed to checkout'),
    );
  }

  Widget _buildItemList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: carts.length,
      padding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 0),
      itemBuilder: (context, index) {
        return ItemListView(cart: carts[index], onDelete: refreshCartData);
      },
    );
  }
}
