import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

import 'package:isumi/core/util/utils.dart';

class Selected {
  final int color;
  final int size;
  final String price;
  Selected({
    required this.color,
    required this.price,
    required this.size,
  });
}

class VeriantChoose extends StatefulWidget {
  const VeriantChoose({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  State<VeriantChoose> createState() => _VeriantChooseState();
}

class _VeriantChooseState extends State<VeriantChoose> {
  String price = '0.0', stock = '';
  int selectedColor = 0, selectedSize = 0;
  List<Variant> veriants = [];
  List minPrice = [];

  @override
  void initState() {
    loadingPrice();
    super.initState();
  }

  void loadingPrice() {
    setState(() {
      price = widget.product.price!.value!;
      veriants = widget.product.variant!;
      for (int i = 0; i < veriants.length; i++) {
        for (int j = 0; j < veriants[i].subvariant!.length; j++) {
          if (veriants[i].subvariant![j].price == price) {
            selectedColor = i;
            selectedSize = j;
            stock = veriants[i].subvariant![j].stock!;
          }
        }
      }
    });
  }

  List<Subvariant> convertToSize(Variant sub) {
    return sub.subvariant!;
  }

  @override
  Widget build(BuildContext context) {
    bool hasOffer = (widget.product.offers != null &&
        widget.product.offers!.percentage!.isNotEmpty);

    bool hasDiscount = (widget.product.price!.discount != null &&
        widget.product.price!.discount!.isNotEmpty);
    return WillPopScope(
      onWillPop: () async {
        // listener dismiss
        Selected selected = Selected(
          price: price,
          color: selectedColor,
          size: selectedSize,
        );
        Navigator.pop(context, selected);
        return true;
      },
      child: Container(
        // height: 30.h,
        margin: EdgeInsets.all(1.w),
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: AppColor.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              priceTag(hasOffer, hasDiscount),
              SizedBox(height: 5.w),
              Text('Select color', style: TxtStyle.b5B),
              SizedBox(height: 5.w),
              _buildColorGrid(),
              SizedBox(height: 5.w),
              Text('Quantities', style: TxtStyle.b5),
              SizedBox(height: 5.w),
              Text('Only $stock left in stock', style: TxtStyle.l5),
              SizedBox(height: 5.w),
              const Divider(),
              Text('Select size', style: TxtStyle.b5B),
              SizedBox(height: 5.w),
              _buildSizeGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget priceTag(hasOffer, hasDiscount) {
    return Row(
      children: [
        if (!hasOffer && !hasDiscount)
          Text(
              Utils.currency(
                  name: widget.product.price!.currency,
                  amount: double.parse(price)),
              style: TxtStyle.price),
        if (hasOffer)
          Row(
            children: [
              Text(
                  Utils.offerCal(
                    name: widget.product.price!.currency,
                    amount: price,
                    offer: widget.product.offers!.percentage,
                  ),
                  style: TxtStyle.price),
              Space.x5,
              Text(
                  Utils.currency(
                      name: widget.product.price!.currency,
                      amount: double.parse(price)),
                  style: TxtStyle.currency
                      .copyWith(decoration: TextDecoration.lineThrough)),
              Space.x3,
              Text('-${widget.product.offers!.percentage}%',
                  style: TxtStyle.settinSubTitle),
            ],
          ),
        if (hasDiscount)
          Row(
            children: [
              Text(
                  Utils.offerCal(
                    name: widget.product.price!.currency,
                    amount: price,
                    offer: widget.product.price!.discount,
                  ),
                  style: TxtStyle.price),
              Space.x5,
              Text(
                  Utils.currency(
                      name: widget.product.price!.currency,
                      amount: double.parse(price)),
                  style: TxtStyle.currency
                      .copyWith(decoration: TextDecoration.lineThrough)),
              Space.x3,
              Text('-${widget.product.price!.discount}%',
                  style: TxtStyle.settinSubTitle),
            ],
          ),
      ],
    );
  }

  //
  Widget _buildColorGrid() => GridView.extent(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      maxCrossAxisExtent: 40,
      mainAxisSpacing: 2.w,
      crossAxisSpacing: 2.w,
      children: _buildGridTileList());

  //
  List<Widget> _buildGridTileList() => List.generate(
      veriants.length,
      (i) => GestureDetector(
            onTap: () {
              setState(() {
                selectedColor = i;
                selectedSize = 0;
                price = convertToSize(veriants[i])[0].price!;
                stock = convertToSize(veriants[i])[0].stock!;
                context.read<CounterCubit>().reset();
              });
            },
            child: Container(
              height: 12.w,
              width: 12.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(int.parse(veriants[i].color!)),
                border: selectedColor == i
                    ? Border.all(color: AppColor.yellow, width: 4)
                    : null,
              ),
            ),
          ));

//
  Widget _buildSizeGrid() => GridView.extent(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      maxCrossAxisExtent: 46,
      mainAxisSpacing: 2.w,
      crossAxisSpacing: 2.w,
      children: _buildSizeGridTileList());

  List<GestureDetector> _buildSizeGridTileList() => List.generate(
      convertToSize(veriants[selectedColor]).length,
      (i) => GestureDetector(
            onTap: () {
              setState(() {
                price = convertToSize(veriants[selectedColor])[i].price!;
                selectedSize = i;
                stock = convertToSize(veriants[selectedColor])[i].stock!;
                context.read<CounterCubit>().reset();
              });
            },
            child: Container(
              height: 12.w,
              width: 13.w,
              decoration: BoxDeco.deco_2m(selectedSize == i),
              child: Center(
                  child: Text(
                convertToSize(veriants[selectedColor])[i].size!,
                style: TxtStyle.size(selectedSize == i),
              )),
            ),
          ));
}
