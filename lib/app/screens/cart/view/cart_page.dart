// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:isumi/app/screens/cart/widgets/item_list.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final user = auth.FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(text: 'Shopping Cart'),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FireRepo.customerDB.doc(user!.uid).collection('cart').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: HRDots());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: HRDots());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Your Shopping Cart Is Empty.', style: TxtStyle.b8),
            );
          }

          return _buildItemList(snapshot.data!.docs);
        },
      ),
    );
  }

  Widget _buildItemList(items) {
    return Stack(
      children: [
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: items.length,
          padding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 0),
          itemBuilder: (context, index) {
            return FocusedMenuHolder(
                menuContent: menuContent(items[index].id),
                child: ItemListView(cart: items[index]));
          },
        ),
        if (!items.isEmpty)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            // alignment: Alignment.bottomCenter,
            child: bottomNavigationBar(
                onTap: () => Navigator.pushNamed(context, '/OrderStatusPage',
                    arguments: items),
                text: 'Proceed to checkout'),
          )
      ],
    );
  }

  Widget menuContent(String id) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: GestureDetector(
          onTap: () async {
            await _buildDialog(id).then((_) => Navigator.pop(context));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(AppIcon.trash, color: AppColor.error),
              SizedBox(width: 2.w),
              Text('Delete', style: TxtStyle.itemDelete),
            ],
          )),
    );
  }

  _buildDialog(String id) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Confirmation"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  await FireRepo.removeCart(id)
                      .then((value) => Navigator.of(context).pop(true));
                  setState(() {});
                },
                child: const Text("Delete")),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
