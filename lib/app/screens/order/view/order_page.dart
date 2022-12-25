import 'package:flutter/material.dart';
import 'package:isumi/core/util/utils.dart';
import 'package:onyxsio/onyxsio.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: mainAppBar(text: 'My Orders'),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreRepository.customerDB
            .doc(user.id)
            .collection('orders')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: HRDots());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: HRDots());
          }
          // var d = snapshot.data!.docs;
          // Map<String, dynamic> data =
          // snapshot.data!.docs.data() as Map<String, dynamic>;
          // Customer customer = Customer.fromJson(data);
          return body(context, snapshot.data!.docs);
        },
      ),
    );
  }

  Widget body(BuildContext context, List<DocumentSnapshot> document) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        itemCount: document.length,
        itemBuilder: (itemBuilder, index) {
          Map<String, dynamic> data =
              document[index].data()! as Map<String, dynamic>;
          Orders order = Orders.fromJson(data);
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/OrderDetails', arguments: order);
            },
            child: Container(
              padding: EdgeInsets.all(4.w),
              margin: EdgeInsets.symmetric(vertical: 3.w),
              decoration: BoxDeco.deco_2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            'Order No: #${Utils.orderNumber(order.oId!)}',
                            maxLines: 1,
                            style: TxtStyle.h5),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Utils.formatDate(order.date!), style: TxtStyle.b5),
                      Row(
                        children: [
                          Text(
                            'Amount : ',
                            style: TxtStyle.b5
                                .copyWith(color: AppColor.lightBlack2),
                          ),
                          Text(
                              Utils.currency(
                                  amount: double.parse(order.total!),
                                  name: order.currency),
                              style: TxtStyle.b5B),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        });
  }
}
