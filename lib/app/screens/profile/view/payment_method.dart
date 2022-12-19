import 'package:flutter/material.dart';
import 'package:isumi/app/screens/cart/widgets/credit_card.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class PaymetMethodPage extends StatelessWidget {
  const PaymetMethodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'Payment method'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 5.w),
        children: [
          _buildListTile(),
          _buildListTile(),
          // _buildListTile(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return const AddNewCardScreen();
            },
          );
        },
        backgroundColor: AppColor.white,
        child: const Icon(Icons.add, color: Color(0XFF4A4A6A)),
      ),
    );
  }
}

Widget _buildListTile() {
  return Container(
    padding: EdgeInsets.all(4.w),
    margin: EdgeInsets.only(bottom: 5.w),
    decoration: BoxDeco.deco_2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        titleRow(),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Card Holder Name: ', style: TxtStyle.b5B),
                Text('25 rue Robert Latouche', style: TxtStyle.l5),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Expiry Date:', style: TxtStyle.b5B),
                Text('05/23', style: TxtStyle.l5),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: true,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              onChanged: (value) {},
              activeColor: const Color(0XFF303030),
            ),
            SizedBox(width: 5.w),
            Text(
              'Use as a default payment method',
              style: TxtStyle.b5B.copyWith(color: const Color(0XFF666687)),
            ),
          ],
        ),
      ],
    ),
  );
}

Row titleRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          // SvgPicture.asset(AppIcon.visa, width: 10.w),
          Text(' **** **** **** 8523', style: TxtStyle.h7B),
        ],
      ),
      GestureDetector(
        onTap: () {
          // TODO
        },
        child: SvgPicture.asset(AppIcon.edit),
      )
      // Text(cost, style: TextStyles.h3B),
    ],
  );
}
