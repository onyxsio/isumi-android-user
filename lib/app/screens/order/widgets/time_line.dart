import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

Widget orderTimeLine() {
  return Column(
    children: <Widget>[
      timelineRow("Order Confirmed", 'Tuesday, 30th Aug 2021'),
      timelineRow("Order Inprocess", 'Tuesday, 30th Aug 2021'),
      timelineRow("Order Processed", "Tuesday, 30th Aug 2021"),
      timelineRow("Order Shipped", "Tuesday, 30th Aug 2021"),
      timelineLastRow("Order Delivered", "Tuesday, 30th Aug 2021"),
    ],
  );
}

Widget timelineRow(String title, String subTile) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Color(0XFF4A4A6A),
                shape: BoxShape.circle,
              ),
              child: const Text(""),
            ),
            Container(
              width: 3,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0XFF4A4A6A),
                shape: BoxShape.rectangle,
              ),
              child: const Text(""),
            ),
          ],
        ),
      ),
      Expanded(
        flex: 9,
        // child: Column(
        //   // mainAxisAlignment: MainAxisAlignment.center,
        //   mainAxisSize: MainAxisSize.min,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     Text('$title\n $subTile', style: TextStyles.l1),
        //   ],
        // ),
        child: RichText(
            text: TextSpan(children: [
          TextSpan(text: '$title\n', style: TxtStyle.b5B),
          TextSpan(text: subTile, style: TxtStyle.l5),
        ])),
      ),
    ],
  );
}

Widget timelineLastRow(String title, String subTile) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Color(0XFF4A4A6A),
                shape: BoxShape.circle,
              ),
              child: const Text(""),
            ),
            Container(
              width: 3,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle,
              ),
              child: const Text(""),
            ),
          ],
        ),
      ),
      Expanded(
        flex: 9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('$title\n $subTile',
                style: const TextStyle(
                    fontFamily: "regular",
                    fontSize: 14,
                    color: Colors.black54)),
          ],
        ),
      ),
    ],
  );
}
