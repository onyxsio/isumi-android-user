import 'package:flutter/material.dart';
import 'package:isumi/app/models/bottom_menu.dart';
import 'package:isumi/core/util/list.dart';
import 'package:onyxsio/onyxsio.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController();
  int select = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FCMProvider.setContext(context);
    });
    getNotificationMessages();
    super.initState();
  }

  getNotificationMessages() async {
    final RemoteMessage? message =
        await NotificationService.firebaseMessaging.getInitialMessage();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (message != null) {
        Future.delayed(const Duration(milliseconds: 500), () async {
          // Navigator.of(context).pushNamed('/GenerateBill');
          controller.jumpToPage(2);
          // FlutterAppBadger.removeBadge();
        });
      }
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    final drawer = Provider.of<DrawerProvider>(context);
    final badge = Provider.of<NotificationBadge>(context).badge;
    return Scaffold(
      key: drawer.key,
      // drawer: const MyDrawer(),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        itemBuilder: (itemBuilder, index) {
          return mainPages[index];
        },
        itemCount: mainPages.length,
      ),
      bottomNavigationBar: _buildBottomAppBar(badge),
    );
  }

  BottomAppBar _buildBottomAppBar(badge) {
    return BottomAppBar(
      child: Container(
        height: 9.h,
        padding: EdgeInsets.only(top: 2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: bottomNaviBar
              .map((e) => GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.jumpToPage(e.id);
                        select = e.id;
                      });
                    },
                    child: _buildButton(e, select == e.id, badge),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildButton(BottomNaviBar e, bool isClick, badge) {
    return Container(
      constraints: BoxConstraints(minWidth: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            children: [
              SvgPicture.asset(
                e.image,
                color: isClick ? AppColor.menuSelected : AppColor.menuUnselect,
              ),
              if (e.isNotifi && badge)
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 1.5.w,
                    backgroundColor: AppColor.error,
                  ),
                )
            ],
          ),
          Text(
            e.name,
            style: isClick ? TxtStyle.menuSelected : TxtStyle.menuUnselected,
          )
        ],
      ),
    );
  }
}
