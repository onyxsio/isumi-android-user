import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onyxsio/onyxsio.dart';
import 'textbox_validate.dart';

class TextBox extends StatefulWidget {
  final TextEditingController controller;
  final TXT type;
  final String? hintText;
  final String? prefixText;
  const TextBox(
      {Key? key,
      this.hintText,
      this.prefixText,
      required this.controller,
      required this.type})
      : super(key: key);

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  //
  late Function(String?) validator;
  int? maxLines = 1;
  int? minLines = 1;
  TextInputType? keyboardType = TextInputType.number;

  final TextBoxValidate _textBloc = TextBoxValidate();
  List<TextInputFormatter>? inputFormatters;
  bool obscureText = false;
  //

  @override
  void initState() {
    super.initState();
    chooseType();
  }

  @override
  Widget build(BuildContext context) {
    final validation = Provider.of<Validation>(context);
    return StreamBuilder<String?>(
        stream: _textBloc.textStream,
        builder: (context, snapshot) {
          var hasError = snapshot.hasError;
          validation.validation(!hasError);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
                margin: EdgeInsets.only(bottom: hasError ? 2.w : 5.w, top: 3.w),
                decoration: BoxDeco.textbox(hasError),
                child: Center(
                  child: TextFormField(
                    maxLines: maxLines,
                    minLines: minLines,
                    onChanged: validator,
                    inputFormatters: inputFormatters,
                    keyboardType: keyboardType,
                    controller: widget.controller,
                    obscureText: obscureText,
                    // textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        prefix: widget.prefixText != null
                            ? Text(
                                '${widget.prefixText} ',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: AppColor.gray),
                              )
                            : null,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: widget.hintText),
                  ),
                ),
              ),
              if (hasError)
                Text(
                  snapshot.error.toString(),
                  style: TxtStyle.error,
                ),
              if (hasError) SizedBox(height: 3.w),
            ],
          );
        });
  }

  // @override
  // void dispose() {
  //   widget.controller.dispose();
  //   super.dispose();
  // }

  void chooseType() {
    switch (widget.type) {
      case TXT.text:
        validator = _textBloc.textvalue;
        maxLines = 5;
        keyboardType = TextInputType.multiline;
        break;
      case TXT.name:
        validator = _textBloc.name;
        maxLines = 5;
        keyboardType = TextInputType.multiline;
        break;

      case TXT.description:
        validator = _textBloc.description;
        keyboardType = TextInputType.multiline;
        maxLines = 10;
        minLines = 5;
        break;
      case TXT.email:
        keyboardType = TextInputType.emailAddress;
        validator = _textBloc.email;
        break;
      case TXT.phone:
        validator = _textBloc.phone;
        keyboardType = TextInputType.phone;
        inputFormatters = [FilteringTextInputFormatter.digitsOnly];
        break;
      case TXT.password:
        validator = _textBloc.password;
        obscureText = true;
        keyboardType = TextInputType.text;
        break;
      case TXT.address:
        validator = _textBloc.address;
        keyboardType = TextInputType.multiline;
        maxLines = 5;
        break;
      case TXT.price:
        validator = _textBloc.price;
        inputFormatters = [
          FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
        ];
        break;
      case TXT.quantity:
        validator = _textBloc.quantity;
        inputFormatters = [FilteringTextInputFormatter.digitsOnly];
        break;
      case TXT.deliveryPrice:
        validator = _textBloc.optionPrice;
        inputFormatters = [
          FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
        ];

        break;
      case TXT.discountPrice:
        validator = _textBloc.optionPrice;
        inputFormatters = [
          FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
        ];

        break;
      case TXT.returnDays:
        validator = _textBloc.days;
        inputFormatters = [FilteringTextInputFormatter.digitsOnly];
        break;
      default:
        validator = _textBloc.optionPrice;
        break;
    }
  }
}
