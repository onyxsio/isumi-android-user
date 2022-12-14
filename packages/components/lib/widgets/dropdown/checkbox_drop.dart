import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

class CheckBoxDrop extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final TXT type;
  final String? hint;
  final Function(String)? onOptionSelected;
  const CheckBoxDrop(
      {Key? key,
      required this.type,
      required this.title,
      this.hint,
      this.onOptionSelected,
      required this.controller})
      : super(key: key);

  @override
  State<CheckBoxDrop> createState() => _CheckBoxDropState();
}

class _CheckBoxDropState extends State<CheckBoxDrop>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  bool isShow = false;
  String text = '';

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
      widget.controller.clear();
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
        SizedBox(height: 2.w),
        CheckBoxButton(
            onChanged: (p0) {
              isShow = p0!;
              _runExpandCheck();
              setState(() {});
            },
            text: widget.title,
            value: isShow),
        SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: TextBox(
              type: widget.type,
              hintText: widget.hint,
              controller: widget.controller,
            )),
      ],
    );
  }
}
