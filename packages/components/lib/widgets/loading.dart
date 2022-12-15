import 'package:components/components.dart';
import 'package:flutter/cupertino.dart';

class AppLoading {
  //

  static Widget shimmerloader({required Widget child}) {
    return Shimmer(
      linearGradient: AppColor.shimmerGradient,
      child: ShimmerLoading(isLoading: true, child: child),
    );
  }

  static Widget productCard = Container(
    padding: EdgeInsets.all(3.w),
    decoration: BoxDeco.deco_3,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shimmerloader(
          child: Container(height: 35.w, color: AppColor.shimmerLight),
        ),
        shimmerloader(
          child:
              Container(width: 15.w, height: 5.w, color: AppColor.shimmerLight),
        ),
        shimmerloader(
          child: Container(height: 5.w, color: AppColor.shimmerLight),
        ),
      ],
    ),
  );
  static Widget productList = GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 5.h,
      crossAxisSpacing: 5.w,
      childAspectRatio: 0.75,
    ),
    itemCount: 8,
    itemBuilder: (context, index) => productCard,
  );

  static Widget adCarousel = Shimmer(
    linearGradient: AppColor.shimmerGradient,
    child: ShimmerLoading(
      isLoading: true,
      child: Container(
        height: 35.w,
        margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 5.w),
        decoration: BoxDecoration(
          color: AppColor.shimmerLight,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );

  static Widget cartimage = Shimmer(
    linearGradient: AppColor.shimmerGradient,
    child: ShimmerLoading(
      isLoading: true,
      child: Container(
        height: 25.w,
        width: 15.w,
        decoration: BoxDecoration(
          color: AppColor.shimmerLight,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
  );
}
