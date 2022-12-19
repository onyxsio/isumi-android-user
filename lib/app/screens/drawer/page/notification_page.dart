import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isDismissed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'Notification'),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 0),
          itemCount: 5,
          itemBuilder: (itemBuilder, index) {
            return Stack(
              children: [
                if (isDismissed) background(),
                Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() => isDismissed = true);
                    },
                    child: listTile()),
              ],
            );
          }),
    );
  }

  Container listTile() {
    return Container(
      height: 20.h,
      padding: EdgeInsets.all(5.w),
      margin: EdgeInsets.only(bottom: 5.w),
      decoration: BoxDeco.deco_2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO
          // Image.asset(AppImage.demoProduct, height: 15.h),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TXTHeader.notificationHeader(
                    'Your order #123456789 has been shipped successfully '),
                TXTHeader.notificationSubHeader(
                    'Please help us to confirm and rate your order to get 10% discount code for next order.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container background() {
    return Container(
      height: 20.h,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 5.w),
      margin: EdgeInsets.only(bottom: 5.w),
      decoration: BoxDeco.deco_4,
      child: SvgPicture.asset(AppIcon.trash),
    );
  }
}
