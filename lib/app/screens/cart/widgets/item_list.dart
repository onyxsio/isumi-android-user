import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class CartListView extends StatefulWidget {
  const CartListView({Key? key}) : super(key: key);

  @override
  State<CartListView> createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  bool isDismissed = false, isLoading = false;
  List<Cart> carts = [];
  @override
  void initState() {
    refreshCartData();
    super.initState();
  }

  Future refreshCartData() async {
    setState(() => isLoading = true);
    carts = await DBSetup.readAllCarts();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO loading indegater
    return isLoading
        ? const CircularProgressIndicator()
        : carts.isEmpty
            ? const Text(
                'No Items',
                style: TextStyle(color: Colors.black, fontSize: 24),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: carts.length,
                padding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 0),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      if (isDismissed) background(),
                      Dismissible(
                        onUpdate: (DismissUpdateDetails details) {},
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (DismissDirection direction) {
                          setState(() => isDismissed = true);
                          // setState(() {

                          // isBgColor = true;
                          // items.removeAt(index);
                          // });
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(SnackBar(content: Text(' dismissed')));
                        },
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Delete Confirmation"),
                                content: const Text(
                                    "Are you sure you want to delete this item?"),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text("Delete")),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("Cancel"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        background: background(),
                        child: Container(
                          height: 20.h,
                          padding: EdgeInsets.all(5.w),
                          margin: EdgeInsets.only(bottom: 5.w),
                          decoration: BoxDeco.deco_2,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image.asset(
                              //   AppImage.demoProduct,
                              //   height: 15.h,
                              // ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TXTHeader.cartListTileHeader(
                                        carts[index].name),
                                    TXTHeader.cartListTileSubHeader('category'),
                                    TXTHeader.cartListTilePrice(
                                        carts[index].price),
                                  ],
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // TODO
                                    },
                                    child: CircleAvatar(
                                      radius: 4.w,
                                      backgroundColor: const Color(0xFF3A4256),
                                      child: Icon(Icons.add,
                                          color: AppColor.white, size: 4.w),
                                    ),
                                  ),
                                  TXTHeader.cartListTileQty(
                                      carts[index].quantity),
                                  InkWell(
                                    onTap: () {
                                      // TODO
                                    },
                                    child: CircleAvatar(
                                      radius: 4.w,
                                      backgroundColor: const Color(0xFF3A4256),
                                      child: Icon(
                                        Icons.horizontal_rule_rounded,
                                        color: AppColor.white,
                                        size: 4.w,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
  }

  Container background() {
    return Container(
      height: 20.h,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 5.w),
      margin: EdgeInsets.only(bottom: 5.w),
      decoration: BoxDeco.deco_4,
      child: SvgPicture.asset(AppIcon.trash),
    );
  }
}
