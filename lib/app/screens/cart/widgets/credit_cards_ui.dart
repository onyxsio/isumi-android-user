// import 'package:flutter/material.dart';
// import 'package:onyxsio/onyxsio.dart';

// class CreditCardsPage extends StatelessWidget {
//   const CreditCardsPage({
//     Key? key,
//     required this.cardNumber,
//     required this.cardHolder,
//     required this.image,
//     required this.cardExpiration,
//   }) : super(key: key);
//   final String cardNumber;
//   final String cardHolder;
//   final String cardExpiration;
//   final String image;
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4.0,
//       color: const Color(0xFF212134),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Stack(
//         children: <Widget>[
//           Positioned(
//             left: -15.h,
//             top: -2.h,
//             child: CircleAvatar(
//               radius: 16.h,
//               backgroundColor: AppColor.white.withOpacity(0.04),
//             ),
//           ),
//           Positioned(
//             left: -8.h,
//             top: 3.h,
//             child: CircleAvatar(
//               radius: 10.h,
//               backgroundColor: AppColor.white.withOpacity(0.06),
//             ),
//           ),
//           Positioned(
//             right: -8.h,
//             bottom: -8.h,
//             child: CircleAvatar(
//               radius: 10.h,
//               backgroundColor: AppColor.white.withOpacity(0.06),
//             ),
//           ),
//           _buildCreditCard(),
//         ],
//       ),
//     );
//   }

//   // Build the credit card widget
//   Widget _buildCreditCard() {
//     return Container(
//       height: 27.h,
//       padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           _buildLogosBlock(),
//           Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: Text(
//               cardNumber,
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 21,
//                   fontFamily: 'CourrierPrime'),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               _buildDetailsBlock(
//                 label: 'CARDHOLDER',
//                 value: cardHolder,
//               ),
//               _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Build the top row containing logos
//   Row _buildLogosBlock() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         Image.asset("assets/images/contact_less.png", height: 20, width: 18),
//         SvgPicture.asset(image, height: 50, width: 50),
//       ],
//     );
//   }

// // Build Column containing the cardholder and expiration information
//   Column _buildDetailsBlock({required String label, required String value}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           label,
//           style: const TextStyle(
//               color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           value,
//           style: const TextStyle(
//               color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
//         )
//       ],
//     );
//   }
// }
