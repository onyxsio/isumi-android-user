// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:onyxsio/core/responsive/size.dart';
// import 'package:onyxsio/core/theme/colors.dart';
// import 'package:onyxsio/core/utils/utils.dart';

// class ShearchCountry extends StatefulWidget {
//   const ShearchCountry({Key? key, required this.onTap}) : super(key: key);
//   final Function(String code, String name) onTap;
//   @override
//   State<ShearchCountry> createState() => _ShearchCountryState();
// }

// class _ShearchCountryState extends State<ShearchCountry> {
//   final _searchController = TextEditingController();
//   List<dynamic>? dataRetrieved; // data decoded from the json file
//   List<dynamic>? data; // data to display on the screen

//   var searchValue = "";
//   @override
//   void initState() {
//     super.initState();
//     _getData();
//   }

//   Future _getData() async {
//     final String response = await rootBundle.loadString(AppJson.country);
//     dataRetrieved = await json.decode(response) as List<dynamic>;
//     setState(() {
//       data = dataRetrieved;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(2.w),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               SvgPicture.asset(AppIcon.search),
//               const SizedBox(width: 5),
//               Expanded(
//                 child: TextField(
//                   controller: _searchController,
//                   onChanged: (value) {
//                     setState(() => searchValue = value);
//                   },
//                   decoration: const InputDecoration(
//                     hintText: 'Search Country',
//                     border: InputBorder.none,
//                     fillColor: whiteColor,
//                     filled: true,
//                     contentPadding: EdgeInsets.all(8),
//                   ),
//                   keyboardType: TextInputType.name,
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//               child: ListView(
//             physics: const BouncingScrollPhysics(),
//             children: data != null
//                 ? data!
//                     .where((e) => e['name']
//                         .toString()
//                         .toLowerCase()
//                         .contains(searchValue.toLowerCase()))
//                     .map((e) => ListTile(
//                           onTap: () {
//                             widget.onTap(e['dial_code'], e['emoji']);
//                             Navigator.pop(context);
//                           },
//                           leading: e['emoji'] != null ? Text(e['emoji']) : null,
//                           title: Text(e['name']),
//                           trailing: Text(e['dial_code']),
//                         ))
//                     .toList()
//                 : [
//                     const Center(child: Text("Loading")),
//                   ],
//           )),
//         ],
//       ),
//     );
//   }
// }
