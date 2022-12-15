import 'package:components/components.dart';
import 'package:components/util/util.dart';
import 'package:flutter/material.dart';

class TXTHeader {
  //
  static Widget header1(String text) => Text(
        text,
        style: TxtStyle.pageHeader,
      );

  //
  static Widget header2(String text) => Text(
        text,
        textAlign: TextAlign.center,
        style: TxtStyle.header,
      );
  static Widget settingsHeader(String text) => Text(text, style: TxtStyle.b5B);
  static Widget header3(String text) => Text(text, style: TxtStyle.header3);

  static Widget pageHeader(String text) =>
      Text(text, style: TxtStyle.h7.copyWith(color: AppColor.black4));

  static Widget tabbarHeader(String text) => Text(text, style: TxtStyle.h5L);

  //
  static Widget notificationHeader(String text) =>
      Text(text, style: TxtStyle.b5B.copyWith(color: AppColor.black4));

  static Widget notificationSubHeader(String text) =>
      Text(text, style: TxtStyle.b4.copyWith(color: AppColor.gray3));

  static Widget cartListTileSubHeader(String text) => Text(text,
      style: TxtStyle.b5.copyWith(color: AppColor.error.withOpacity(0.5)));

  static Widget cartListTilePrice(String text, String currency) =>
      Text(Utils.currency(name: currency, amount: double.parse(text)),
          style: TxtStyle.b10B);
}
