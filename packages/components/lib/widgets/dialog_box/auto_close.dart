import 'dart:async';
import 'package:components/components.dart';
import 'package:flutter/material.dart';

class AutoDialogBoxUI extends StatefulWidget {
  final String message;

  final InfoDialog infoDialog;
  final Duration? duration;
  const AutoDialogBoxUI({
    Key? key,
    this.duration,
    required this.infoDialog,
    required this.message,
  }) : super(key: key);

  @override
  State<AutoDialogBoxUI> createState() => _AutoDialogBoxUIState();
}

class _AutoDialogBoxUIState extends State<AutoDialogBoxUI> {
  String title = '', img = '';
  @override
  void initState() {
    Timer(widget.duration ?? const Duration(seconds: 3), () {
      Navigator.pop(context);
    });
    getTitel();
    super.initState();
  }

  void getTitel() {
    setState(() {
      switch (widget.infoDialog) {
        case InfoDialog.successful:
          title = 'successful';
          img = 'assets/images/ok.png';
          break;
        case InfoDialog.error:
          img = 'assets/images/error.png';
          title = 'error';
          break;
        case InfoDialog.warning:
          img = 'assets/images/stop.png';
          title = 'warning';
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w)
              .copyWith(top: 15.w),
          margin: EdgeInsets.only(top: 10.w),
          decoration: BoxDeco.deco_8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title, style: TxtStyle.b12),
              SizedBox(height: 3.h),
              Center(
                child: Text(
                  widget.message,
                  style: TxtStyle.l5,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 3.h),
            ],
          ),
        ),
        Positioned(
          left: 5.w,
          right: 5.w,
          child: CircleAvatar(
            backgroundColor: AppColor.white,
            radius: 11.w,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(11.w)),
              // child: widget.img,
              child: Image.asset(img),
            ),
          ),
        ),
      ],
    );
  }
}
