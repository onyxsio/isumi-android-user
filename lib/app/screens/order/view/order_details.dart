import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

import '../widgets/time_line.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

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
              priceTag('Items Total', '500'),
              const SizedBox(height: 10),
              priceTag('Delivery charges', '50'),
              const SizedBox(height: 10),
              priceTag('Discount', '0'),
              const SizedBox(height: 10),
              priceTag('Tax', '0'),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: TxtStyle.h7B.copyWith(color: AppColor.gray1),
                  ),
                  Text('2.0', style: TxtStyle.h11B),
                ],
              ),
            ], 'Price details'),
            _tileBackground([orderTimeLine()], 'Delivery details'),
            _tileBackground([
              Text(
                '25 rue Robert Latouche, Nice, 06200, Côte D’azur, France: ',
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
