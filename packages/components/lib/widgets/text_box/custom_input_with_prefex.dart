import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onyxsio/onyxsio.dart';
import 'textbox_validate.dart';

class InputFieldWithPrefex extends StatefulWidget {
  final TextEditingController controller;
  final TXT type;
  final Function(String)? onOptionSelected;

  const InputFieldWithPrefex(
      {Key? key,
      required this.controller,
      required this.type,
      this.onOptionSelected})
      : super(key: key);

  @override
  State<InputFieldWithPrefex> createState() => _InputFieldWithPrefexState();
}

class _InputFieldWithPrefexState extends State<InputFieldWithPrefex>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;
  bool isShow = false;
  //
  late Function(String?) validator;
  int? maxLines = 1;
  int? minLines = 1;
  TextInputType? keyboardType = TextInputType.number;
  String? hintText;
  final TextBoxValidate _textBloc = TextBoxValidate();
  List<TextInputFormatter>? inputFormatters;
  String currencytxt = '';

  //

  @override
  void initState() {
    super.initState();
    chooseType();
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
                decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(
                      width: 1,
                      color: hasError ? AppColor.error : AppColor.inputBorder),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              isShow = !isShow;
                              _runExpandCheck();
                              setState(() {});
                            },
                            // child: Text(currencytxt, style: TextStyles.h3),
                          ),
                          Container(
                            width: 2,
                            height: 8.w,
                            margin: EdgeInsets.symmetric(horizontal: 3.w),
                            color: AppColor.inputBorder,
                          )
                        ],
                      ),
                      Expanded(
                        child: TextFormField(
                          maxLines: maxLines,
                          minLines: minLines,
                          // validator: validator,
                          onChanged: validator,
                          // onChanged: (String text) => _textBloc.updateText(text),
                          inputFormatters: inputFormatters,
                          keyboardType: keyboardType,
                          controller: widget.controller,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              hintText: hintText),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (hasError)
                Text(
                  snapshot.error.toString(),
                  // style: TextStyles.b2.copyWith(color: errorColor),
                ),
              if (hasError) SizedBox(height: 3.w),
              SizeTransition(
                  axisAlignment: 1.0,
                  sizeFactor: animation,
                  child: _buildDropListGrid()),
              if (isShow) SizedBox(height: 3.w),
            ],
          );
        });
  }

  Widget _buildDropListGrid() => GridView.extent(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      maxCrossAxisExtent: 60,
      mainAxisSpacing: 2.w,
      crossAxisSpacing: 2.w,
      children: _buildGridTileList());
  //
  List<GestureDetector> _buildGridTileList() => List.generate(
      5,
      (i) => GestureDetector(
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(width: 1, color: AppColor.inputBorder),
                borderRadius: BorderRadius.circular(16),
              ),
              // child: Center(child: Text(currency[i], style: TextStyles.h3B)),
            ),
            onTap: () {
              isShow = false;
              expandController.reverse();

              // setState(() => currencytxt = currency[i]);
              if (widget.onOptionSelected != null) {
                widget.onOptionSelected!(currencytxt);
              }
            },
          ));
//

  //
  void chooseType() {
    switch (widget.type) {
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
      // case TextBox.checkBox:
      //   validator = Validate.checkBox;
      //   break;
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
        hintText = 'Delivery price';
        break;
      case TXT.discountPrice:
        validator = _textBloc.optionPrice;
        inputFormatters = [
          FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
        ];
        hintText = 'Discount price';
        break;
      case TXT.returnDays:
        validator = _textBloc.days;
        hintText = 'How many days';
        inputFormatters = [FilteringTextInputFormatter.digitsOnly];
        break;
      default:
        validator = _textBloc.optionPrice;
        break;
    }
  }
}
