import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

class ItemListView extends StatefulWidget {
  final DocumentSnapshot cart;

  const ItemListView({Key? key, required this.cart}) : super(key: key);

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  String stock = '';
  int quantity = 0;
  late Items item;
  @override
  void initState() {
    getQuantity();
    super.initState();
  }

  Future<void> getQuantity() async {
    Map<String, dynamic> data = widget.cart.data()! as Map<String, dynamic>;
    item = Items.fromJson(data);
    var result = await FireRepo.setupQuantity(item);
    // if (mounted) return;
    setState(() {
      stock = result;
      quantity = int.parse(item.quantity!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        background(),
        _buildItemCard(),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Expanded _buildItemCardText() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(item.name!, style: TxtStyle.b6),
          if (stock.isNotEmpty)
            // TODO maxLine:1,
            TXTHeader.cartListTileSubHeader('Only $stock items left'),
          TXTHeader.cartListTilePrice(item.price!, item.currency!),
        ],
      ),
    );
  }

  _buildDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Confirmation"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  FireRepo.removeCart(item.id!)
                      .then((value) => Navigator.of(context).pop(true));
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

  Dismissible _buildItemCard() {
    // getQuantity(carts[index]);
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection direction) async {
        return await await _buildDialog(context);
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
            _buildCardImage(),
            SizedBox(width: 3.w),
            _buildItemCardText(),
            SizedBox(width: 3.w),
            _buildItemCardQuantityButton(),
          ],
        ),
      ),
    );
  }

  Column _buildItemCardQuantityButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () async {
            if (int.parse(stock) > quantity) setState(() => quantity++);
            FireRepo.quantityUpdate(quantity.toString(), item.id!);
          },
          child: CircleAvatar(
            radius: 4.w,
            backgroundColor: AppColor.lightBlack,
            child: Icon(Icons.add, color: AppColor.white, size: 4.w),
          ),
        ),
        Text(quantity.toString(), style: TxtStyle.b8),
        InkWell(
          onTap: () {
            if (1 < quantity) setState(() => quantity--);
            FireRepo.quantityUpdate(quantity.toString(), item.id!);
            // SQFLiteDB.updateQuantity(widget.cart.id!, quantity.toString());
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

  CachedNetworkImage _buildCardImage() {
    return CachedNetworkImage(
      imageUrl: item.image!,
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
}
