import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({Key? key}) : super(key: key);

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  final user = auth.FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  int isClick = 0;
  // late Customer customer;
  List<LAddress> address = [];
  @override
  void initState() {
    getAddress();
    super.initState();
  }

  Future<void> getAddress() async {
    setState(() => isLoading = true);
    address = await SQFLiteDB.readAllAddress();
    // customer = await FirestoreRepository.getCustomer();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'Shipping address'),
      body: isLoading
          ? const Center(child: HRDots())
          : address.isEmpty
              ? Center(
                  child:
                      Text('You have not added addresses.', style: TxtStyle.b8),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(5.w),
                  itemCount: address.length,
                  itemBuilder: (context, index) {
                    return _listTile(context, address[index], index);
                  },
                  // children: address.map((e) => _listTile(context, e)).toList(),
                ),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  FloatingActionButton _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (address.length < 3) {
          Navigator.pushNamed(context, '/EditAddress')
              .then((_) => getAddress());
        } else {
          DBox.autoClose(
            context,
            type: InfoDialog.warning,
            message: 'You can only add a maximum of 3 addresses.',
          );
        }
      },
      backgroundColor: AppColor.white,
      child: Icon(Icons.add, color: AppColor.lightBlack2),
    );
  }

  Widget _listTile(BuildContext context, LAddress address, int index) {
    return FocusedMenuHolder(
      menuContent: menuContent(address),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(4.w),
          margin: EdgeInsets.only(bottom: 5.w),
          decoration: BoxDeco.deco_2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              titleRow(address.name, context, address),
              SizedBox(height: 2.w),
              const Divider(),
              SizedBox(height: 2.w),
              Text(
                  '${address.streetAddress},${address.city},${address.state},${address.postalCode}',
                  style: TxtStyle.l5),
              SizedBox(height: 2.w),
              const Divider(),
              SizedBox(height: 2.w),
              usedAddress(index, address),
              // UsedAddress(address: address, index: index),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuContent(LAddress address) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: GestureDetector(
          onTap: () async {
            await SQFLiteDB.delete(address.id!)
                .then((_) => Navigator.pop(context));
            getAddress();
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

  usedAddress(int index, LAddress address) {
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
          return InkWell(
            onTap: () {
              setState(() => isClick = index);
              if (isClick == index) {
                uploadFirebase(address);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: address.uid.contains(data['address']['uid']),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  onChanged: (value) {},
                  activeColor: AppColor.black,
                ),
                SizedBox(width: 5.w),
                Text('Use as the shipping address', style: TxtStyle.b6),
              ],
            ),
          );
        });
  }

  void uploadFirebase(LAddress value) async {
    Address address = Address(
      uid: value.uid,
      name: value.name,
      streetAddress: value.streetAddress,
      state: value.state,
      city: value.city,
      postalCode: value.postalCode,
    );
    await FirestoreRepository.setupAddress(address);
  }

  Row titleRow(String name, BuildContext context, LAddress value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, maxLines: 1, style: TxtStyle.h6),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/EditAddress', arguments: value)
                .then((_) => getAddress());
          },
          child: SvgPicture.asset(AppIcon.edit),
        )
        // Text(cost, style: TextStyles.h3B),
      ],
    );
  }
}

// class UsedAddress extends StatefulWidget {
//   final LAddress address;
//   const UsedAddress({Key? key, required this.address}) : super(key: key);

//   @override
//   State<UsedAddress> createState() => _UsedAddressState();
// }

// class _UsedAddressState extends State<UsedAddress> {
//   bool isClick = false;

//   @override
//   void initState() {
//     // setState(() => isClick = widget.address.isSelected);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Checkbox(
//           value: isClick,
//           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//           onChanged: (value) {
//             // if (value!) {
//             setState(() => isClick = !isClick);
//             log(value.toString());
//             // SQFLiteDB.updateAddressUse(widget.address.copy(isSelected: value));
//             // getAddress();
//             // }
//           },
//           activeColor: AppColor.black,
//         ),
//         SizedBox(width: 5.w),
//         Text('Use as the shipping address', style: TxtStyle.b6),
//       ],
//     );
//   }
// }
