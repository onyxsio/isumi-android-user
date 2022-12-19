import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  bool isList = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'Wishlist'),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('12 Items found on the wishlist', style: TxtStyle.h3),
                InkWell(
                    onTap: () {
                      setState(() => isList = !isList);
                    },
                    child: ListOrGridButton(onTap: (p0) {}))
              ],
            ),
            // toolTip(),
            SizedBox(height: 5.w),
            if (isList)
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  physics: const BouncingScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) => FocusedMenuHolder(
                      menuContent: menuContent(), child: listCard()),
                ),
              ),
            if (!isList)
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // maxCrossAxisExtent: 50.w,
                    crossAxisCount: 2,
                    mainAxisSpacing: 2.h,
                    crossAxisSpacing: 4.w,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index) => FocusedMenuHolder(
                      menuContent: menuContent(), child: gridCard()),
                ),
              )
          ],
        ),
      ),
    );
  }

  Padding menuContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                // TODO
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(AppIcon.trash, color: AppColor.error),
                  Text('Delete', style: TxtStyle.b5B),
                ],
              )),
          SizedBox(height: 5.w),
          GestureDetector(
              onTap: () {
                // TODO
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(AppIcon.trash, color: AppColor.error),
                  Text('Open', style: TxtStyle.b5B),
                ],
              )),
        ],
      ),
    );
  }
}

// List Card
Widget listCard() {
  return Container(
    // height: 19.h,
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
    margin: EdgeInsets.only(bottom: 5.w),
    decoration: BoxDeco.deco_2,
    // alignment: Alignment.center,

    child: Row(
      children: [
        //Todo
        // Image.asset(AppImage.demoProduct, height: 35.w),
        SizedBox(width: 6.w),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Leather Jacket Leather',
                maxLines: 2,
                style: TxtStyle.b1,
              ),
              SizedBox(height: 2.w),
              Row(
                children: [
                  Icon(Icons.star, color: AppColor.yellow, size: 4.w),
                  SizedBox(width: 2.w),
                  Text('4.1', style: TxtStyle.b3B),
                  Text('(120 reviews)', style: TxtStyle.b2),
                ],
              ),
              SizedBox(height: 2.w),
              Text(
                '\$14.10 ',
                style: TxtStyle.b3B.copyWith(color: AppColor.orange),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Grid Card
Widget gridCard() {
  return Container(
    // height: 19.h,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    // margin: EdgeInsets.only(bottom: 5.w),
    decoration: BoxDeco.deco_2,
    alignment: Alignment.center,

    child: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Todo
            // Image.asset(
            //   AppImage.demoProduct,
            //   height: 35.w,
            // ),
            Text(
              'Leather Jacket',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TxtStyle.b1,
            ),
            Text(
              '\$14.10 ',
              style: TxtStyle.b3B.copyWith(color: AppColor.orange),
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 20,
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDeco.deco_2,
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: AppColor.yellow,
                  size: 4.w,
                ),
                const SizedBox(width: 5),
                Text(
                  '4.1',
                  style: TxtStyle.b3B,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Widget toolTip() {
//   final tooltipkey = GlobalKey<TooltipState>();
//   void _onTapDown(GlobalKey<TooltipState> tooltipkey) {
//     tooltipkey.currentState?.ensureTooltipVisible();
//   }

//   void _onTapUpAndCancel(GlobalKey<TooltipState> tooltipkey) {
//     tooltipkey.currentState?.deactivate();
//   }

//   return Tooltip(
//     key: tooltipkey,
//     message: 'message',
//     triggerMode: TooltipTriggerMode.manual, // make it manual
//     child: GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onLongPress: () => _onTapDown(tooltipkey),
//       onTapDown: (_) => _onTapDown(tooltipkey), // add this
//       onTapUp: (_) => _onTapUpAndCancel(tooltipkey), // add this
//       onTapCancel: () => _onTapUpAndCancel(tooltipkey), // add this
//       child: Icon(Icons.mark_as_unread_rounded),
//     ),
//   );
// }
