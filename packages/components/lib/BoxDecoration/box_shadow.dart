import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

class AppBoxShadow {
  //
  static BoxShadow topMenuButton = BoxShadow(
    color: AppColor.black.withOpacity(0.2),
    blurRadius: 10.0,
    offset: const Offset(2.0, 3.0),
  );
  //
  static BoxShadow black = BoxShadow(
    color: AppColor.black.withOpacity(0.1),
    blurRadius: 12.0,
    offset: const Offset(0.0, 0.0),
  );

  static BoxShadow itemCard = BoxShadow(
    color: AppColor.black.withOpacity(0.1),
    blurRadius: 5.0,
    offset: const Offset(3, 5),
  );
  static List<BoxShadow> shadowList = [
    BoxShadow(
      color: const Color(0XFF727272).withOpacity(0.2),
      blurRadius: 5,
      offset: const Offset(-2, -2),
    )
  ];
}
