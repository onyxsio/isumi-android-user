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
  bool isLoading = false;
  List<Cart> carts = [];
  List stock = [''];
  String quantity = '0';
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

  String getQuantity(Cart cart) {
    return '';
    // TODO
    // return FirestoreRepository.setupQuantity(cart);
  }

  @override
  Widget build(BuildContext context) {
    // TODO loading indegater
    return isLoading
        ? const CircularProgressIndicator()
        : carts.isEmpty
            ? Center(
                child: Text(
                  'Your Shopping Cart Is Empty.',
                  style: TxtStyle.b8,
                ),
              )
            : _buildItemList();
  }

  Widget _buildItemList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: carts.length,
      padding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 0),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            background(),
            _buildItemCard(context, index),
          ],
        );
      },
    );
  }

  Dismissible _buildItemCard(BuildContext context, int index) {
    // getQuantity(carts[index]);
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection direction) async {
        return await await _buildDialog(context, index);
      },
      background: background(),
      child: Container(
        height: 20.h,
        padding: EdgeInsets.all(3.w),
        margin: EdgeInsets.only(bottom: 5.w),
        decoration: BoxDeco.deco_2,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardImage(index),
            SizedBox(width: 3.w),
            _buildItemCardText(index),
            SizedBox(width: 3.w),
            _buildItemCardQuantityButton(index),
          ],
        ),
      ),
    );
  }

  Column _buildItemCardQuantityButton(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            // TODO
          },
          child: CircleAvatar(
            radius: 4.w,
            backgroundColor: AppColor.lightBlack,
            child: Icon(Icons.add, color: AppColor.white, size: 4.w),
          ),
        ),
        Text(carts[index].quantity, style: TxtStyle.b8),
        InkWell(
          onTap: () {
            // TODO
          },
          child: CircleAvatar(
            radius: 4.w,
            backgroundColor: AppColor.lightBlack,
            child: Icon(
              Icons.horizontal_rule_rounded,
              color: AppColor.white,
              size: 4.w,
            ),
          ),
        ),
      ],
    );
  }

  Expanded _buildItemCardText(int index) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(carts[index].name, style: TxtStyle.b6),
          TXTHeader.cartListTileSubHeader(
              'Only ${getQuantity(carts[index])} items left'),
          // TODO curancry
          TXTHeader.cartListTilePrice(carts[index].price, 'JPY'),
        ],
      ),
    );
  }

  _buildDialog(BuildContext context, int index) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Confirmation"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  await DBSetup.delete(carts[index].id!)
                      .then((value) => Navigator.of(context).pop(true));
                  refreshCartData();
                },
                child: const Text("Delete")),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  CachedNetworkImage _buildCardImage(int index) {
    return CachedNetworkImage(
      imageUrl: carts[index].image,
      // height: 25.w,
      width: 15.w,
      placeholder: (context, url) => AppLoading.cartimage,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            color: AppColor.shimmerLight,
            borderRadius: BorderRadius.circular(2),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
      ),
      errorWidget: (context, url, error) => AppLoading.cartimage,
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
