import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

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

class GetOrdersData extends StatelessWidget {
  const GetOrdersData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qrCode = Provider.of<ScanPageProvider>(context).qrCode;

    return StreamBuilder<DocumentSnapshot>(
      stream: FireRepo.ordersDB.doc(qrCode).snapshots(),
      builder: (context, snap) {
        if (snap.hasError) {
          return const Center(child: HRDots());
        }

        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: HRDots());
        }
        // var d = snapshot.data!.docs;
        if (snap.hasData && snap.data!.data() != null) {
          Map<String, dynamic> data = snap.data!.data() as Map<String, dynamic>;

          Orders order = Orders.fromJson(data);
          return MyReview(order: order);
        }
        // TODO
        return const SizedBox();
        // Orders order = Orders();
        // return MyReview(order: order);
      },
    );
  }
}

class MyReview extends StatefulWidget {
  const MyReview({Key? key, required this.order}) : super(key: key);
  final Orders order;
  @override
  State<MyReview> createState() => _MyReviewState();
}

class _MyReviewState extends State<MyReview> {
  // int _index = 0;
  var txtcontroller = TextEditingController();
  double _value = 1.0;
  PageController controller = PageController();
  // late Customer customer;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        itemBuilder: (itemBuilder, index) {
          return body(index);
        },
        itemCount: widget.order.items!.length,
        // itemCount: 2,
      ),
    );
  }

  Widget body(int index) {
    return Center(
      child: SingleChildScrollView(
        // padding: EdgeInsets.symmetric(horizontal: 5.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text('${index + 1} of 2 items', style: TxtStyle.l3),
            Text('${index + 1} of ${widget.order.items!.length} items',
                style: TxtStyle.l3),
            SizedBox(height: 5.w),
            Text('How do you feel about our product?',
                textAlign: TextAlign.center, style: TxtStyle.h8),
            SizedBox(height: 5.w),
            //
            CachedNetworkImage(
              imageUrl: widget.order.items![index].image!,
              // imageUrl: 'https://i.stack.imgur.com/l60Hf.png',
              height: 20.h,
              placeholder: (context, url) => AppLoading.adCarousel,
              errorWidget: (context, url, error) => AppLoading.adCarousel,
            ),
            SizedBox(height: 5.w),
            Text('Awesome expression', style: TxtStyle.l5),
            SizedBox(height: 3.w),
            Image.asset(AppImage.star, height: 5.h),
            SizedBox(height: 5.w),
            Slider(
              min: 0.0,
              max: 4.0,
              value: _value,
              thumbColor: AppColor.yellow,
              activeColor: AppColor.yellow,
              inactiveColor: AppColor.yellow.withOpacity(0.2),
              divisions: 4,
              label: '${_value.round() + 1}',
              onChanged: (value) {
                setState(() => _value = value);
              },
            ),
            _TextInput(controller: txtcontroller),
            SizedBox(height: 5.w),
            MainButton(
              text: 'Continue',
              onTap: () async {
                controller.jumpToPage(index + 1);
                Review review = Review(
                  ratingValue: ((_value + 1)).toString(),
                  description: txtcontroller.text,
                  date: DateTime.now().toString(),
                  productName: widget.order.items![index].name,
                  // imageUrl: widget.order.items![index].name,
                );

                await FireRepo.addToRivewCustomerDB(review);
                ReviewRating rating = ReviewRating(
                  ratingValue: ((_value + 1) / 5).toString(),
                  description: txtcontroller.text,
                );
                await FireRepo.addToRivewProductDB(
                  rating,
                  widget.order.items![index].id!,
                  // 'c9d11fc0-8402-11ed-a0d6-b33d78beee63'
                );
                // TODO
              },
            )
          ],
        ),
      ),
    );
  }
}
