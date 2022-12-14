import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';

class ImageCarouselSlider extends StatefulWidget {
  final List imgList;
  const ImageCarouselSlider({Key? key, required this.imgList})
      : super(key: key);

  @override
  State<ImageCarouselSlider> createState() => _ImageCarouselSliderState();
}

class _ImageCarouselSliderState extends State<ImageCarouselSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.imgList.length,
          itemBuilder: (context, itemIndex, pageViewIndex) =>
              CachedNetworkImage(
            imageUrl: widget.imgList[pageViewIndex],
            // height: 35.w,
            placeholder: (context, url) => const SizedBox(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          carouselController: _controller,
          options: CarouselOptions(
            height: 35.h,
            // aspectRatio: 2,
            // viewportFraction: 0.5,
            // initialPage: 1,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() => _current = index);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: _current == entry.key ? 6.w : 2.w,
                height: 2.w,
                margin: EdgeInsets.symmetric(vertical: 3.w, horizontal: 1.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _current == entry.key
                        ? AppColor.yellow
                        : AppColor.menuUnselect.withOpacity(0.2)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
