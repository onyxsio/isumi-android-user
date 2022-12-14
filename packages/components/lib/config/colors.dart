import 'package:flutter/material.dart';

//

class AppColor {
  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF2B2B2B);
  static Color error = const Color(0xFFBF0A0A);
  static Color inputBorder = const Color(0xFFEAEAEF);
  static Color gray = const Color(0XFFDCDCE4);
  static Color orange = const Color(0XFFFF7B2C);
  static Color yellow = const Color(0xFFFFB01D);
  static Color blue = const Color(0xFF1488CC);

  static Color menuSelected = const Color(0XFF3C4B7B);
  static Color menuUnselect = const Color(0XFF8E8EA9);

  static Color text = const Color(0XFF32324D);
  static Color lightBlack = const Color(0xFF3A4256);
  static Color lightBlack2 = const Color(0XFF4A4A6A);
  static Color black2 = const Color(0XFF303030);
  static Color black3 = const Color(0xFF3A4256);
  static Color black4 = const Color(0XFF32324D);

  static Color gray1 = const Color(0XFFA5A5BA);
  static Color gray2 = const Color(0XFF666687);
  static Color divider = const Color(0XFFEAEAEF);
  //const Color() #1488CC
  static LinearGradient shimmerGradient = const LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
  //
  static LinearGradient frostGradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0XFF000428),
        Color(0XFF004e92),
      ]);

  static LinearGradient friewatchGradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0XFFcb2d3e),
        Color(0XFFef473a),
      ]);
}
