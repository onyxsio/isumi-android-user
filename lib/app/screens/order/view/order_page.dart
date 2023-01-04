import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
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
        stream:
            FireRepo.customerDB.doc(user.id).collection('orders').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: HRDots());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: HRDots());
          }
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
            child: FocusedMenuHolder(
              menuContent: menuContent(order, context),
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
                              'Order No: ${Utils.orderNumber(order.oId!)}',
                              maxLines: 1,
                              style: TxtStyle.h5),
                        ),
                      ],
                    ),
                    const Divider(),
                    SizedBox(height: 0.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Utils.date(order.date!), style: TxtStyle.b5),
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
                    SizedBox(height: 1.h),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget menuContent(Orders order, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: GestureDetector(
          onTap: () async {
            await FireRepo.deleteOrder(order.oId!)
                .then((_) => Navigator.pop(context));
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
}
