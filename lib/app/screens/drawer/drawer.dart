import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

import 'widget/mini_main_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var closeButton = IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.close_outlined),
    );
    return Drawer(
      width: double.infinity,
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20.w,
                    width: 20.w,
                    margin: EdgeInsets.only(top: 6.h, left: 5.w, bottom: 5.w),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0XFF727272).withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(0, 4),
                        )
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "https://i.stack.imgur.com/l60Hf.png",
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 6.h, backgroundImage: imageProvider),
                      placeholder: (context, url) => CircleAvatar(radius: 6.h),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const Spacer(flex: 1),
                  // DrawerButton(
                  //     text: 'Home',
                  //     onTap: () {
                  //       Navigator.pushNamed(context, '/');
                  //     }),
                  // DrawerButton(
                  //     text: 'Account Settings',
                  //     onTap: () {
                  //       Navigator.pushNamed(context, '/AccountSettingsPage');
                  //     }),
                  DrawerButton(
                      text: 'Scan to review',
                      onTap: () {
                        Navigator.pushNamed(context, '/ScanToReview');
                      }),
                  DrawerButton(
                      text: 'Wishlist',
                      onTap: () {
                        Navigator.pushNamed(context, '/WishListPage');
                      }),
                  DrawerButton(
                      text: 'Settings',
                      onTap: () {
                        Navigator.pushNamed(context, '/SettingsPage');
                      }),
                  DrawerButton(
                      text: 'Notification',
                      onTap: () {
                        Navigator.pushNamed(context, '/NotificationPage');
                      }),
                  const Spacer(flex: 1),
                  Container(
                    height: 2,
                    width: 100,
                    color: const Color(0XFF8E8EA9).withOpacity(0.5),
                  ),
                  const Spacer(flex: 1),
                  DrawerButton(
                      text: 'About',
                      onTap: () {
                        Navigator.pushNamed(context, '/SupportPage',
                            arguments: 'about');
                      }),
                  DrawerButton(
                      text: 'Help & Support ',
                      onTap: () {
                        Navigator.pushNamed(context, '/SupportPage',
                            arguments: 'help');
                      }),
                  DrawerButton(
                      text: 'Terms & conditions ',
                      onTap: () {
                        Navigator.pushNamed(context, '/SupportPage',
                            arguments: 'terms');
                      }),
                  const Spacer(flex: 2),
                  InkWell(
                    onTap: () {
                      context.read<AppBloc>().add(AppLogoutRequested());
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(AppIcon.logout),
                        const Text("Logout"),
                      ],
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
              Expanded(
                child: EntranceFader(
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: -15.h,
                        right: -50,
                        child: Container(
                          height: 450,
                          width: 200,
                          decoration: BoxDeco.deco_2,
                        ),
                      ),
                      Positioned(
                        bottom: -15.h,
                        right: -75,
                        child: Container(
                          height: 550,
                          width: 200,
                          decoration: BoxDeco.deco_2,
                        ),
                      ),
                      Positioned(
                        bottom: -15.h,
                        right: -100,
                        child: Container(
                            height: 650,
                            width: 200,
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDeco.deco_3,
                            child: const MiniMainPage()),
                      ),
                      // Positioned(
                      //   bottom: -10,
                      //   right: -100,
                      //   child: Container(
                      //     height: 700,
                      //     width: 200,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(20),
                      //       boxShadow: shadowList,
                      //     ),
                      //   ),
                      // ),
                      Positioned(top: 5.h, right: 5.w, child: closeButton)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  const DrawerButton({Key? key, required this.text, required this.onTap})
      : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 10.w,
        child: Text(text, style: TxtStyle.h5),
      ),
    );
  }
}
