import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class MiniMainPage extends StatelessWidget {
  const MiniMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final time = DateFormat("hh:mm").format(DateTime.now());

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(time, style: TxtStyle.b3B),
        const SizedBox(height: 20),
        Row(
          children: [
            SvgPicture.asset(AppIcon.location),
            Text('Deliver to ',
                style: TxtStyle.b1.copyWith(color: AppColor.lightBlack)),
          ],
        ),
        const SizedBox(height: 20),
        Text('Find the latest ', style: TxtStyle.h7B),
        const SizedBox(height: 20),
        Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDeco.deco_5,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(AppIcon.search),
                const SizedBox(width: 5),
                Expanded(
                  child: Text('Search', style: TxtStyle.l7),
                ),
                // SvgPicture.asset(AppIcon.filter)
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: 90.w,
          decoration: BoxDecoration(
            color: const Color(0XFF212134),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -10,
                top: -10,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: AppColor.white.withOpacity(0.04),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColor.white.withOpacity(0.06),
                ),
              ),
              Positioned(
                right: 20,
                top: 20,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColor.white.withOpacity(0.06),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                // widthFactor: 30.w,
                child: Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Product of the day',
                        style: TxtStyle.b1.copyWith(
                          color: const Color(0XFFA5A5BA),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 40.w,
                        child: Text(
                          'Majority’s best choice',
                          style: TxtStyle.b3.copyWith(
                            color: AppColor.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'See more',
                        style: TxtStyle.h7B.copyWith(
                          color: AppColor.orange,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
            decoration: BoxDecoration(
              color: AppColor.yellow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('Popular',
                style: TxtStyle.b1.copyWith(color: AppColor.white))),
        const SizedBox(height: 20),
        Text('Most Popular',
            style: TxtStyle.h3.copyWith(
              fontSize: 14,
            )),
        const SizedBox(height: 20),
        listTile()
      ],
    );
  }

  Container listTile() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDeco.deco_2,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
    );
  }
}
