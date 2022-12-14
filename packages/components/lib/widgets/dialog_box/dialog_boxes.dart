import 'package:flutter/material.dart';
import 'auto_close.dart';

class DialogBoxes {
  // static BuildContext? _context;

  // static void setContext(BuildContext context) =>
  //     AutoCloseDialog._context = context;

  static void showAutoCloseDialog(BuildContext context,
          {required String message, required InfoDialog type}) async =>
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AutoDialogBoxUI(
              infoDialog: type,
              message: message,
            );
          });
  //
  static void showAutoCloseDialogWithAnimation(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return const AutoDialogBoxUI(
          infoDialog: InfoDialog.successful,
          message:
              "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}

enum InfoDialog { successful, error, warning }

enum AlertDialog { successful, error, warning }
