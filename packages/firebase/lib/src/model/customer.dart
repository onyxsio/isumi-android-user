import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remote_data/src/model/product.dart';
import 'package:uuid/uuid.dart';

class Customer {
  String? id;
  String? email;
  String? name;
  String? scanCode;
  String? phone;
  String? photoUrls;
  List<Address>? address;
  List<Product>? cart;
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
      this.cart,
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
    List<Address>? address,
    List<Product>? cart,
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
          cart: cart ?? this.cart,
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
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(Address.fromJson(v));
      });
    }
    if (json['cart'] != null) {
      cart = <Product>[];
      json['cart'].forEach((v) {
        cart!.add(Product.fromJson(v));
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
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(Address.fromJson(v));
      });
    }
    if (json['cart'] != null) {
      cart = <Product>[];
      json['cart'].forEach((v) {
        cart!.add(Product.fromJson(v));
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
      data['address'] = address!.map((v) => v.toJson()).toList();
    }
    if (cart != null) {
      data['cart'] = cart!.map((v) => v.toJson()).toList();
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
  String? state;
  String? postalCode;

  Address({this.streetAddress, this.city, this.state, this.postalCode});

  Address.fromJson(Map<String, dynamic> json) {
    streetAddress = json['streetAddress'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['streetAddress'] = streetAddress;
    data['city'] = city;
    data['state'] = state;
    data['postalCode'] = postalCode;
    return data;
  }
}

//

Customer demoCustomer = Customer(
  id: "",
  name: "",
  email: "",
  photoUrls: "",
  phone: "",
  scanCode: "",
  address: [],
  cart: [],
  review: [],
  deviceToken: "",
  createdAt: "",
  wishlist: [],
);
