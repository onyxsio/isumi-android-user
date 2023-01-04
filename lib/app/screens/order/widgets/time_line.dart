import 'package:flutter/material.dart';
import 'package:isumi/core/util/utils.dart';
import 'package:onyxsio/onyxsio.dart';

Widget orderTimeLine(Orders order) {
  return Column(
    children: <Widget>[
      timelineRow("Order Placed", Utils.day(order.date!)),
      if (order.timeLine != null)
        Column(
          children: [
            if (order.timeLine!.confirmed != null)
              timelineRow(
                  "Order Confirmed", Utils.day(order.timeLine!.confirmed!)),
            if (order.timeLine!.inprocess != null)
              timelineRow(
                  "Order Inprocess", Utils.day(order.timeLine!.inprocess!)),
            if (order.timeLine!.processed != null)
              timelineRow(
                  "Order Processed", Utils.day(order.timeLine!.processed!)),
            if (order.timeLine!.shipped != null)
              timelineRow("Order Shipped", Utils.day(order.timeLine!.shipped!)),
            if (order.timeLine!.delivered != null)
              timelineLastRow(
                  "Order Delivered", Utils.day(order.timeLine!.delivered!)),
            timelineLastRow("We will deliver your order quickly.", ""),
          ],
        ),
      if (order.timeLine == null)
        timelineLastRow("We will deliver your order quickly.", ""),
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
              width: 5.w,
              height: 5.w,
              decoration: BoxDecoration(
                color: AppColor.lightBlack2,
                shape: BoxShape.circle,
              ),
              // child: const Text(""),
            ),
            Container(
              width: 3,
              height: 50,
              decoration: BoxDecoration(
                color: AppColor.lightBlack2,
                shape: BoxShape.rectangle,
              ),
              // child: const Text(""),
            ),
          ],
        ),
      ),
      Expanded(
        flex: 9,
        child: RichText(
            text: TextSpan(children: [
          TextSpan(text: '$title\n', style: TxtStyle.b5B),
          TextSpan(text: subTile, style: TxtStyle.l3),
        ])),
      ),
    ],
  );
}

Widget timelineLastRow(String title, String subTile) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Container(
          width: 5.w,
          height: 5.w,
          decoration: BoxDecoration(
            color: AppColor.lightBlack2,
            shape: BoxShape.circle,
          ),
          // child: const Text(""),
        ),
      ),
      Expanded(
        flex: 9,
        child: Text('$title\n $subTile', style: TxtStyle.l3),
      ),
    ],
  );
}

Column buildProductTile(Items item) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Product :',
        style: TxtStyle.b5B,
      ),
      SizedBox(height: 3.w),
      Text(item.name!, style: TxtStyle.reviews),
      SizedBox(height: 3.w),
      Table(
        border: TableBorder.symmetric(
            outside: BorderSide(width: 0.5, color: AppColor.divider)),
        children: [
          TableRow(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.02),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  )),
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: SizedBox(
                    height: 8.w,
                    child: Center(
                      child: Text(
                        'Size',
                        textAlign: TextAlign.center,
                        style: TxtStyle.reviews,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    'Quantity',
                    textAlign: TextAlign.center,
                    style: TxtStyle.reviews,
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    'Color',
                    textAlign: TextAlign.center,
                    style: TxtStyle.reviews,
                  ),
                ),
              ]),
          // for (int o = 0; o < item.variants!.length; o++)
          // for (int j = 0; j < item.variants![o].subvariants!.length; j++)
          TableRow(
            children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: SizedBox(
                  height: 10.w,
                  child: Center(
                    child: Text('${item.size}',
                        textAlign: TextAlign.center, style: TxtStyle.b5B),
                  ),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Text('${item.quantity}',
                    textAlign: TextAlign.center, style: TxtStyle.header),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                  height: 7.w,
                  width: 7.w,
                  // margin: EdgeInsets.only(top: 2.w),
                  decoration: BoxDecoration(
                    // color: Colors.red.withOpacity(0.2),
                    color: Color(int.parse(item.color!)),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      SizedBox(height: 5.w),
    ],
  );
}
