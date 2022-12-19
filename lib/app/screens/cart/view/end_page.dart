import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class EndPage extends StatelessWidget {
  const EndPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawer = Provider.of<DrawerProvider>(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(AppImage.cong),
          Align(
            alignment: const Alignment(0, 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Congrats! Your Order has been placed!',
                  textAlign: TextAlign.center,
                  style: TxtStyle.h8,
                ),
                SizedBox(height: 4.5.w),
                Text('Thank you for your payment!',
                    textAlign: TextAlign.center, style: TxtStyle.l7),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(
        onTap: () {
          // drawer.scafoldKey.
          Navigator.pushNamedAndRemoveUntil(
              context, '/MainPage', (route) => false);
        },
        text: 'Back to home',
      ),
    );
  }
}
