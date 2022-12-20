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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirestoreRepository.customerDB.doc(user.id).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: HRDots());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: HRDots());
          }
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          Customer customer = Customer.fromJson(data);
          return body(context, customer.order!);
        },
      ),
    );
  }

  Widget body(BuildContext context, List<Orders> orders) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        itemCount: orders.length,
        itemBuilder: (itemBuilder, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/OrderDetails',
                  arguments: orders[index]);
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
                            'Order No: #${Utils.orderNumber(orders[index].oId!)}',
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
                      Text(Utils.formatDate(orders[index].date!),
                          style: TxtStyle.b5),
                      Row(
                        children: [
                          Text(
                            'Amount : ',
                            style: TxtStyle.b5
                                .copyWith(color: AppColor.lightBlack2),
                          ),
                          Text(
                              Utils.currency(
                                  amount: double.parse(orders[index].total!),
                                  name: orders[index].currency),
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
