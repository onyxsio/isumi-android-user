import 'package:flutter/material.dart';
import 'package:isumi/app/screens/home/home_page.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late Customer customer;
  bool isLoading = false;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() => isLoading = true);
    customer = await FireRepo.getCustomer();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // final user = context.select((AppBloc bloc) => bloc.state.user);
    // log(70.h.toString());
    var closeButton = IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.close_outlined),
    );
    return Drawer(
      width: double.infinity,
      backgroundColor: AppColor.white,
      child: isLoading
          ? const Center(child: HRDots())
          : SafeArea(
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
                          margin:
                              EdgeInsets.only(top: 6.h, left: 5.w, bottom: 5.w),
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDeco.deco_10,
                          child: CachedNetworkImage(
                            imageUrl: customer.photoUrls!,
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                                    radius: 6.h,
                                    backgroundImage: imageProvider),
                            placeholder: (context, url) => AppLoading.profile,
                            errorWidget: (context, url, error) =>
                                AppLoading.profile,
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
                        // DrawerButton(
                        //     text: 'Settings',
                        //     onTap: () {
                        //       Navigator.pushNamed(context, '/SettingsPage');
                        //     }),
                        // DrawerButton(
                        //     text: 'Notification',
                        //     onTap: () {
                        //       Navigator.pushNamed(context, '/NotificationPage');
                        //     }),
                        // const Spacer(flex: 1),
                        // Container(
                        //   height: 2,
                        //   width: 100,
                        //   color: const Color(0XFF8E8EA9).withOpacity(0.5),
                        // ),
                        // const Spacer(flex: 1),
                        DrawerButton(
                            text: 'About',
                            onTap: () {
                              Navigator.pushNamed(context, '/SupportPage',
                                  arguments: 'about');
                            }),
                        // DrawerButton(
                        //     text: 'Help & Support ',
                        //     onTap: () {
                        //       Navigator.pushNamed(context, '/SupportPage',
                        //           arguments: 'help');
                        //     }),
                        // DrawerButton(
                        //     text: 'Terms & conditions ',
                        //     onTap: () {
                        //       Navigator.pushNamed(context, '/SupportPage',
                        //           arguments: 'terms');
                        //     }),
                        const Spacer(flex: 2),
                        InkWell(
                          onTap: () {
                            context.read<AppBloc>().add(AppLogoutRequested());
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(AppIcon.logout),
                              const Text("   Logout"),
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
                              // right: -50,
                              right: -70.w,
                              child: Container(
                                height: 60.h, //450
                                // width: 55.w,
                                width: 120.w,
                                decoration: BoxDeco.deco_2,
                              ),
                            ),
                            Positioned(
                              bottom: -15.h,
                              // right: -75,
                              right: -80.w,
                              child: Container(
                                height: 72.h, // 550,
                                // width: 55.w,
                                width: 120.w,
                                decoration: BoxDeco.deco_2,
                              ),
                            ),
                            // Positioned(
                            //   bottom: -10.h,
                            //   right: -100,
                            //   child: Container(
                            //       height: 85.h, // 650,
                            //       width: 55.w,
                            //       padding: EdgeInsets.all(5.w),
                            //       decoration: BoxDeco.deco_2,
                            //       child: const MiniMainPage()),
                            // ),

                            Positioned(
                              bottom: -10.h,
                              right: -90.w,
                              child: Container(
                                height: 85.h,
                                width: 120.w,
                                padding: EdgeInsets.all(1.w),
                                decoration: BoxDeco.deco_2,
                                child: const HomePage(),
                              ),
                            ),
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
