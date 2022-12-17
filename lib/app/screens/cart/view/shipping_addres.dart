import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({Key? key}) : super(key: key);

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  bool isLoading = false;
  List<LAddress> address = [];
  @override
  void initState() {
    getAddress();
    // getCustomerData();
    super.initState();
  }

  Future<void> getAddress() async {
    setState(() => isLoading = true);
    address = await SQFLiteDB.readAllAddress();
    // customer = await FirestoreRepository.getCustomer();
    for (var item in address) {
      // total = total + (double.parse(item.price) * int.parse(item.quantity));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Scaffold(
      appBar: appBar(text: 'Shipping address'),
      body: isLoading
          ? const Center(child: HRDots())
          : ListView(
              padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 5.w),
              children: [
                _buildListTile(context),
                _buildListTile(context),
                _buildListTile(context),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/EditAddress');
        },
        backgroundColor: AppColor.white,
        child: Icon(Icons.add, color: AppColor.lightBlack2),
      ),
    );
  }

  Widget _buildListTile(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      margin: EdgeInsets.only(bottom: 5.w),
      decoration: BoxDeco.deco_2,
      child: Column(
        children: <Widget>[
          titleRow('Sudesh Bandara', context),
          SizedBox(height: 2.w),
          const Divider(),
          SizedBox(height: 2.w),
          Text(
            '25 rue Robert Latouche, Nice, 06200, Côte D’azur, France: ',
            style: TxtStyle.l1,
          ),
          SizedBox(height: 2.w),
          const Divider(),
          SizedBox(height: 2.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: true,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
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

  Row titleRow(String name, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, maxLines: 1, style: TxtStyle.h6),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/EditAddress');
          },
          child: SvgPicture.asset(AppIcon.edit),
        )
        // Text(cost, style: TextStyles.h3B),
      ],
    );
  }
}
