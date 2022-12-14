import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

class AdCarouselSlider extends StatelessWidget {
  const AdCarouselSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirestoreRepository.offerStream,
        builder: (builder, AsyncSnapshot<QuerySnapshot> snap) {
          if (snap.hasError) {
            return const SizedBox();
          }

          if (snap.connectionState == ConnectionState.waiting) {
            return _buildTopRowItem();
          }

          if (snap.data!.docs.isEmpty) {
            return const SizedBox();
          }
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5.w),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 18.h,
                aspectRatio: 16 / 5,
                viewportFraction: 0.9,
                initialPage: 1,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: snap.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                return GestureDetector(
                  onTap: () {
                    // TODO show items list
                    // showOfferDetails(data);
                  },
                  child: CachedNetworkImage(
                    imageUrl: data['banner'],
                    height: 35.w,
                    placeholder: (context, url) => _buildTopRowItem(),
                    imageBuilder: (context, imageProvider) => Container(
                      margin: EdgeInsets.symmetric(vertical: 2.w),
                      decoration: BoxDecoration(
                          color: AppColor.black,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          )),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                );
              }).toList(),
            ),
          );
        });
  }

  Widget _buildTopRowItem() {
    return Shimmer(
      linearGradient: AppColor.shimmerGradient,
      child: ShimmerLoading(
        isLoading: true,
        child: Container(
          height: 35.w,
          margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 5.w),
          decoration: BoxDecoration(
            color: AppColor.divider,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
