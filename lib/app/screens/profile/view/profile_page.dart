import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: mainAppBar(text: 'My Profile'),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FireRepo.customerDB.doc(user.id).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: HRDots());
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: HRDots());
            }
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            Customer customer = Customer.fromJson(data);
            return Padding(
              padding: EdgeInsets.all(5.w),
              child: body(context, customer),
            );
          }),
    );
  }

  Column body(BuildContext context, Customer customer) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDeco.deco_2,
          child: Row(
            children: [
              // CachedNetworkImage(imageUrl: )

              CachedNetworkImage(
                  imageUrl: customer.photoUrls!,
                  imageBuilder: (context, imageProvider) =>
                      CircleAvatar(radius: 6.h, backgroundImage: imageProvider),
                  placeholder: (context, url) => AppLoading.profile,
                  errorWidget: (context, url, error) => AppLoading.profile),
              // CircleAvatar(radius: 6.h),
              SizedBox(width: 5.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customer.name!, style: TxtStyle.h7B),
                  SizedBox(height: 2.w),
                  Text(customer.email!, style: TxtStyle.l5),
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 5.w),
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDeco.deco_2,
          child: Column(
            children: [
              SizedBox(height: 5.w),
              listTile(
                title: 'Account Settings',
                subTitle: 'Do you want to change your account details?',
                onTap: () {
                  Navigator.pushNamed(context, '/AccountSettingsPage');
                },
              ),
              const Divider(),
              SizedBox(height: 5.w),
              listTile(
                title: 'Shipping Addresses',
                subTitle:
                    'Do you want to change your shipping address details?',
                onTap: () {
                  Navigator.pushNamed(context, '/ShippingAddressPage');
                },
              ),
              const Divider(),
              SizedBox(height: 5.w),
              // listTile(
              //   title: 'Payment Method',
              //   subTitle: 'You have 2 cards',
              //   onTap: () {
              //     Navigator.pushNamed(context, '/PaymetMethodPage');
              //   },
              // ),
              // const Divider(),
              // SizedBox(height: 5.w),
              listTile(
                title: 'My reviews',
                subTitle: 'Reviews for ${customer.review!.length} items',
                onTap: () {
                  Navigator.pushNamed(context, '/ReviewPage',
                      arguments: customer);
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget listTile({
    required String title,
    required String subTitle,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TxtStyle.h7B),
                  SizedBox(height: 1.w),
                  Text(subTitle, style: TxtStyle.l3),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.yellow,
              size: 5.w,
            )
          ],
        ),
      ),
    );
  }
}
