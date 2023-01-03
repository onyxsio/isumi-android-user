import 'package:flutter/material.dart';
import 'package:isumi/app/screens/home/featching.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart' as o;
// import 'search_page.dart';

class SearchHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: Colors.transparent,
      child: _SearchInput(),
    );
  }

  @override
  double get maxExtent => 55;

  @override
  double get minExtent => 54;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

// TextEditingController searchController = TextEditingController();

class _SearchInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // method to show the search bar
        o.mySearchDelegate(context: context, delegate: SearchScreen());
      },
      child: Container(
        // height: 64,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: o.BoxDeco.deco_2,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              o.SvgPicture.asset(AppIcon.search),
              SizedBox(width: 3.w),
              Expanded(
                child: Text('Search', style: o.TxtStyle.searchBox),
              ),
              // o.SvgPicture.asset(AppIcon.filter)
            ],
          ),
        ),
      ),
    );
  }
}

class SearchScreen extends o.SearchDelegate<String> {
// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    return FetchingItems(query: query);
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    return FetchingItems(query: query);
  }
}
