import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:isumi/core/util/utils.dart';
import 'package:onyxsio/onyxsio.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class OrderStatusPage extends StatefulWidget {
  const OrderStatusPage({Key? key}) : super(key: key);

  @override
  State<OrderStatusPage> createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  final user = auth.FirebaseAuth.instance.currentUser;
  List<Cart> carts = [];
  bool isLoading = false;
  String currency = '';
  double total = 0.0;
  @override
  void initState() {
    getCartData();

    super.initState();
  }

  Future<void> getCartData() async {
    setState(() => isLoading = true);
    carts = await SQFLiteDB.readAllData();
    // customer = await FirestoreRepository.getCustomer();
    for (var item in carts) {
      total = total + (double.parse(item.price) * int.parse(item.quantity));
    }
    currency = carts[0].currency;
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: appBar(text: 'Your order status'),
      body: isLoading
          ? const Center(child: HRDots())
          : SingleChildScrollView(
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

            await PaymentGate.onPayment(
              email: user!.email!,
              amount: total,
              context: context,
            ).then((value) {
              if (value == 'successful') {
                // .pushNamed(context, '/EndPage');
                Navigator.pushReplacementNamed(context, '/EndPage');
              } else {
                DBox.autoClose(context, type: InfoDialog.error, message: value);
              }
            });
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
          title: Text('Order list and prices', style: TxtStyle.h7B),
          children: <Widget>[
            Container(height: 0.5, color: AppColor.divider),
            SizedBox(height: 4.w),
            priceTag('Items Total', total.toString()),
            SizedBox(height: 2.w),
            priceTag('Delivery charges', '50.2'),
            SizedBox(height: 2.w),
            priceTag('Discount', '0.0'),
            // SizedBox(height: 2.w),
            // priceTag('Tax', '0.2'),
            SizedBox(height: 4.w),
            Container(height: 0.5, color: AppColor.divider),
            SizedBox(height: 4.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount', style: TxtStyle.b6B),
                Text(Utils.currency(name: currency, amount: total),
                    style: TxtStyle.b8B.copyWith(color: AppColor.orange)),
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
        Text(title, style: TxtStyle.h5),
        Text(Utils.currency(name: currency, amount: double.parse(cost)),
            style: TxtStyle.b5B),
      ],
    );
  }

  Widget _buildBottomList(theme, context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirestoreRepository.customerDB.doc(user!.uid).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: HRDots());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: HRDots());
          }
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          Customer customer = Customer.fromJson(data);
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
                title: Text('Delivery information', style: TxtStyle.h7B),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: 0.5, color: AppColor.divider),
                  SizedBox(height: 5.w),
                  customer.address!.streetAddress!.isEmpty
                      ? _addNewShippingAdderss(context)
                      : Text(customer.address!.streetAddress!,
                          style: TxtStyle.l5),
                  SizedBox(height: 5.w),
                  if (customer.address!.streetAddress!.isNotEmpty)
                    _updateShippingAdderss(context),
                  SizedBox(height: 5.w),
                ],
              ),
            ),
          );
        });
  }

  GestureDetector _addNewShippingAdderss(context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/ShippingAddressPage');
        Navigator.pushNamed(context, '/EditAddress').then((_) => getCartData());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.add),
          SizedBox(width: 5.w),
          Text('Please add your shipping address.',
              style: TxtStyle.b5.copyWith(color: AppColor.yellow)),
        ],
      ),
    );
  }

  GestureDetector _updateShippingAdderss(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/ShippingAddressPage');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Change the shipping address.',
              style: TxtStyle.b6.copyWith(color: AppColor.yellow)),
          // SizedBox(width: 5.w),
          SvgPicture.asset(AppIcon.edit, color: AppColor.yellow),
        ],
      ),
    );
  }
}
