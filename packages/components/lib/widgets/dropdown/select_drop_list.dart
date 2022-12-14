import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

//
class SelectDropList extends StatefulWidget {
  final Function(String valueItem) onOptionSelected;
  final List dropList;
  final String? title;
  final String? selectOption;
  const SelectDropList(this.onOptionSelected, this.dropList,
      {Key? key, this.title, this.selectOption})
      : super(key: key);

  @override
  State<SelectDropList> createState() => _SelectDropListState();
}

class _SelectDropListState extends State<SelectDropList>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  bool isShow = false;
  String text = 'please select an option below';

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
        if (widget.title != null) TXTHeader.header2(widget.title!),
        if (widget.title != null) SizedBox(height: 5.w),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
          // padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
          margin: widget.title != null ? null : EdgeInsets.only(top: 3.w),
          decoration: BoxDeco.itemSizeCard,
          child: Row(
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
                child:
                    Text(widget.selectOption ?? text, style: TxtStyle.header4),
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
        ),
        SizedBox(height: 5.w),
        SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: _buildDropListOptions()),
//          Divider(color: Colors.grey.shade300, height: 1,)
      ],
    );
  }

  Widget _buildDropListOptions() {
    return GridView.extent(
      maxCrossAxisExtent: 20.w,
      mainAxisSpacing: 1.w,
      crossAxisSpacing: 1.w,
      shrinkWrap: true,
      children: widget.dropList.map((item) => _buildSubMenu(item)).toList(),
    );
  }

//

  Widget _buildSubMenu(item) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(5.w),
        margin: EdgeInsets.only(bottom: 2.w),
        decoration: BoxDeco.itemSizeCard,
        child: Center(child: Text(item, style: TxtStyle.header4B)),
      ),
      onTap: () {
        isShow = false;
        expandController.reverse();
        widget.onOptionSelected(item);
        setState(() => text = item);
      },
    );
  }
}

//
//
//
class ProductSizeDropList extends StatefulWidget {
  final Function(String optionItem) onOptionSelected;
  final List sizeList;
  const ProductSizeDropList(this.onOptionSelected,
      {Key? key, required this.sizeList})
      : super(key: key);

  @override
  State<ProductSizeDropList> createState() => _ProductSizeDropListState();
}

class _ProductSizeDropListState extends State<ProductSizeDropList>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;
  var sizeList = [];
  bool isShow = false;
  String text = 'please select';

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

    getSizeList();
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  void getSizeList() {
    for (var element in widget.sizeList) {
      sizeList.add(element.text);
    }
    productSizesList.removeWhere((e) => sizeList.contains(e));
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
        TXTHeader.header2("Select a size"),
        SizedBox(height: 3.w),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
          decoration: BoxDeco.itemSizeCard,
          child: Row(
            mainAxisSize: MainAxisSize.max,
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
                child: Text(text, style: TxtStyle.header4),
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
        ),
        SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: _buildDropListOptions()),
//          Divider(color: Colors.grey.shade300, height: 1,)
      ],
    );
  }

  Widget _buildDropListOptions() => GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 5.w),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // maxCrossAxisExtent: 50.w,
          crossAxisCount: 3,
          mainAxisSpacing: 2.h,
          crossAxisSpacing: 4.w,
          childAspectRatio: 1.5,
        ),
        itemCount: productSizesList.length,
        itemBuilder: (context, index) {
          return _buildSubMenu(productSizesList[index]);
        },
      );

//

  Widget _buildSubMenu(String item) {
    return GestureDetector(
      child: Container(
        // padding: EdgeInsets.all(5.w),
        decoration: BoxDeco.itemSizeCard,
        child: Center(
            child: Text(item,
                style: TxtStyle.header4B, textAlign: TextAlign.start)),
      ),
      onTap: () {
        isShow = false;
        expandController.reverse();
        widget.onOptionSelected(item);
        setState(() => text = item);
        // productSizesList.addAll(this.productSizesList);
        getSizeList();
      },
    );
  }

  List<String> productSizesList = [
    "2XS",
    "XS",
    "S",
    "M",
    "L",
    "XL",
    "2XL",
    "3XL",
    "4XL",
    "5XL"
  ];
}


//

// // !
// class CurrencyDropList extends StatefulWidget {
//   final Function(String valueItem) onOptionSelected;

//   const CurrencyDropList(this.onOptionSelected, {Key? key}) : super(key: key);

//   @override
//   State<CurrencyDropList> createState() => _CurrencyDropListState();
// }

// class _CurrencyDropListState extends State<CurrencyDropList>
//     with SingleTickerProviderStateMixin {
//   late AnimationController expandController;
//   late Animation<double> animation;

//   bool isShow = false;
//   String text = '\$';

//   @override
//   void initState() {
//     super.initState();
//     expandController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 350));
//     animation = CurvedAnimation(
//       parent: expandController,
//       curve: Curves.fastOutSlowIn,
//     );
//     _runExpandCheck();
//   }

//   void _runExpandCheck() {
//     if (isShow) {
//       expandController.forward();
//     } else {
//       expandController.reverse();
//     }
//   }

//   @override
//   void dispose() {
//     expandController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
//           decoration: BoxDeco.itemSizeCard,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Expanded(
//                   child: GestureDetector(
//                 onTap: () {
//                   isShow = !isShow;
//                   _runExpandCheck();
//                   setState(() {});
//                 },
//                 child: Text(text, style: TextStyles.h3),
//               )),
//               Icon(
//                 isShow
//                     ? Icons.keyboard_arrow_down_rounded
//                     : Icons.keyboard_arrow_right_rounded,
//                 color: btnColor,
//                 // size: 5.w,
//               )
//             ],
//           ),
//         ),
//         SizeTransition(
//             axisAlignment: 1.0,
//             sizeFactor: animation,
//             child: _buildDropListOptions()),
// //          Divider(color: Colors.grey.shade300, height: 1,)
//       ],
//     );
//   }

  // Column _buildDropListOptions() {
  //   return Column(
  //     children: currency.map((item) => _buildSubMenu(item)).toList(),
  //   );
  // }

//

  // Widget _buildSubMenu(item) {
  //   return GestureDetector(
  //     child: Container(
  //       padding: EdgeInsets.all(5.w),
  //       margin: EdgeInsets.only(bottom: 2.w),
  //       decoration: BoxDeco.itemSizeCard,
  //       child: Center(child: Text(item, style: TextStyles.h3B)),
  //     ),
  //     onTap: () {
  //       isShow = false;
  //       expandController.reverse();
  //       widget.onOptionSelected(item);
  //       setState(() => text = item);
  //     },
  //   );
  // }
// }
