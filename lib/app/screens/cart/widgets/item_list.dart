import 'package:flutter/material.dart';
import 'package:isumi/core/util/image.dart';
import 'package:onyxsio/onyxsio.dart';

// class CartListView extends StatefulWidget {
//   const CartListView({Key? key}) : super(key: key);

//   @override
//   State<CartListView> createState() => _CartListViewState();
// }

// class _CartListViewState extends State<CartListView> {
//   bool isLoading = false;
//   List<Cart> carts = [];

//   String quantity = '0';
//   @override
//   void initState() {
//     refreshCartData();
//     super.initState();
//   }

//   Future refreshCartData() async {
//     setState(() => isLoading = true);
//     carts = await SQFLiteDB.readAllData();
//     setState(() => isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO loading indegater
//     return isLoading
//         ? const CircularProgressIndicator()
//         : carts.isEmpty
//             ? Center(
//                 child: Text(
//                   'Your Shopping Cart Is Empty.',
//                   style: TxtStyle.b8,
//                 ),
//               )
//             : _buildItemList();
//   }

//   Widget _buildItemList() {
//     return ListView.builder(
//       physics: const BouncingScrollPhysics(),
//       itemCount: carts.length,
//       padding: EdgeInsets.fromLTRB(5.w, 5.w, 5.w, 0),
//       itemBuilder: (context, index) {
//         return ItemListView(cart: carts[index], onDelete: refreshCartData);
//       },
//     );
//   }
// }

class ItemListView extends StatefulWidget {
  final Cart cart;
  final Function() onDelete;
  const ItemListView({Key? key, required this.onDelete, required this.cart})
      : super(key: key);

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  String stock = '';
  int quantity = 0;
  @override
  void initState() {
    getQuantity();
    super.initState();
  }

  Future<void> getQuantity() async {
    var result = await FirestoreRepository.setupQuantity(widget.cart);
    // if (mounted) return;
    setState(() {
      stock = result;
      quantity = int.parse(widget.cart.quantity);
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
          Text(widget.cart.name, style: TxtStyle.b6),
          if (stock.isNotEmpty)
            TXTHeader.cartListTileSubHeader('Only $stock items left'),
          TXTHeader.cartListTilePrice(widget.cart.price, widget.cart.currency),
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
                  await SQFLiteDB.delete(widget.cart.id!)
                      .then((value) => Navigator.of(context).pop(true));
                  widget.onDelete();
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
          onTap: () {
            if (int.parse(stock) > quantity) setState(() => quantity++);
            SQFLiteDB.updateQuantity(widget.cart.id!, quantity.toString());
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
            SQFLiteDB.updateQuantity(widget.cart.id!, quantity.toString());
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
      imageUrl: widget.cart.image,
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
