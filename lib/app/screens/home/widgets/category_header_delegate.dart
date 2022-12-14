// import 'package:flutter/material.dart';
// import 'package:onyxsio/onyxsio.dart';

// class CategoryDelegate extends SliverPersistentHeaderDelegate {
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return _MenuButton();
//   }

//   @override
//   double get maxExtent => 55;

//   @override
//   double get minExtent => 54;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
//       true;
// }

// class _MenuButton extends StatefulWidget {
//   @override
//   State<_MenuButton> createState() => _MenuButtonState();
// }

// class _MenuButtonState extends State<_MenuButton> {
//   int selected = 0;
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       height: 55,
//       color: theme.backgroundColor,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 5.w),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: categories
//               .map((e) => InkWell(
//                     onTap: () {
//                       setState(() => selected = e.id);
//                     },
//                     child: Container(
//                         // width: 20.w,
//                         height: 5.h,
//                         padding: EdgeInsets.symmetric(horizontal: 5.w),
//                         decoration: BoxDecoration(
//                           color: selected == e.id ? yellowColor : whiteColor,
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Center(
//                             child: Text(e.name,
//                                 style: TextStyles.b1.copyWith(
//                                     color: selected == e.id
//                                         ? whiteColor
//                                         : blackColor)))),
//                   ))
//               .toList(),
//         ),
//       ),
//     );
//   }
// }
