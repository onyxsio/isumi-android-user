import 'dart:ui';

import 'package:flutter/material.dart';

class FocusedMenuDetails extends StatelessWidget {
  final Offset childOffset;
  final Size childSize;
  final Widget menuContent;
  final Widget child2;

  const FocusedMenuDetails({
    Key? key,
    required this.menuContent,
    required this.childOffset,
    required this.childSize,
    required this.child2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final maxMenuWidth = size.width * 0.6;
    final menuHeight = size.height * 0.15;
    final leftOffset = (childOffset.dx + maxMenuWidth) < size.width
        ? childOffset.dx
        : (childOffset.dx - maxMenuWidth + childSize.width);
    final topOffset =
        (childOffset.dy + menuHeight + childSize.height) < size.height
            ? childOffset.dy + childSize.height
            : childOffset.dy - menuHeight;
    final topContentOffset =
        (childOffset.dy + menuHeight + childSize.height) < size.height
            ? (topOffset + 10)
            : topOffset - 10;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                ),
              )),
          Positioned(
            top: topContentOffset, //-10 or +10 topOffset - 10
            left: leftOffset,
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 200),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  alignment: Alignment.center,
                  child: child,
                );
              },
              tween: Tween(begin: 0.0, end: 1.0),
              child: Container(
                width: maxMenuWidth,
                height: menuHeight,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10,
                          spreadRadius: 1)
                    ]),
                child: menuContent,
                // child: ClipRRect(
                //   borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                //   child: menuContent,
                // ),
              ),
            ),
          ),
          Positioned(
              top: childOffset.dy,
              left: childOffset.dx,
              child: AbsorbPointer(
                  absorbing: true,
                  child: SizedBox(
                      width: childSize.width,
                      height: childSize.height,
                      child: child2))),
        ],
      ),
    );
  }
}
