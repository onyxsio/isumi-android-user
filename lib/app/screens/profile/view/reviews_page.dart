import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'My reviews'),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 5.w),
        children: [
          _buildListTile(),
          _buildListTile(),
          _buildListTile(),
        ],
      ),
    );
  }
}

Widget _buildListTile() {
  return Container(
    padding: EdgeInsets.all(4.w),
    margin: EdgeInsets.only(bottom: 5.w),
    decoration: BoxDeco.deco_2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        titleRow(),
        const SizedBox(height: 10),
        subTitleRow(),
        const Divider(),
        const SizedBox(height: 10),
        Text(
          'Nice Shirt with good delivery. The delivery time is very fast. Then products look like exactly the picture in the app. Besides, color is also the same and quality is very good despite very cheap price ',
          style: TxtStyle.l5,
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}

Row titleRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      // Image.asset(AppImage.demoProduct, height: 20.w),
      SizedBox(width: 3.w),
      Expanded(
        child: Text('Printed Shirt Use as a default payment method',
            maxLines: 3, style: TxtStyle.b5B),
      ),
    ],
  );
}

Row subTitleRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const StarRating(rating: '4.5'),
      Text('20/03/2020', style: TxtStyle.b5B),
    ],
  );
}
