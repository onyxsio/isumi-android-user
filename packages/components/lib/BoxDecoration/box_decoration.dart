import 'box_shadow.dart';
import 'package:flutter/material.dart';
import 'package:components/config/colors.dart';

class BoxDeco {
  //
  static BoxDecoration deco_1 = BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColor.white, width: 3),
      color: AppColor.gray,
      boxShadow: [AppBoxShadow.topMenuButton]);
  // 5
  static BoxDecoration deco_2 = BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: AppColor.white,
      boxShadow: [AppBoxShadow.black]);

  static BoxDecoration deco_3 = BoxDecoration(
    color: AppColor.white,
    boxShadow: [AppBoxShadow.itemCard],
    borderRadius: BorderRadius.circular(16),
  );
//
  static BoxDecoration deco_4 = BoxDecoration(
    color: AppColor.error,
    boxShadow: [AppBoxShadow.black],
    borderRadius: BorderRadius.circular(16),
  );
  // 2
  static BoxDecoration deco_5 = BoxDecoration(
    color: AppColor.white,
    border: Border.all(width: 1, color: AppColor.inputBorder),
    borderRadius: BorderRadius.circular(16),
  );
  static BoxDecoration deco_6 = BoxDecoration(
    color: AppColor.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: AppBoxShadow.shadowList,
  );
  //
  static BoxDecoration deco_7 = BoxDecoration(
    color: AppColor.blue.withOpacity(0.3),
    boxShadow: [AppBoxShadow.itemCard],
    borderRadius: BorderRadius.circular(16),
  );

  static BoxDecoration deco_8 = BoxDecoration(
    color: AppColor.white,
    boxShadow: AppBoxShadow.arletbox,
    borderRadius: BorderRadius.circular(16),
  );
  static BoxDecoration deco_9 = BoxDecoration(
    color: const Color(0XFF3C4B7B),
    boxShadow: [AppBoxShadow.itemCard],
    borderRadius: BorderRadius.circular(16),
  );
  static BoxDecoration deco_1m(hasError) => BoxDecoration(
        color: AppColor.white,
        border: Border.all(
            width: 1, color: hasError ? AppColor.error : AppColor.inputBorder),
        borderRadius: BorderRadius.circular(16),
      );

  static BoxDecoration deco_2m(click) => BoxDecoration(
        color: click ? AppColor.yellow : null,
        border:
            click ? null : Border.all(width: 1, color: AppColor.menuUnselect),
        borderRadius: BorderRadius.circular(10),
      );

  static BoxDecoration unselected = BoxDecoration(
    color: AppColor.gray,
    // boxShadow: [AppBoxShadow.itemCard],
    borderRadius: BorderRadius.circular(10),
  );
}
