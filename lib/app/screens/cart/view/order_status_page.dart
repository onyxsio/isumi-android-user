import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:isumi/core/util/utils.dart';
import 'package:onyxsio/onyxsio.dart';

class OrderStatusPage extends StatefulWidget {
  const OrderStatusPage({Key? key}) : super(key: key);

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  List<Cart> carts = [];
  late Customer customer;
  bool isLoading = false;
  String currency = '';
  double total = 0.0;
  @override
  void initState() {
    getCartData();
    getCustomerData();
    super.initState();
  }

  Future<void> getCartData() async {
    setState(() => isLoading = true);
    carts = await SQFLiteDB.readAllData();

    for (var item in carts) {
      total = total + (double.parse(item.price) * int.parse(item.quantity));
    }
    currency = carts[0].currency;
    setState(() => isLoading = false);
  }

  Future<void> getCustomerData() async {
    setState(() => isLoading = true);
    customer = await FirestoreRepository.getCustomer();
    setState(() => isLoading = false);
    log(customer.address!.toString());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: appBar(text: 'Your order status'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
        // TODO change button
        child: MainButton(
          text: Utils.currency(name: currency, amount: total),
          onTap: () async {
            // Navigator.pushNamed(context, '/CheckOutPage');
            var text = await PaymentGate.onPayment(
              email: customer.email!,
              amount: total,
              context: context,
            );
            log(text.toString());
          },
        ),
      ),
    );
  }

  Widget _buildTopList(theme) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDeco.deco_2,
      child: Theme(
        data: theme.copyWith(
          dividerColor: Colors.transparent,
          expansionTileTheme:
              ExpansionTileThemeData(iconColor: AppColor.yellow),
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          initiallyExpanded: true,
          title: Text(
            'Order list and prices',
            style: TxtStyle.h5,
          ),
          children: <Widget>[
            Container(height: 1, color: AppColor.divider),
            SizedBox(height: 4.w),
            priceTag('Items Total', total.toString()),
            SizedBox(height: 2.w),
            priceTag('Delivery charges', '50'),
            SizedBox(height: 2.w),
            priceTag('Discount', '0'),
            SizedBox(height: 2.w),
            priceTag('Tax', '0'),
            SizedBox(height: 4.w),
            Container(height: 1, color: AppColor.divider),
            SizedBox(height: 4.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount', style: TxtStyle.b5B),
                Text('$currency $total',
                    style: TxtStyle.b5B.copyWith(color: AppColor.orange)),
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
          expansionTileTheme:
              ExpansionTileThemeData(iconColor: AppColor.yellow),
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          initiallyExpanded: true,
          // iconColor: errorColor,
          // collapsedIconColor: errorColor,
          title: Text('Delivery information', style: TxtStyle.h5),
          children: <Widget>[
            Container(height: 1, color: AppColor.divider),
            SizedBox(height: 5.w),
            customer.address!.isEmpty
                ? Text('Please add your billing address.', style: TxtStyle.l3)
                : Text(customer.address![0].streetAddress!, style: TxtStyle.l1),
            SizedBox(height: 5.w),
            Container(height: 1, color: AppColor.divider),
            SizedBox(height: 5.w),
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
                      style: TxtStyle.b5.copyWith(color: AppColor.yellow)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
