import 'package:app_provider/app_provider.dart';
import 'package:components/BoxDecoration/box_shadow.dart';
import 'package:components/components.dart';
import 'package:components/util/util.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<DrawerProvider>(context);
    return Padding(
      padding: EdgeInsets.only(right: 5.w),
      // GestureDetector
      child: GestureDetector(
        onTap: () {
          drawerProvider.key.currentState!.openDrawer();
        },
        child: SizedBox(width: 8.w, child: SvgPicture.asset(AppCIcon.menu)),
      ),
    );
  }
}

//
class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 14.w,
        width: 14.w,
        margin: EdgeInsets.all(1.5.w).copyWith(left: 5.w),
        padding: EdgeInsets.all(3.2.w),
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [AppBoxShadow.black],
          borderRadius: BorderRadius.circular(16),
        ),
        child: SvgPicture.asset(AppCIcon.backArrow),
      ),
    );
  }
}
//

class ListOrGridButton extends StatefulWidget {
  final Function(bool) onTap;
  const ListOrGridButton({Key? key, required this.onTap}) : super(key: key);

  @override
  State<ListOrGridButton> createState() => _ListOrGridButtonState();
}

class _ListOrGridButtonState extends State<ListOrGridButton> {
  bool isList = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => isList = !isList);
      },
      child: Container(
        margin: EdgeInsets.all(1.5.w).copyWith(left: 5.w),
        padding: EdgeInsets.all(2.5.w),
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [AppBoxShadow.black],
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          isList ? AppCIcon.list : AppCIcon.grid,
          width: 6.w,
        ),
      ),
    );
  }
}

//
class MainButton extends StatelessWidget {
  const MainButton({Key? key, required this.onTap, required this.text})
      : super(key: key);
  final Function() onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 15.w,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppColor.lightBlack,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(child: Text(text, style: TxtStyle.mainBtn))),
    );
  }
}

//
class ImageButton extends StatelessWidget {
  const ImageButton(
      {Key? key, required this.image, required this.onTap, required this.text})
      : super(key: key);
  final Function() onTap;
  final String text;
  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 15.w,
          // width: 60.w,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            color: AppColor.lightBlack,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                image,
                color: AppColor.white,
                height: 5.w,
              ),
              SizedBox(width: 5.w),
              Text(text, style: TxtStyle.mainBtn),
            ],
          )),
    );
  }
}

//
//
class CheckBoxButton extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;
  final String text;
  const CheckBoxButton({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: value,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          activeColor: AppColor.black2,
          onChanged: onChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: const VisualDensity(
            horizontal: -4,
          ),
        ),
        SizedBox(width: 2.w),
        Text(
          text,
          style: TxtStyle.mainBtn.copyWith(color: AppColor.lightBlack2),
        ),
      ],
    );
  }
}

//
class ImageWithTextButton extends StatelessWidget {
  const ImageWithTextButton(
      {Key? key,
      this.buttonGradient,
      required this.image,
      required this.onTap,
      required this.text})
      : super(key: key);
  final Function() onTap;
  final String text;
  final String image;
  final LinearGradient? buttonGradient;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 15.w,
          // width: 60.w,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            // color: color ?? AppColor.lightBlack,
            gradient: buttonGradient,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                image,
                color: AppColor.white,
                height: 5.w,
              ),
              SizedBox(width: 5.w),
              Text(text, style: TxtStyle.mainBtn),
            ],
          )),
    );
  }
}
