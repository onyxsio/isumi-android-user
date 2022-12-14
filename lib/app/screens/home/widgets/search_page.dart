import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';
import 'custom_search.dart' as my;

class SearchScreen extends my.SearchDelegate<String> {
  // Demo list to show querying
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    // TODO
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text('${matchQuery.length} Items found',
                      style: TxtStyle.h3)),
              Container(
                height: 10.w,
                width: 1,
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                color: AppColor.black.withOpacity(0.2),
              ),
              InkWell(
                onTap: () {
                  // setState(() => isList = !isList);
                },
                // child: ListOrGridButton(isList: true),
                child: Text('datafdf'),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return ListTile(
                title: Text(result),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget buildFilter(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        // margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text('Filters'),
          ],
        ),
      ),
    );
  }
}
