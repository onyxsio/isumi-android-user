import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';
import 'widgets/product_card.dart';

class FetchingItems extends StatefulWidget {
  const FetchingItems({Key? key, required this.query}) : super(key: key);
  final String query;

  @override
  State<FetchingItems> createState() => _FetchingItemsState();
}

class _FetchingItemsState extends State<FetchingItems> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreRepository.productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppLoading.productList;
        }

        List<Product> weightData =
            snapshot.data!.docs.map((e) => Product.fromSnap(e)).toList();
        List matchQuery = [];
        // if (query.isNotEmpty) {
        for (var doc in weightData) {
          if (doc.title!.toLowerCase().contains(widget.query.toLowerCase())) {
            matchQuery.add(doc);
          }
        }
        // }

        return _buildListview(matchQuery);
        // return AppLoading.productList;
      },
    );
  }

  Column _buildListview(List<dynamic> match) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: itemsFound(number: match.length)),
              Container(
                height: 10.w,
                width: 1,
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                color: AppColor.black.withOpacity(0.2),
              ),
              // o.ListOrGridButton(onTap: isListView)
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5.h,
              crossAxisSpacing: 4.w,
              childAspectRatio: 0.75,
            ),
            itemCount: match.length,
            itemBuilder: (context, index) {
              var result = match[index];
              return FocusedMenuHolder(
                  menuContent: menuContent(context, result),
                  child: GridProductCard(product: result));
            },
          ),
        ),
        SizedBox(height: 10.w),
      ],
    );
  }

  Padding menuContent(context, result) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                // FireStoreMethods.deleteProduct(result.id);
                // TODO
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    AppIcon.plus,
                    color: AppColor.black,
                    height: 8.w,
                  ),
                  SizedBox(width: 2.w),
                  Text('Add to wishlist', style: TxtStyle.itemUpdate),
                ],
              )),
          // SizedBox(height: 5.w),
          // GestureDetector(
          //     onTap: () {
          //       Navigator.pushNamed(context, '/ProductUpdate',
          //           arguments: result);
          //     },
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         o.SvgPicture.asset(AppIcon.edit, color: o.AppColor.error),
          //         Text('Update', style: o.TxtStyle.itemUpdate),
          //       ],
          //     )),
        ],
      ),
    );
  }
}
