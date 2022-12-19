import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(text: 'My Profile'),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDeco.deco_2,
              child: Row(
                children: [
                  // CachedNetworkImage(imageUrl: )

                  CachedNetworkImage(
                    imageUrl: "https://i.stack.imgur.com/l60Hf.png",
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 6.h, backgroundImage: imageProvider),
                    placeholder: (context, url) => CircleAvatar(radius: 6.h),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  // CircleAvatar(radius: 6.h),
                  SizedBox(width: 5.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sudesh Bandara', style: TxtStyle.h7B),
                      SizedBox(height: 2.w),
                      Text('bruno203@gmail.com', style: TxtStyle.l5),
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
                    title: 'Shipping Addresses',
                    subTitle: '03 Addresses',
                    onTap: () {
                      Navigator.pushNamed(context, '/ShippingAddressPage');
                    },
                  ),
                  const Divider(),
                  SizedBox(height: 5.w),
                  listTile(
                    title: 'Payment Method',
                    subTitle: 'You have 2 cards',
                    onTap: () {
                      Navigator.pushNamed(context, '/PaymetMethodPage');
                    },
                  ),
                  const Divider(),
                  SizedBox(height: 5.w),
                  listTile(
                    title: 'My reviews',
                    subTitle: 'Reviews for 5 items',
                    onTap: () {
                      Navigator.pushNamed(context, '/ReviewPage');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TxtStyle.h7B),
                SizedBox(height: 1.w),
                Text(subTitle, style: TxtStyle.l5),
              ],
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
