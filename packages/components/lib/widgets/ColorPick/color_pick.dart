library hsv_picker;

import 'package:components/config/size.dart';
import 'package:flutter/material.dart';
import 'palette.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);
  List<Color> colorHistory = [];

  @override
  void initState() {
    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
    super.initState();
  }

  @override
  void didUpdateWidget(ColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    currentHsvColor = HSVColor.fromColor(widget.pickerColor);
  }

  Widget colorPickerSlider() {
    return ColorPickerSlider(
      currentHsvColor,
      (HSVColor color) {
        setState(() => currentHsvColor = color);
        widget.onColorChanged(currentHsvColor.toColor());
      },
    );
  }

  void onColorChanging(HSVColor color) {
    setState(() => currentHsvColor = color);
    widget.onColorChanged(currentHsvColor.toColor());
  }

  Widget colorPicker() {
    return ColorPickerArea(currentHsvColor, onColorChanging);
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 100.w,
            height: 30.h,
            child: colorPicker(),
          ),
          SizedBox(height: 10.h, width: 100.w, child: colorPickerSlider()),
          ColorIndicator(currentHsvColor),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          SizedBox(width: 100.w, height: 30.h, child: colorPicker()),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const SizedBox(width: 20.0),
                  ColorIndicator(currentHsvColor),
                  SizedBox(
                      height: 40.0, width: 260.0, child: colorPickerSlider()),
                  const SizedBox(width: 10.0),
                ],
              ),
            ],
          ),
        ],
      );
    }
  }
}
