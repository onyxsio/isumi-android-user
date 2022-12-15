import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class ShippingAddressPage extends StatelessWidget {
  const ShippingAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Scaffold(
      appBar: appBar(text: 'Shipping address'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 5.w),
        children: [
          _buildListTile(),
          _buildListTile(),
          _buildListTile(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/EditAddress');
        },
        backgroundColor: AppColor.white,
        child: const Icon(Icons.add, color: Color(0XFF4A4A6A)),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(bottom: 3.h),
        child: MainButton(
          text: 'Save Address',
          onTap: () {
            // TODO
          },
        ),
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
      children: <Widget>[
        titleRow(),
        const SizedBox(height: 10),
        const Divider(),
        const SizedBox(height: 10),
        Text(
          '25 rue Robert Latouche, Nice, 06200, Côte D’azur, France: ',
          style: TxtStyle.l1,
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
              'Use as the shipping address',
              style: TxtStyle.h3.copyWith(color: const Color(0XFF666687)),
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
      Text(
        'Sudesh Bandara',
        style: TxtStyle.h3,
      ),
      GestureDetector(
        onTap: () {
          // TODO
          // Navigator.pushNamed(context, '/EditAddress');
        },
        child: SvgPicture.asset(AppIcon.edit),
      )
      // Text(cost, style: TextStyles.h3B),
    ],
  );
}
