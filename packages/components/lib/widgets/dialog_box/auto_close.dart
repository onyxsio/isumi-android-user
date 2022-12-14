import 'dart:async';
import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';
// import 'dialog_boxes.dart';

class AutoDialogBoxUI extends StatefulWidget {
  final String message;
  final Widget? img;
  final InfoDialog infoDialog;
  final Duration? duration;
  const AutoDialogBoxUI(
      {Key? key,
      this.duration,
      required this.infoDialog,
      required this.message,
      this.img})
      : super(key: key);

  @override
  State<AutoDialogBoxUI> createState() => _AutoDialogBoxUIState();
}

class _AutoDialogBoxUIState extends State<AutoDialogBoxUI> {
  String title = '';
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
          break;
        case InfoDialog.error:
          title = 'error';
          break;
        case InfoDialog.warning:
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
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 10),
                    blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 3.h),
              Center(
                child: Text(
                  widget.message,
                  style: TextStyle(fontSize: 12.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 3.h),
            ],
          ),
        ),
        if (widget.img != null)
          Positioned(
            left: 5.w,
            right: 5.w,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 11.w,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(11.w)),
                child: widget.img,
                // child: Image.asset("assets/model.jpeg"),
              ),
            ),
          ),
      ],
    );
  }
}
