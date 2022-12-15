import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

class OrderStatusPage extends StatelessWidget {
  const OrderStatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: appBar(text: 'Your order status'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 5.w),
        child: Column(
          children: [
            _buildTopList(theme),
            SizedBox(height: 5.w),
            _buildBottomList(theme, context),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(bottom: 3.h),
        child: MainButton(
          text: 'Pay \$123',
          onTap: () {
            Navigator.pushNamed(context, '/CheckOutPage');
          },
        ),
      ),
    );
  }
}

Widget _buildTopList(theme) {
  return Container(
    padding: EdgeInsets.all(4.w),
    decoration: BoxDeco.deco_2,
    child: Theme(
      data: theme.copyWith(
        dividerColor: Colors.transparent,
        expansionTileTheme: ExpansionTileThemeData(iconColor: AppColor.yellow),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        initiallyExpanded: true,
        title: Text(
          'Order list and prices',
          style: TxtStyle.h3,
        ),
        children: <Widget>[
          Container(height: 1, color: AppColor.divider),
          const SizedBox(height: 20),
          priceTag('Items Total', '500'),
          const SizedBox(height: 10),
          priceTag('Delivery charges', '50'),
          const SizedBox(height: 10),
          priceTag('Discount', '0'),
          const SizedBox(height: 10),
          priceTag('Tax', '0'),
          const SizedBox(height: 15),
          Container(height: 1, color: AppColor.divider),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: TxtStyle.h3.copyWith(color: const Color(0XFF4A4A6A)),
              ),
              Text('\$2.0',
                  style: TxtStyle.h2.copyWith(color: AppColor.orange)),
            ],
          ),
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
        style: TxtStyle.h3.copyWith(color: AppColor.lightBlack),
      ),
      Text(cost, style: TxtStyle.h3),
    ],
  );
}

Widget _buildBottomList(theme, context) {
  return Container(
    padding: EdgeInsets.all(4.w),
    decoration: BoxDeco.deco_2,
    child: Theme(
      data: theme.copyWith(
        dividerColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColor.yellow),
        expansionTileTheme: ExpansionTileThemeData(iconColor: AppColor.yellow),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        initiallyExpanded: true,
        // iconColor: errorColor,
        // collapsedIconColor: errorColor,
        title: Text('Delivery information', style: TxtStyle.h3),
        children: <Widget>[
          Container(height: 1, color: AppColor.divider),
          const SizedBox(height: 20),
          Text(
            '25 rue Robert Latouche, Nice, 06200, Côte D’azur, France: ',
            style: TxtStyle.l1,
          ),
          const SizedBox(height: 20),
          Container(height: 1, color: AppColor.divider),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/ShippingAddressPage');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.add),
                SizedBox(width: 5.w),
                Text('Change or add a new address',
                    style: TxtStyle.b1.copyWith(color: AppColor.yellow)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
