import 'product.dart';

class NotificationData {
  String? id;
  List<Items>? items;
  String? customer;
  String? notificationType;
  List<Rivews>? review;
  // String? deviceToken;

  NotificationData({
    this.id,
    this.items,
    this.customer,
    this.notificationType,
    this.review,
    // this.deviceToken
  });

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    customer = json['customer'];
    notificationType = json['notificationType'];
    if (json['review'] != null) {
      review = <Rivews>[];
      json['review'].forEach((v) {
        review!.add(Rivews.fromJson(v));
      });
    }
    // deviceToken = json['deviceToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['customer'] = customer;
    data['notificationType'] = notificationType;
    if (review != null) {
      data['review'] = review!.map((v) => v.toJson()).toList();
    }
    // data['deviceToken'] = this.deviceToken;
    return data;
  }
}

class Items {
  String? productId;
  String? name;
  String? quantity;
  String? price;
  String? color;
  String? size;

  Items(
      {this.productId,
      this.name,
      this.quantity,
      this.price,
      this.color,
      this.size});

  Items.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    color = json['color'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    data['color'] = color;
    data['size'] = size;
    return data;
  }
}
