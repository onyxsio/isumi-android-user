import '/components.dart';
import '/util/util.dart';
import 'package:flutter/material.dart';

//
appBar({required String text}) => AppBar(
      elevation: 0,
      leadingWidth: 20.w,
      leading: const ArrowBackButton(),
      title: TXTHeader.header1(text),
    );
// APP Bars
mainAppBar({required String text}) => AppBar(
      elevation: 0,
      title: TXTHeader.header1(text),
      actions: const [MenuButton()],
    );
secondaryAppBar() => AppBar(
      elevation: 0,
      leadingWidth: 20.w,
      leading: const ArrowBackButton(),
    );
ternaryAppBar({required String text}) => AppBar(
      elevation: 0,
      leadingWidth: 20.w,
      title: TXTHeader.header3(text),
      leading: const ArrowBackButton(),
    );
// !
bottomNavigationBar({required Function() onTap, required String text}) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(bottom: 3.h),
      child: MainButton(
        text: text,
        onTap: onTap,
      ),
    );
//
searchPageAppBar(
        {required Function() onTap,
        required Function(String) onSubmitted,
        required TextEditingController controller}) =>
    AppBar(
      leading: const ArrowBackButton(),
      leadingWidth: 20.w,
      title: TXTHeader.header1('Search products'),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(10.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDeco.overview,
          child: Row(
            children: [
              SvgPicture.asset(AppCIcon.search),
              SizedBox(width: 3.w),
              Expanded(
                child: TextField(
                  controller: controller,
                  autofocus: false,
                  style: TxtStyle.searchBox,
                  textInputAction: TextInputAction.search,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.text,
                  onSubmitted: onSubmitted,
                  decoration: const InputDecoration(hintText: 'search'),
                ),
              ),
              // TODO
              // InkWell(onTap: onTap, child: SvgPicture.asset(AppCIcon.filter))
            ],
          ),
        ),
      ),
    );

// ********
