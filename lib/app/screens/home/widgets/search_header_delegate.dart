import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart' as o;

import 'custom_search.dart';
import 'search_page.dart';

class SearchHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    return Material(
      color: theme.backgroundColor,
      child: _SearchInput(),
    );
  }

  @override
  double get maxExtent => 65;

  @override
  double get minExtent => 64;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

// TextEditingController searchController = TextEditingController();

class _SearchInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        // method to show the search bar
        mySearchDelegate(
            context: context,
            // delegate to customize the search bar
            delegate: SearchScreen());
      },
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
        decoration: o.BoxDeco.deco_3,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              o.SvgPicture.asset(AppIcon.search),
              const SizedBox(width: 5),
              Expanded(
                child: Text('Search', style: o.TxtStyle.l3),
              ),
              // o.SvgPicture.asset(AppIcon.filter)
            ],
          ),
        ),
      ),
    );
  }
}
