import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class ReviewTypePage extends StatefulWidget {
  const ReviewTypePage({Key? key}) : super(key: key);

  @override
  State<ReviewTypePage> createState() => _ReviewTypePageState();
}

class _ReviewTypePageState extends State<ReviewTypePage> {
  var controller = TextEditingController();
  double _value = 1.0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('How do you feel about our product?',
                textAlign: TextAlign.center, style: TxtStyle.h11B),
            SizedBox(height: 5.w),
            Image.asset(
              AppImage.star,
              height: 20.h,
            ),
            SizedBox(height: 5.w),
            Text(
              'Awesome expression',
              style: TxtStyle.l5,
            ),
            SizedBox(height: 5.w),
            Slider(
              min: 0.0,
              max: 4.0,
              value: _value,
              divisions: 4,
              label: '${_value.round() + 1}',
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
            ),
            _TextInput(controller: controller),
            SizedBox(height: 5.w),
            MainButton(
              text: 'Continue',
              onTap: () {
                // TODO
              },
            )
          ],
        ),
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  final TextEditingController controller;
  const _TextInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
      decoration: BoxDeco.deco_5,
      child: TextFormField(
        maxLines: null,
        maxLength: 1000,
        expands: true,
        keyboardType: TextInputType.multiline,
        controller: controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: 'Tell something about the product',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
