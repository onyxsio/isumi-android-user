import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remote_data/src/model/customer.dart';

class Orders {
  String? oId;
  String? date;
  String? sellerId;
  String? currency;
  List<Items>? items;
  String? total;
  String? paymetStatus;
  String? discountedPrice;
  String? delivery;
  Customer? customer;
  TimeLine? timeLine;
  Orders({
    this.items,
    this.total,
    this.sellerId,
    this.oId,
    this.date,
    this.currency,
    this.delivery,
    this.paymetStatus,
    this.discountedPrice,
    this.customer,
    this.timeLine,
  });
  //
  Orders copyWith({
    String? oId,
    String? date,
    String? sellerId,
    String? currency,
    List<Items>? items,
    String? total,
    String? paymetStatus,
    String? discountedPrice,
    String? delivery,
    Customer? customer,
    TimeLine? timeLine,
  }) =>
      Orders(
        items: items ?? this.items,
        total: total ?? this.total,
        sellerId: sellerId ?? this.sellerId,
        oId: oId ?? this.oId,
        date: date ?? this.date,
        currency: currency ?? this.currency,
        delivery: delivery ?? this.delivery,
        paymetStatus: paymetStatus ?? this.paymetStatus,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        customer: customer ?? this.customer,
        timeLine: timeLine ?? this.timeLine,
      );
//
  Orders.fromFirebaseJson(DocumentSnapshot snap) {
    Map<String, dynamic> json = snap.data() as Map<String, dynamic>;
    oId = json['_id'];
    date = json['date'];
    sellerId = json['sellerId'];
    currency = json['currency'];
    delivery = json['delivery'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    total = json['total'];
    paymetStatus = json['paymetStatus'];
    discountedPrice = json['discountedPrice'];
    timeLine =
        json['TimeLine'] != null ? TimeLine.fromJson(json['TimeLine']) : null;
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }
//
  Orders.fromJson(Map<String, dynamic> json) {
    oId = json['_id'];
    date = json['date'];
    currency = json['currency'];
    sellerId = json['sellerId'];
    delivery = json['delivery'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    total = json['total'];
    paymetStatus = json['paymetStatus'];
    discountedPrice = json['discountedPrice'];
    timeLine =
        json['TimeLine'] != null ? TimeLine.fromJson(json['TimeLine']) : null;
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = oId;
    data['sellerId'] = sellerId;
    data['currency'] = currency;
    data['date'] = date;
    data['delivery'] = delivery;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['paymetStatus'] = paymetStatus;
    data['discountedPrice'] = discountedPrice;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (timeLine != null) {
      data['TimeLine'] = timeLine!.toJson();
    }
    return data;
  }
}

// !
class TimeLine {
  String? confirmed;
  String? inprocess;
  String? processed;
  String? shipped;
  String? delivered;

  TimeLine(
      {this.confirmed,
      this.inprocess,
      this.processed,
      this.shipped,
      this.delivered});
  TimeLine copyWith({
    String? confirmed,
    String? inprocess,
    String? processed,
    String? shipped,
    String? delivered,
  }) =>
      TimeLine(
        confirmed: confirmed ?? this.confirmed,
        inprocess: inprocess ?? this.inprocess,
        processed: processed ?? this.processed,
        shipped: shipped ?? this.shipped,
        delivered: delivered ?? this.delivered,
      );
  TimeLine.fromJson(Map<String, dynamic> json) {
    confirmed = json['Confirmed'];
    inprocess = json['Inprocess'];
    processed = json['Processed'];
    shipped = json['Shipped'];
    delivered = json['Delivered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Confirmed'] = confirmed;
    data['Inprocess'] = inprocess;
    data['Processed'] = processed;
    data['Shipped'] = shipped;
    data['Delivered'] = delivered;
    return data;
  }
}

// ! Items
class Items {
  String? id;
  String? productId;
  String? sellerId;
  String? name;
  String? color;
  String? size;
  String? quantity;
  String? image;
  String? price;
  String? currency;
  // List<Variants>? variants;

  Items({
    this.sellerId,
    this.id,
    this.productId,
    this.name,
    this.image,
    this.price,
    this.color,
    this.quantity,
    this.size,
    this.currency,
  });
  Items copyWith({
    String? productId,
    String? sellerId,
    String? id,
    String? name,
    String? color,
    String? size,
    String? quantity,
    String? image,
    String? price,
    String? currency,
  }) =>
      Items(
        productId: productId ?? this.productId,
        id: id ?? this.id,
        sellerId: sellerId ?? this.sellerId,
        name: name ?? this.name,
        color: color ?? this.color,
        size: size ?? this.size,
        quantity: quantity ?? this.quantity,
        image: image ?? this.image,
        price: price ?? this.price,
        currency: currency ?? this.currency,
      );

  Items.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    sellerId = json['sellerId'];
    id = json['id'];
    currency = json['currency'];
    name = json['name'];
    color = json['color'];
    size = json['size'];
    quantity = json['quantity'];
    image = json['image'];
    price = json['price'];
    // if (json['variants'] != null) {
    //   variants = <Variants>[];
    //   json['variants'].forEach((v) {
    //     variants!.add(Variants.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['id'] = id;
    data['sellerId'] = sellerId;
    data['currency'] = currency;
    data['name'] = name;
    data['color'] = color;
    data['size'] = size;
    data['quantity'] = quantity;
    data['price'] = price;
    data['image'] = image;
    // if (variants != null) {
    //   data['variants'] = variants!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

// class Variants {
//   String? color;
//   List<Subvariants>? subvariants;

//   Variants({this.color, this.subvariants});

//   Variants.fromJson(Map<String, dynamic> json) {
//     color = json['color'];
//     if (json['subvariants'] != null) {
//       subvariants = <Subvariants>[];
//       json['subvariants'].forEach((v) {
//         subvariants!.add(Subvariants.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['color'] = color;
//     if (subvariants != null) {
//       data['subvariants'] = subvariants!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Subvariants {
//   String? size;
//   String? qty;
//   String? price;

//   Subvariants({this.size, this.qty, this.price});

//   Subvariants.fromJson(Map<String, dynamic> json) {
//     size = json['size'];
//     qty = json['qty'];
//     price = json['price'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['size'] = size;
//     data['qty'] = qty;
//     data['price'] = price;
//     return data;
//   }
// }

// Orders demoOrder = Orders(
//   sId: '12',
//   paymetStatus: 'done',
//   date: '2022/02/5',
//   total: '5000',
//   discountedPrice: '522',
//   delivery: '200',
//   currency: 'LKR',
//   items: [
//     Items(
//       name: 'kota gawma',
//       productId: '13454689dsa7d',
//       variants: [
//         Variants(
//           color: '4286319678',
//           subvariants: [
//             Subvariants(
//               size: 'xs',
//               price: '5656',
//               qty: '5',
//             ),
//             Subvariants(
//               size: 'M',
//               price: '2346',
//               qty: '6',
//             ),
//             Subvariants(
//               size: 'S',
//               price: '006',
//               qty: '2',
//             ),
//           ],
//         ),
//       ],
//     ),
//     Items(name: 'kota gawma ahdkadas', productId: '13454689dsa7d', variants: [
//       Variants(
//         color: '4292054086',
//         subvariants: [
//           Subvariants(
//             size: 's',
//             price: '565',
//             qty: '52',
//           ),
//           Subvariants(
//             size: 'xs',
//             price: '956',
//             qty: '5',
//           ),
//         ],
//       ),
//       Variants(
//         color: '4286319678',
//         subvariants: [
//           Subvariants(
//             size: 'xs',
//             price: '5656',
//             qty: '5',
//           ),
//           Subvariants(
//             size: 'M',
//             price: '2346',
//             qty: '6',
//           ),
//           Subvariants(
//             size: 'S',
//             price: '006',
//             qty: '2',
//           ),
//         ],
//       ),
//     ]),
//   ],
//   customer: Customer(
//     name: 'sudesh bandara',
//     phoneNumber: '075 000 0000',
//     email: 'sudesh@gmail.com',
//     address: Address(
//       postalCode: '22032',
//       state: 'central',
//       city: 'Hatton',
//       streetAddress: 'No 88,Kalaweldeniya road,',
//     ),
//   ),
// );
