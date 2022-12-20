import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remote_data/remote_data.dart';

class Customer {
  String? id;
  String? email;
  String? name;
  String? scanCode;
  String? phone;
  String? photoUrls;
  Address? address;
  List<Orders>? order;
  List<Product>? wishlist;
  List<Review>? review;
  String? createdAt;
  String? deviceToken;

  Customer(
      {this.id,
      this.email,
      this.name,
      this.photoUrls,
      this.scanCode,
      this.phone,
      this.address,
      this.order,
      this.wishlist,
      this.review,
      this.createdAt,
      this.deviceToken});

  Customer copyWith({
    String? id,
    String? email,
    String? name,
    String? scanCode,
    String? phone,
    String? photoUrls,
    Address? address,
    List<Orders>? order,
    List<Product>? wishlist,
    List<Review>? review,
    String? createdAt,
    String? deviceToken,
  }) =>
      Customer(
          id: id ?? this.id,
          email: email ?? this.email,
          name: name ?? this.name,
          photoUrls: photoUrls ?? this.photoUrls,
          scanCode: scanCode ?? this.scanCode,
          phone: phone ?? this.phone,
          address: address ?? this.address,
          order: order ?? this.order,
          wishlist: wishlist ?? this.wishlist,
          review: review ?? this.review,
          createdAt: createdAt ?? this.createdAt,
          deviceToken: deviceToken ?? this.deviceToken);
//
  Customer.fromDocumentSnapshot(DocumentSnapshot snap) {
    Map<String, dynamic> json = snap.data() as Map<String, dynamic>;
    id = json['id'];
    email = json['email'];
    photoUrls = json['photoUrls'];
    name = json['name'];
    scanCode = json['scanCode'];
    phone = json['phone'];
    if (json['address'] != null) {
      address = Address.fromJson(json['address']);
    }
    if (json['order'] != null) {
      order = <Orders>[];
      json['order'].forEach((v) {
        order!.add(Orders.fromJson(v));
      });
    }
    if (json['wishlist'] != null) {
      wishlist = <Product>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(Product.fromJson(v));
      });
    }
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review!.add(Review.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    deviceToken = json['deviceToken'];
  }
//
  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    photoUrls = json['photoUrls'];
    name = json['name'];
    scanCode = json['scanCode'];
    phone = json['phone'];
    if (json['address'] != null) {
      address = Address.fromJson(json['address']);
    }
    if (json['order'] != null) {
      order = <Orders>[];
      json['order'].forEach((v) {
        order!.add(Orders.fromJson(v));
      });
    }
    if (json['wishlist'] != null) {
      wishlist = <Product>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(Product.fromJson(v));
      });
    }
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review!.add(Review.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    deviceToken = json['deviceToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['photoUrls'] = photoUrls;
    data['name'] = name;
    data['scanCode'] = scanCode;
    data['phone'] = phone;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (order != null) {
      data['order'] = order!.map((v) => v.toJson()).toList();
    }
    if (wishlist != null) {
      data['wishlist'] = wishlist!.map((v) => v.toJson()).toList();
    }
    if (review != null) {
      data['review'] = review!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['deviceToken'] = deviceToken;
    return data;
  }
}

class Review {
  String? productName;
  String? imageUrl;
  String? date;
  String? ratingValue;
  String? description;

  Review(
      {this.productName,
      this.imageUrl,
      this.date,
      this.ratingValue,
      this.description});

  Review.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    imageUrl = json['imageUrl'];
    date = json['date'];
    ratingValue = json['ratingValue'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productName'] = productName;
    data['imageUrl'] = imageUrl;
    data['date'] = date;
    data['ratingValue'] = ratingValue;
    data['description'] = description;
    return data;
  }
}

class Address {
  String? streetAddress;
  String? city;
  String? name;
  String? state;
  String? postalCode;
  String? uid;
  Address(
      {this.name,
      this.streetAddress,
      this.city,
      this.state,
      this.postalCode,
      this.uid});

  Address.fromJson(Map<String, dynamic> json) {
    streetAddress = json['streetAddress'];
    city = json['city'];
    name = json['name'];
    state = json['state'];
    uid = json['uid'];
    postalCode = json['postalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['streetAddress'] = streetAddress;
    data['city'] = city;
    data['name'] = name;
    data['state'] = state;
    data['uid'] = uid;
    data['postalCode'] = postalCode;
    return data;
  }
}

//

Customer demoCustomer = Customer(
  id: "",
  name: "",
  email: "",
  photoUrls: "https://i.stack.imgur.com/l60Hf.png",
  phone: "",
  scanCode: "",
  address: Address(
    uid: '',
    state: '',
    streetAddress: '',
    postalCode: '',
    city: '',
    name: '',
  ),
  order: [],
  review: [],
  deviceToken: "",
  createdAt: "",
  wishlist: [],
);
