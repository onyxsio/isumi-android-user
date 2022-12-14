import 'package:components/components.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final String rating;

  const StarRating({Key? key, required this.rating}) : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= double.parse(rating)) {
      icon = Icon(Icons.star_border, color: AppColor.black3, size: 5.w);
    } else if (index > double.parse(rating) - 1 &&
        index < double.parse(rating)) {
      icon = Icon(Icons.star_half, color: AppColor.black3, size: 5.w);
    } else {
      icon = Icon(Icons.star, color: AppColor.black3, size: 5.w);
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: List.generate(5, (index) => buildStar(context, index)));
  }
}
