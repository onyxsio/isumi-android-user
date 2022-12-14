import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

import 'widgets/ad_carousel_slider.dart';
import 'widgets/search_header_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  PageController controller = PageController();
  int select = 0;
  @override
  Widget build(BuildContext context) {
    // final user = context.select((AppBloc bloc) => bloc.state.user);
    final drawerProvider = Provider.of<DrawerProvider>(context);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        //
        topAppBar(),
        //
        topTitle(),
        //
        SliverPersistentHeader(delegate: SearchHeader(), pinned: true),
        //
        // TODO: if this availbale to offers is availabale
        SliverToBoxAdapter(
          child: Column(
            children: const [
              SizedBox(height: 20),
              AdCarouselSlider(),
              SizedBox(height: 20),
            ],
          ),
        ),
        //
        // SliverPersistentHeader(delegate: CategoryDelegate(), pinned: true),
        //
        mostPopularTitle(),
        //
        _buildProductList()
      ],
    );
  }

  // Product List view
  SliverPadding _buildProductList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 50.w,
          mainAxisSpacing: 2.h,
          crossAxisSpacing: 4.w,
          childAspectRatio: 0.8,
        ),
        delegate: SliverChildBuilderDelegate((context, index) => Text('data'),
            // (context, index) => ProductCard(product: demoCart[index]),
            childCount: 5),
      ),
    );
  }

  // Top App Bar
  SliverAppBar topAppBar() {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        children: [
          SvgPicture.asset(AppIcon.location),
          Text('Deliver to Gram Bistro', style: TxtStyle.l3),
        ],
      ),
      actions: const [MenuButton()],
      floating: true,
    );
  }

  // Top Title
  SliverToBoxAdapter topTitle() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 6.w, bottom: 5.w),
        child: Text('Find the latest trend for you', style: TxtStyle.h10),
      ),
    );
  }

  // Title for  Most Popular
  SliverToBoxAdapter mostPopularTitle() {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.w),
          Text('Most Popular', style: TxtStyle.h12),
          SizedBox(height: 2.w),
        ],
      ),
    ));
  }
}
