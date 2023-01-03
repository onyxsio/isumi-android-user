import 'package:flutter/material.dart';
import 'package:isumi/core/util/utils.dart';
import 'package:onyxsio/onyxsio.dart';

class ReviewPage extends StatelessWidget {
  final Customer customer;
  const ReviewPage({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'My reviews'),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 5.w),
        // children: [_buildListTile()],
        children: customer.review!.map((e) => _buildListTile(e)).toList(),
      ),
    );
  }
}

Widget _buildListTile(Review review) {
  return Container(
    padding: EdgeInsets.all(4.w),
    margin: EdgeInsets.only(bottom: 5.w),
    decoration: BoxDeco.deco_2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // titleRow(review.productName!),
        Text(review.productName!, maxLines: 3, style: TxtStyle.b5B),
        const SizedBox(height: 10),
        subTitleRow(review),
        const Divider(),
        const SizedBox(height: 10),
        Text(review.description!, style: TxtStyle.l5),
        const SizedBox(height: 10),
      ],
    ),
  );
}

// Row titleRow(String text) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       // Image.asset(AppImage.demoProduct, height: 20.w),
//       // SizedBox(width: 3.w),
//       Expanded(
//         child: Text(text, maxLines: 3, style: TxtStyle.b5B),
//       ),
//     ],
//   );
// }

Row subTitleRow(Review review) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      StarRating(rating: review.ratingValue!),
      Text(Utils.formatDate(review.date!), style: TxtStyle.b5B),
    ],
  );
}
