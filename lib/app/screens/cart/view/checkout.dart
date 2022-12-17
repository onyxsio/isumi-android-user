import 'package:flutter/material.dart';
import 'package:isumi/app/screens/cart/widgets/credit_card.dart';
import 'package:isumi/app/screens/cart/widgets/credit_cards_ui.dart';
import 'package:onyxsio/onyxsio.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'Checkout'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 5.w),
        child: Column(
          children: [
            // TODO
            // if don't have a card
            // const DontHaveCard(),
            // if have a card
            Container(
              // padding: EdgeInsets.all(4.w),
              decoration: BoxDeco.deco_2,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Payment method', style: TxtStyle.h3),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return const AddNewCardScreen();
                              },
                            );
                          },
                          child: Text('Add a new card',
                              style:
                                  TxtStyle.b5.copyWith(color: AppColor.yellow)),
                        ),
                      ],
                    ),
                  ),
                  const CreditCardsPage(
                      image: 'AppIcon.master',
                      cardExpiration: "05/2024",
                      cardHolder: "HOUSSEM SELMI",
                      cardNumber: "9874 4785 XXXX 6548")
                ],
              ),
            ),
            SizedBox(height: 5.w),
            const PriceDetails(),
          ],
        ),
      ),
      // if don't have a card? this is null
      bottomNavigationBar: bottomNavigationBar(
          onTap: () {
            Navigator.pushNamed(context, '/EndPage');
          },
          text: 'Pay \$123'),
    );
  }
}

class PriceDetails extends StatelessWidget {
  const PriceDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDeco.deco_2,
      child: Column(
        children: [
          priceTag('Items Total', '500'),
          const SizedBox(height: 10),
          priceTag('Discount', '50'),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.w),
            margin: EdgeInsets.only(bottom: 5.w),
            decoration: BoxDeco.deco_5,
            child: Center(
              child: TextFormField(
                // controller: controller,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: '% Apply discount code',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          // const SizedBox(height: 10),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: TxtStyle.h3.copyWith(color: AppColor.lightBlack2),
              ),
              Text('2.0', style: TxtStyle.h2),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

Widget inputBackground(Widget child) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.w),
    margin: EdgeInsets.only(bottom: 5.w),
    decoration: BoxDeco.deco_5,
    child: child,
  );
}

Row priceTag(String title, String cost) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TxtStyle.h3.copyWith(color: AppColor.black2),
      ),
      Text(cost, style: TxtStyle.h3),
    ],
  );
}

class DontHaveCard extends StatelessWidget {
  const DontHaveCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDeco.deco_2,
      child: Column(
        children: [
          // Image.asset(AppImage.wallet, height: 20.w),
          SizedBox(height: 4.5.w),
          Text(
            'You don’t have any card',
            style: TxtStyle.h3,
          ),
          SizedBox(height: 4.5.w),
          Text(
            'Please add a credit or a debit card in order to pay your order.',
            textAlign: TextAlign.center,
            style: TxtStyle.b1.copyWith(color: const Color(0XFF8E8EA9)),
          ),
          SizedBox(height: 4.5.w),
          GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return const AddNewCardScreen();
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: AppColor.yellow),
                SizedBox(width: 5.w),
                Text('Add a new card',
                    style: TxtStyle.b3.copyWith(color: AppColor.yellow)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// onPressed: () => Navigator.pop(context),
