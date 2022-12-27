import 'package:flutter/material.dart';
import 'package:isumi/app/screens/home/widgets/product_card.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'Wishlist'),
      body: const GetWishList(),
    );
  }
}

class GetWishList extends StatelessWidget {
  const GetWishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return StreamBuilder<QuerySnapshot>(
      stream:
          FireRepo.customerDB.doc(user.id).collection('wishlist').snapshots(),
      builder: (builder, snap) {
        if (snap.hasError) {
          return const Center(child: HRDots());
        }

        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: HRDots());
        }
        // Map<String, dynamic> data = snap.data!.data() as Map<String, dynamic>;
        // Customer customer = Customer.fromJson(data);
        List<DocumentSnapshot> document = snap.data!.docs;
        return WishLists(products: document);
      },
    );
  }
}

class WishLists extends StatelessWidget {
  const WishLists({Key? key, required this.products}) : super(key: key);
  final List<DocumentSnapshot> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${products.length} Items found on the wishlist',
                  style: TxtStyle.h3),
              // InkWell(
              //     onTap: () {
              //       setState(() => isList = !isList);
              //     },
              //     child: ListOrGridButton(onTap: (p0) {}))
            ],
          ),
          SizedBox(height: 6.w),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // maxCrossAxisExtent: 50.w,
                crossAxisCount: 2,
                mainAxisSpacing: 2.h,
                crossAxisSpacing: 4.w,
                childAspectRatio: 0.8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = Product.fromSnap(products[index]);
                return FocusedMenuHolder(
                    menuContent: menuContent(product),
                    child: GridProductCard(product: product));
              },
            ),
          )
        ],
      ),
    );
  }

  Padding menuContent(product) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: GestureDetector(
          onTap: () async {
            // TODO
            await FireRepo.removeWishList(product);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(AppIcon.trash, color: AppColor.error),
              Text('Delete', style: TxtStyle.b5B),
            ],
          )),
    );
  }
}
