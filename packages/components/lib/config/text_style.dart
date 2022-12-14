import 'package:onyxsio/onyxsio.dart';
import 'package:flutter/material.dart';

//
class Fonts {
  static String get body => "Mulish";
  static String get title => "DMSans";
}
//

class TxtStyle {
  //
  static FontWeight b = FontWeight.bold;
  static FontWeight l = FontWeight.w300;
  static FontWeight sb = FontWeight.w500;
  //
  static TextStyle get bodyFont => TextStyle(fontFamily: Fonts.body);
  static TextStyle get titleFont => TextStyle(fontFamily: Fonts.title);
  static TextStyle get lableFont =>
      TextStyle(fontFamily: Fonts.body, color: AppColor.menuUnselect);
  //
  static TextStyle get b1 => bodyFont.copyWith(fontSize: 8.sp);
  static TextStyle get b2 => bodyFont.copyWith(fontSize: 9.sp);
  static TextStyle get b3 => bodyFont.copyWith(fontSize: 10.sp);
  static TextStyle get b4 => bodyFont.copyWith(fontSize: 11.sp);
  static TextStyle get b5 => bodyFont.copyWith(fontSize: 12.sp);
  static TextStyle get b6 => bodyFont.copyWith(fontSize: 13.sp);
  static TextStyle get b7 => bodyFont.copyWith(fontSize: 14.sp);
  static TextStyle get b8 => bodyFont.copyWith(fontSize: 15.sp);
  static TextStyle get b9 => bodyFont.copyWith(fontSize: 16.sp);
  static TextStyle get b10 => bodyFont.copyWith(fontSize: 17.sp);
  static TextStyle get b11 => bodyFont.copyWith(fontSize: 18.sp);
  static TextStyle get b12 => bodyFont.copyWith(fontSize: 19.sp);
  static TextStyle get b13 => bodyFont.copyWith(fontSize: 20.sp);
  //
  static TextStyle get h1 => titleFont.copyWith(fontSize: 8.sp);
  static TextStyle get h2 => titleFont.copyWith(fontSize: 9.sp);
  static TextStyle get h3 => titleFont.copyWith(fontSize: 10.sp);
  static TextStyle get h4 => titleFont.copyWith(fontSize: 11.sp);
  static TextStyle get h5 => titleFont.copyWith(fontSize: 12.sp);
  static TextStyle get h6 => titleFont.copyWith(fontSize: 13.sp);
  static TextStyle get h7 => titleFont.copyWith(fontSize: 14.sp);
  static TextStyle get h8 => titleFont.copyWith(fontSize: 15.sp);
  static TextStyle get h9 => titleFont.copyWith(fontSize: 16.sp);
  static TextStyle get h10 => titleFont.copyWith(fontSize: 17.sp);
  static TextStyle get h11 => titleFont.copyWith(fontSize: 18.sp);
  static TextStyle get h12 => titleFont.copyWith(fontSize: 19.sp);
  static TextStyle get h13 => titleFont.copyWith(fontSize: 20.sp);
  static TextStyle get h14 => titleFont.copyWith(fontSize: 21.sp);
  static TextStyle get h15 => titleFont.copyWith(fontSize: 22.sp);
  static TextStyle get h16 => titleFont.copyWith(fontSize: 23.sp);
  //
  // used: 6
  static TextStyle get b5B => b5.copyWith(fontWeight: b);
  static TextStyle get b6B => b6.copyWith(fontWeight: b);
  static TextStyle get b3B => b3.copyWith(fontWeight: b);
  static TextStyle get b8B => b8.copyWith(fontWeight: sb);
  //
  static TextStyle get h14B => h14.copyWith(fontWeight: b);
  static TextStyle get h9B => h9.copyWith(fontWeight: b);
  //
  static TextStyle get l7 => lableFont.copyWith(fontSize: 14.sp);
  //
  static TextStyle get menuSelected =>
      bodyFont.copyWith(fontWeight: b, color: AppColor.menuSelected);

  static TextStyle get menuUnselected =>
      bodyFont.copyWith(color: AppColor.menuUnselect);

  static TextStyle get topMenuButton =>
      b3.copyWith(color: AppColor.text, fontWeight: b);

  static TextStyle get pageHeader => titleFont.copyWith(color: AppColor.text);
  static TextStyle get pageSubHeader => titleFont.copyWith(fontSize: 14.sp);

  static TextStyle get overviewTileHeader =>
      b6.copyWith(color: AppColor.text, fontWeight: b);

  static TextStyle get overviewTileBody =>
      b8.copyWith(color: AppColor.orange, fontWeight: b);

  static TextStyle get searchBox => b7;

  static TextStyle get itemsFound => b7;

  static TextStyle get itemDelete => h7.copyWith(color: AppColor.error);
  // Used 2
  static TextStyle get itemUpdate => h7;

  static TextStyle get itemCardHeading => b5;

  static TextStyle get itemCardcurrency => b6.copyWith(color: AppColor.text);

  static TextStyle get itemCardPrice =>
      b10.copyWith(fontWeight: b, color: AppColor.text);

  static TextStyle get mainBtn =>
      b7.copyWith(fontWeight: sb, color: AppColor.white);
  // Used 7
  static TextStyle get header => h7.copyWith(fontWeight: b);

  static TextStyle get header3 => h8.copyWith(color: AppColor.menuUnselect);

  static TextStyle get header4 => h7;

  static TextStyle get header4B => h7.copyWith(fontWeight: b);
  // Used: 3
  static TextStyle get reviews => b5.copyWith(color: AppColor.gray1);

  static TextStyle get price =>
      h16.copyWith(fontWeight: b, color: AppColor.text);

  static TextStyle get currency => h6.copyWith(color: AppColor.text);

  static TextStyle size(click) => h5.copyWith(
      fontWeight: b, color: click ? AppColor.white : AppColor.menuUnselect);
//  Used 2
  static TextStyle get settingSubtitle =>
      b3.copyWith(color: AppColor.menuUnselect);
// Used 3
  static TextStyle get settinSubTitle =>
      b5.copyWith(color: AppColor.menuUnselect);
//  used 3
  static TextStyle get l1 => b2.copyWith(color: AppColor.gray2);
  static TextStyle get l1B => l1.copyWith(fontWeight: b);
  static TextStyle get l3 => b5.copyWith(color: AppColor.gray2);
  static TextStyle get l3B => l3.copyWith(fontWeight: b);
//
  static TextStyle get error => b3.copyWith(color: AppColor.error);
  // static TextStyle get l3 => b5.copyWith(color: AppColor.gray2);
  static TextStyle get h4L => h4.copyWith(color: AppColor.gray2, fontWeight: l);
  static TextStyle get h5L => h5.copyWith(color: AppColor.text, fontWeight: l);
}
