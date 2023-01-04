import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

import '../widgets/time_line.dart';

class OrderDetails extends StatelessWidget {
  final Orders order;
  const OrderDetails({Key? key, required this.order}) : super(key: key);
// TODO
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'Your order status'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 6.w).copyWith(top: 5.w),
        child: Column(
          children: [
            _tileBackground([
              priceTag('Items Total', order.total!),
              const SizedBox(height: 10),
              priceTag('Delivery charges', order.delivery!),
              const SizedBox(height: 10),
              priceTag('Discount', order.discountedPrice!),
              const SizedBox(height: 10),
              // priceTag('Tax', '0'),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: TxtStyle.h7B.copyWith(color: AppColor.gray1),
                  ),
                  Text(order.total!, style: TxtStyle.h11B),
                ],
              ),
            ], 'Price details'),
            _tileBackground([orderTimeLine(order)], 'Delivery details'),
            _tileBackground(
                order.items!.map((e) => buildProductTile(e)).toList(),
                'Product details'),
            _tileBackground([
              Text(
                """${order.customer!.address!.name!}, ${order.customer!.address!.streetAddress!}, ${order.customer!.address!.city!}\n${order.customer!.address!.state!} ${order.customer!.address!.postalCode!}""",
                style: TxtStyle.l5,
              ),
            ], 'Shipping details')
          ],
        ),
      ),
    );
  }

  Row priceTag(String title, String cost) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TxtStyle.h7.copyWith(color: AppColor.gray1),
        ),
        Text(cost, style: TxtStyle.h7B),
      ],
    );
  }

  Container _tileBackground(List<Widget> children, String title) {
    return Container(
      padding: EdgeInsets.all(4.w),
      margin: EdgeInsets.symmetric(vertical: 3.w),
      decoration: BoxDeco.deco_2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TxtStyle.h11B),
          const Divider(),
          const SizedBox(height: 10),
          ...children,
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
