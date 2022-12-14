import 'package:components/components.dart';
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
      Text(text, style: TxtStyle.b5B.copyWith(color: const Color(0XFF32324D)));

  static Widget notificationSubHeader(String text) =>
      Text(text, style: TxtStyle.b4.copyWith(color: const Color(0XFFC0C0CF)));
}
