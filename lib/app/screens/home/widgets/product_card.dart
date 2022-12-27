import 'package:flutter/material.dart';
import 'package:isumi/core/util/utils.dart';
import 'package:onyxsio/onyxsio.dart';

class GridProductCard extends StatelessWidget {
  final Product product;
  const GridProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/ProductDetails', arguments: product);
      },
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 5.w),
        decoration: BoxDeco.deco_3,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: product.thumbnail!,
                  height: 35.w,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const SizedBox(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                _buildPrice(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  // margin: EdgeInsets.only(bottom: 2.w),
                  child: Row(
                    children: [
                      if (product.stock != null)
                        Row(
                          children: [
                            Text(product.stock!, style: TxtStyle.b2),
                            Text(' sold', style: TxtStyle.b3B),
                            Space.x3,
                          ],
                        ),
                      if (product.rivews != null &&
                          double.parse(product.rivews!.ratingValue!) > 0)
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColor.yellow,
                              size: 4.w,
                            ),
                            Space.x1,
                            Text(
                              product.rivews!.ratingValue!,
                              style: TxtStyle.topMenuButton,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w)
                      .copyWith(bottom: 2.w),
                  child: Text(
                    product.title!,
                    maxLines: 1,
                    // textAlign: TextAlign.center,
                    style: TxtStyle.itemCardHeading,
                  ),
                ),
              ],
            ),
            if (product.offers != null &&
                product.offers!.percentage!.isNotEmpty)
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                    height: 20,
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                      color: AppColor.error,
                      // borderRadius:
                      //     BorderRadius.only(topLeft: Radius.circular(5)),
                    ),
                    child: Center(
                      child: Text(
                        '-${product.offers!.percentage!} %',
                        style: TxtStyle.topMenuButton
                            .copyWith(color: AppColor.white),
                      ),
                    )),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrice() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: RichText(
          text: TextSpan(
        children: [
          TextSpan(
              text: Utils.formatCurrencySymble(name: product.price!.currency),
              style: TxtStyle.itemCardcurrency),
          const TextSpan(text: ' '),
          TextSpan(
              text: Utils.formatCurrency(
                  name: product.price!.currency,
                  amount: double.parse(product.price!.value!)),
              style: TxtStyle.itemCardPrice),
        ],
      )),
    );
  }
}
