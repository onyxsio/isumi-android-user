import 'package:isumi/core/util/image.dart';

class BottomNaviBar {
  final int id;
  final String image;
  final String name;
  final bool isNotifi;
  BottomNaviBar({
    required this.id,
    required this.image,
    required this.isNotifi,
    required this.name,
  });
}

List<BottomNaviBar> bottomNaviBar = [
  BottomNaviBar(id: 0, image: AppIcon.home, name: 'Home', isNotifi: false),
  BottomNaviBar(id: 1, image: AppIcon.box, name: 'Order', isNotifi: false),
  BottomNaviBar(id: 2, image: AppIcon.cart, name: 'cart', isNotifi: true),
  BottomNaviBar(
      id: 3, image: AppIcon.profile, name: 'profile', isNotifi: false),
];
