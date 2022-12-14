import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:remote_data/remote_data.dart';
import 'package:remote_data/src/model/order.dart';
import 'package:components/components.dart';

class OrderInformation extends StatelessWidget {
  const OrderInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('seller')
          .doc('overview')
          .collection('orders')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoActivityIndicator();
        }

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            Orders order = Orders.fromJson(data);
            return NowOrderListCard(order: order);
          }).toList(),
        );
      },
    );
  }
}
