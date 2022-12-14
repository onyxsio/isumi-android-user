import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

class AdCarouselSlider extends StatelessWidget {
  const AdCarouselSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 5,
      itemBuilder: (context, itemIndex, pageViewIndex) => Container(
        width: 90.w,
        // margin: EdgeInsets.symmetric(horizontal: 5),
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
                  children: [
                    Text(
                      'Product of the day',
                      style:
                          TxtStyle.h3.copyWith(color: const Color(0XFFA5A5BA)),
                    ),
                    SizedBox(
                      width: 40.w,
                      child: Text(
                        'Majority’s best choice',
                        style: TxtStyle.h3.copyWith(color: AppColor.white),
                      ),
                    ),
                    Text(
                      'See more',
                      style: TxtStyle.h3.copyWith(color: AppColor.orange),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      options: CarouselOptions(
        height: 18.h,
        aspectRatio: 16 / 5.5,
        viewportFraction: 0.85,
        initialPage: 1,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
