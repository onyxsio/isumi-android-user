import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

import 'scan_qr.dart';
import 'scan_text_feild.dart';

class ScanToReview extends StatefulWidget {
  const ScanToReview({Key? key}) : super(key: key);

  @override
  State<ScanToReview> createState() => _ScanToReviewState();
}

class _ScanToReviewState extends State<ScanToReview> {
  // PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ScanPageProvider>(context);
    return Scaffold(
      appBar: appBar(text: 'Scan to review'),
      body: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: child.length,
          controller: controller.controller,
          itemBuilder: (itemBuilder, index) {
            return child[index];
          }),
    );
  }
}

List<Widget> child = [
  const ScanQrPage(),
  const GetOrdersData(),
];
