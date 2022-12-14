import 'package:flutter/material.dart';

class KeyboardUnfocus extends StatelessWidget {
  final Widget child;
  const KeyboardUnfocus({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //get the currnet focus node
        FocusScopeNode currentfocus = FocusScope.of(context);
        //prevent Flutter from throwing an exception
        if (!currentfocus.hasPrimaryFocus &&
            currentfocus.focusedChild != null) {
          //unfocust from current focust, so that keyboard will dismiss
          // currentfocus.unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}
