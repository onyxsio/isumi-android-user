import 'package:components/components.dart';
import 'package:flutter/material.dart';

//
class DropChild extends StatefulWidget {
  final Widget child;
  final String title;
  const DropChild({Key? key, required this.title, required this.child})
      : super(key: key);

  @override
  State<DropChild> createState() => _SelectDropListState();
}

class _SelectDropListState extends State<DropChild>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  bool isShow = false;

  @override
  void initState() {
    super.initState();
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                isShow = !isShow;
                _runExpandCheck();
                setState(() {});
              },
              child: Text(widget.title, style: TxtStyle.b5B),
            )),
            Icon(
              isShow
                  ? Icons.keyboard_arrow_down_rounded
                  : Icons.keyboard_arrow_right_rounded,
              color: AppColor.black3,
              // size: 5.w,
            )
          ],
        ),
        SizedBox(height: 5.w),
        SizeTransition(
            axisAlignment: 1.0, sizeFactor: animation, child: _buildSubMenu()),
//          Divider(color: Colors.grey.shade300, height: 1,)
      ],
    );
  }

//

  Widget _buildSubMenu() {
    return GestureDetector(
      child: widget.child,
      onTap: () {
        isShow = false;
        expandController.reverse();
      },
    );
  }
}
