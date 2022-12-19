import 'dart:html';

import 'package:flutter/material.dart';
import 'package:onyxsio/onyxsio.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: TXTHeader.pageHeader('My orders'),
          actions: const [MenuButton()],
          bottom: TabBar(
            indicatorWeight: 3,
            indicatorColor: AppColor.yellow,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              TXTHeader.tabbarHeader('Delivered'),
              TXTHeader.tabbarHeader('Processing'),
              Tab(child: TXTHeader.tabbarHeader('Canceled')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                itemCount: 5,
                itemBuilder: (itemBuilder, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/OrderDetails');
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      margin: EdgeInsets.symmetric(vertical: 3.w),
                      decoration: BoxDeco.deco_2,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Order No: 238562312', style: TxtStyle.h5),
                              Text('20/03/2020', style: TxtStyle.h4),
                            ],
                          ),
                          const Divider(),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Quantity: ',
                                    style: TxtStyle.b1
                                        .copyWith(color: AppColor.lightBlack2),
                                  ),
                                  Text('5', style: TxtStyle.h7B),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Total Amount: ',
                                    style: TxtStyle.b1
                                        .copyWith(color: AppColor.lightBlack2),
                                  ),
                                  Text('\$550.0', style: TxtStyle.h7B),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                      Icons.check_circle_outline_rounded),
                                  const SizedBox(width: 10),
                                  Text('Delivered', style: TxtStyle.h5),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 2.w),
                                decoration: BoxDeco.deco_9,
                                child: Text('Details',
                                    style: TxtStyle.h5
                                        .copyWith(color: AppColor.white)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
            const Icon(Icons.directions_transit),
            const Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
