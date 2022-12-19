import 'package:flutter/material.dart';
import 'package:isumi/app/screens/cart/widgets/item_list.dart';
import 'package:onyxsio/onyxsio.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final user = auth.FirebaseAuth.instance.currentUser;
  bool isEmpty = false;
  late List<DocumentSnapshot> carts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(text: 'Shopping Cart'),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreRepository.customerDB
            .doc(user!.uid)
            .collection('cart')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: HRDots());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: HRDots());
          }
          // Map<String, dynamic> data =
          //     snapshot.data!.docs as Map<String, dynamic>;
          carts = snapshot.data!.docs;
          // Customer customer = Customer.fromDocumentSnapshot(data);
          if (snapshot.data!.docs.isEmpty) {
            isEmpty = true;
            return Center(
              child: Text('Your Shopping Cart Is Empty.', style: TxtStyle.b8),
            );
          }
          // List<Items> item =
          return _buildItemList(snapshot.data!.docs);
        },
      ),
      bottomNavigationBar: isEmpty
          ? null
          : bottomNavigationBar(
              onTap: () => Navigator.pushNamed(context, '/OrderStatusPage',
                  arguments: carts),
              text: 'Proceed to checkout'),
    );
  }

  Widget _buildItemList(items) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      padding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 0),
      itemBuilder: (context, index) {
        return ItemListView(cart: items[index]);
      },
    );
  }
}
