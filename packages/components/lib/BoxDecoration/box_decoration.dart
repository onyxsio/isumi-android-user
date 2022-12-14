import 'package:onyxsio/onyxsio.dart';
import 'box_shadow.dart';
import 'package:flutter/material.dart';

class BoxDeco {
  //
  static BoxDecoration menuButton = BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColor.white, width: 3),
      color: AppColor.gray,
      boxShadow: [AppBoxShadow.topMenuButton]);
  // 5
  static BoxDecoration overview = BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: AppColor.white,
      boxShadow: [AppBoxShadow.black]);

  static BoxDecoration itemCard = BoxDecoration(
    color: AppColor.white,
    boxShadow: [AppBoxShadow.itemCard],
    borderRadius: BorderRadius.circular(16),
  );
//
  static BoxDecoration notifiCard = BoxDecoration(
    color: AppColor.error,
    boxShadow: [AppBoxShadow.black],
    borderRadius: BorderRadius.circular(16),
  );
// 2
  static BoxDecoration itemSizeCard = BoxDecoration(
    color: AppColor.white,
    border: Border.all(width: 1, color: AppColor.inputBorder),
    borderRadius: BorderRadius.circular(16),
  );

  static BoxDecoration textbox(hasError) => BoxDecoration(
        color: AppColor.white,
        border: Border.all(
            width: 1, color: hasError ? AppColor.error : AppColor.inputBorder),
        borderRadius: BorderRadius.circular(16),
      );

  static BoxDecoration subveriantbox(click) => BoxDecoration(
        color: click ? AppColor.yellow : null,
        border:
            click ? null : Border.all(width: 1, color: AppColor.menuUnselect),
        borderRadius: BorderRadius.circular(10),
      );

  static BoxDecoration drawerS = BoxDecoration(
    color: AppColor.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: AppBoxShadow.shadowList,
  );
  //
  static BoxDecoration selectedCard = BoxDecoration(
    color: AppColor.blue.withOpacity(0.3),
    boxShadow: [AppBoxShadow.itemCard],
    borderRadius: BorderRadius.circular(16),
  );
  // static BoxDecoration unselectedCard = BoxDecoration(
  //   color: AppColor.white,
  //   boxShadow: [AppBoxShadow.itemCard],
  //   borderRadius: BorderRadius.circular(16),
  // );
}
