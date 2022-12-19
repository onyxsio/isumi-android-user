import 'package:flutter/material.dart';
import 'package:isumi/core/util/utils.dart';
import 'package:onyxsio/onyxsio.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
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
    var size = MediaQuery.of(context).size;
    var space = SizedBox(height: 4.w);
    bool hasOffer = (widget.product.offers != null &&
        widget.product.offers!.percentage!.isNotEmpty);

    bool hasDiscount = (widget.product.price!.discount != null &&
        widget.product.price!.discount!.isNotEmpty);

    //     .counterValue;
    return BlocBuilder<CounterCubit, CounterState>(
      builder: (context, state) {
        return Scaffold(
          appBar: secondaryAppBar(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildImageSilder(size),
                if (hasOffer)
                  Container(
                    height: 6.w,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 5.w),
                    color: AppColor.error,
                    width: double.infinity,
                    child: Text('super deal',
                        style: TxtStyle.b6B.copyWith(color: AppColor.white)),
                  ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
                  color: AppColor.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      priceTag(hasOffer, hasDiscount),
                      space,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(widget.product.title!,
                                  style: TxtStyle.b8B)),
                        ],
                      ),
                      space,
                      reviewAndRating(),
                      // space,
                      const Divider(),
                      space,
                      Text('Select color', style: TxtStyle.b5B),
                      space,
                      _buildColorGrid(),

                      space, const Divider(),
                      Text('Select size', style: TxtStyle.b5B),
                      space,
                      _buildSizeGrid(),
                      space,
                      Text('Only $stock items left', style: TxtStyle.b6),
                      space,
                    ],
                  ),
                ),
                space,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
                  color: AppColor.white,
                  child: DropChild(
                    title: 'Shipping details',
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Delivery Price: ', style: TxtStyle.b5B),
                            Text(widget.product.shipping!.deliveryPrice!,
                                style: TxtStyle.reviews),
                          ],
                        ),
                        SizedBox(height: 2.w),
                        Row(
                          children: [
                            Text(widget.product.shipping!.returnDays!,
                                style: TxtStyle.b5B),
                            Text(' days easy return ', style: TxtStyle.reviews),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                space,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
                  color: AppColor.white,
                  child: DropChild(
                    title: 'Specifications',
                    child: Text(widget.product.description!,
                        style: TxtStyle.reviews),
                  ),
                ),
                space,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
                  color: AppColor.white,
                  child: DropChild(
                      title: 'Ratings & Reciews',
                      child: widget.product.rivews!.reviewRating != null
                          ? ListView(
                              children: widget.product.rivews!.reviewRating!
                                  .map((e) => ListTile(
                                        title: Text(e.author!,
                                            style: TxtStyle.reviews),
                                        subtitle: Text(e.description!,
                                            style: TxtStyle.reviews),
                                      ))
                                  .toList())
                          : const SizedBox()),
                ),
                space,
              ],
            ),
          ),
          // bottomNavigationBar: _buildBottomNavigationBar(context),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
            decoration: BoxDeco.deco_2,
            child: Row(
              children: [
                CounterSlider(quantity: stock),
                SizedBox(width: 4.w),
                Expanded(
                    child: MainButton(
                        onTap: () {
                          createOrder(state.counterValue);
                        },
                        text: 'Add to cart'))
              ],
            ),
          ),
        );
      },
    );
  }

  void createOrder(qty) async {
    // Items order = Items(
    //   productId: widget.product.sId,
    //   name: widget.product.title,
    //   variants: [
    //     Variants(
    //       color: veriants[selectedColor].color!,
    //       subvariants: [
    //         Subvariants(
    //           size: convertToSize(veriants[selectedColor])[selectedSize].size!,
    //           price: price,
    //           qty: qty.toString(),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
    // Orders order = Orders(
    //   items:
    // );
    Items item = Items(
      productId: widget.product.sId!,
      sellerId: widget.product.sellerId,
      color: veriants[selectedColor].color!,
      name: widget.product.title!,
      price: price,
      image: widget.product.thumbnail!,
      quantity: qty.toString(),
      currency: widget.product.price!.currency!,
      size: convertToSize(veriants[selectedColor])[selectedSize].size!,
    );

    await FirestoreRepository.addToCart(item);
    // Cart cart = Cart(
    //   color: veriants[selectedColor].color!,
    //   pid: widget.product.sId!,
    //   name: widget.product.title!,
    //   size: convertToSize(veriants[selectedColor])[selectedSize].size!,
    //   price: price,
    //   image: widget.product.thumbnail!,
    //   createdTime: DateTime.now(),
    //   quantity: qty.toString(),
    //   currency: widget.product.price!.currency!,
    // );
    // await SQFLiteDB.create(cart).then((value) {
    //   if (value) {
    //     DBox.autoClose(context,
    //         type: InfoDialog.successful,
    //         message: 'The product has been added to your cart.');
    //   }
    // });
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
                stock = convertToSize(veriants[selectedColor])[i].stock!;
                context.read<CounterCubit>().reset();
                selectedSize = i;
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
//
  SizedBox _buildImageSilder(Size size) {
    return SizedBox(
      height: size.height * 0.4,
      width: size.width - 2,
      child: ImageCarouselSlider(imgList: widget.product.images!),
    );
  }

  // Container _buildBottomNavigationBar(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
  //     decoration: BoxDeco.deco_2,
  //     // color: AppColor.black,
  //     child: Row(
  //       children: [
  //         Expanded(
  //             child: ImageWithTextButton(
  //                 image: AppIcon.trash,
  //                 buttonGradient: AppColor.friewatchGradient,
  //                 onTap: () async {
  //                   await FirestoreRepository.deleteProduct(widget.product.sId!)
  //                       .then((value) => Navigator.pop(context));
  //                 },
  //                 text: 'Delete')),
  //         SizedBox(width: 4.w),
  //         Expanded(
  //             child: ImageWithTextButton(
  //                 image: AppIcon.edit,
  //                 buttonGradient: AppColor.frostGradient,
  //                 onTap: () {
  //                   Navigator.pushNamed(
  //                     context,
  //                     '/ProductUpdate',
  //                     arguments: widget.product,
  //                   );
  //                 },
  //                 text: 'Edit'))
  //       ],
  //     ),
  //   );
  // }

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
  Row reviewAndRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            StarRating(rating: widget.product.rivews!.ratingValue!),
            SizedBox(width: 2.w),
            Text(
              widget.product.rivews!.ratingValue!,
              style: TxtStyle.b5B,
            ),
          ],
        ),
        SizedBox(width: 2.w),
        Text(
          ' ( ${widget.product.rivews!.reviewCount} reviews)',
          style: TxtStyle.reviews,
        ),
      ],
    );
  }
}
