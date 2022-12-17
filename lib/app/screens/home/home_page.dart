import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';
import 'widgets/ad_carousel_slider.dart';
import 'widgets/product_card.dart';
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
        topAppBar(),
        topTitle(),
        SliverPersistentHeader(delegate: SearchHeader(), pinned: true),
        const SliverToBoxAdapter(child: AdCarouselSlider()),
        //
        // SliverPersistentHeader(delegate: CategoryDelegate(), pinned: true),
        //
        mostPopularTitle(),

        SliverToBoxAdapter(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirestoreRepository.productLimitStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return AppLoading.productList;
              }

              List<Product> weightData =
                  snapshot.data!.docs.map((e) => Product.fromSnap(e)).toList();
              // return AppLoading.productList;
              if (weightData.isEmpty) {
                return AppLoading.productList;
              }
              return _buildProductList(weightData);
            },
          ),
        )
      ],
    );
  }

  GridView _buildProductList(List<Product> weightData) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5.h,
        crossAxisSpacing: 5.w,
        childAspectRatio: 0.75,
      ),
      itemCount: weightData.length,
      itemBuilder: (context, index) {
        var result = weightData[index];
        return GridProductCard(product: result);
      },
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
          Text('Deliver to Gram Bistro', style: TxtStyle.l5),
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
          Text('Most Popular', style: TxtStyle.h10),
          SizedBox(height: 2.w),
        ],
      ),
    ));
  }
}
