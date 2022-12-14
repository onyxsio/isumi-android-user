import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text, img;
  // final Image img;
  const CustomDialogBox(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.text,
      required this.img})
      : super(key: key);

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
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
                widget.title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 3.h),
              Text(
                widget.descriptions,
                style: TextStyle(fontSize: 12.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      widget.text,
                      style: const TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: 5.w,
          right: 5.w,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: 11.w,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(11.w)),
              child: SvgPicture.asset(
                widget.img,
                fit: BoxFit.cover,
              ),
              // child: Image.asset("assets/model.jpeg"),
            ),
          ),
        ),
      ],
    );
  }
}
