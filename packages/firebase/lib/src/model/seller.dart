import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remote_data/src/model/models.dart';

class Seller {
  String? sId;
  String? deviceToken;
  List<Product>? outOfStock;
  List<Product>? sold;
  List<Product>? unsold;
  List<Product>? almostFinished;
  List<Product>? mostSell;
  List<Product>? todayOrders;
  String? todayIncome;
  String? totalUsers;

  String? email;
  String? name;
  String? phone;
  String? photoUrls;
  Address? address;

  Seller({
    this.sId,
    this.deviceToken,
    this.outOfStock,
    this.sold,
    this.unsold,
    this.almostFinished,
    this.mostSell,
    this.todayOrders,
    this.todayIncome,
    this.totalUsers,
    this.address,
    this.email,
    this.name,
    this.phone,
    this.photoUrls,
  });
  //
  Seller copyWith({
    String? email,
    String? name,
    String? phone,
    String? photoUrls,
    Address? address,
    String? sId,
    String? deviceToken,
    List<Product>? outOfStock,
    List<Product>? sold,
    List<Product>? unsold,
    List<Product>? almostFinished,
    List<Product>? mostSell,
    List<Product>? todayOrders,
    String? todayIncome,
    String? totalUsers,
  }) =>
      Seller(
          sId: sId ?? this.sId,
          email: email ?? this.email,
          name: name ?? this.name,
          photoUrls: photoUrls ?? this.photoUrls,
          outOfStock: outOfStock ?? this.outOfStock,
          phone: phone ?? this.phone,
          address: address ?? this.address,
          sold: sold ?? this.sold,
          unsold: unsold ?? this.unsold,
          almostFinished: almostFinished ?? this.almostFinished,
          mostSell: mostSell ?? this.mostSell,
          todayOrders: todayOrders ?? this.todayOrders,
          todayIncome: todayIncome ?? this.todayIncome,
          totalUsers: totalUsers ?? this.totalUsers,
          deviceToken: deviceToken ?? this.deviceToken);

//
  Seller.fromJsonFirebase(DocumentSnapshot snap) {
    Map<String, dynamic> json = snap.data() as Map<String, dynamic>;
    sId = json['_id'];
    deviceToken = json['deviceToken'];

    email = json['email'];
    name = json['name'];
    photoUrls = json['photoUrls'];
    phone = json['phone'];
    if (json['address'] != null) {
      address = Address.fromJson(json['address']);
    }

    if (json['out_of_stock'] != null) {
      outOfStock = <Product>[];
      json['out_of_stock'].forEach((v) {
        outOfStock!.add(Product.fromJson(v));
      });
    }
    if (json['sold'] != null) {
      sold = <Product>[];
      json['sold'].forEach((v) {
        sold!.add(Product.fromJson(v));
      });
    }
    if (json['unsold'] != null) {
      unsold = <Product>[];
      json['unsold'].forEach((v) {
        unsold!.add(Product.fromJson(v));
      });
    }
    if (json['almost_finished'] != null) {
      almostFinished = <Product>[];
      json['almost_finished'].forEach((v) {
        almostFinished!.add(Product.fromJson(v));
      });
    }
    if (json['most_sell'] != null) {
      mostSell = <Product>[];
      json['most_sell'].forEach((v) {
        mostSell!.add(Product.fromJson(v));
      });
    }
    if (json['today_orders'] != null) {
      todayOrders = <Product>[];
      json['today_orders'].forEach((v) {
        todayOrders!.add(Product.fromJson(v));
      });
    }
    todayIncome = json['today_income'];
    totalUsers = json['total_users'];
  }

//
  Seller.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    deviceToken = json['deviceToken'];
    email = json['email'];
    name = json['name'];
    photoUrls = json['photoUrls'];
    phone = json['phone'];
    if (json['address'] != null) {
      address = Address.fromJson(json['address']);
    }

    if (json['out_of_stock'] != null) {
      outOfStock = <Product>[];
      json['out_of_stock'].forEach((v) {
        outOfStock!.add(Product.fromJson(v));
      });
    }
    if (json['sold'] != null) {
      sold = <Product>[];
      json['sold'].forEach((v) {
        sold!.add(Product.fromJson(v));
      });
    }
    if (json['unsold'] != null) {
      unsold = <Product>[];
      json['unsold'].forEach((v) {
        unsold!.add(Product.fromJson(v));
      });
    }
    if (json['almost_finished'] != null) {
      almostFinished = <Product>[];
      json['almost_finished'].forEach((v) {
        almostFinished!.add(Product.fromJson(v));
      });
    }
    if (json['most_sell'] != null) {
      mostSell = <Product>[];
      json['most_sell'].forEach((v) {
        mostSell!.add(Product.fromJson(v));
      });
    }
    if (json['today_orders'] != null) {
      todayOrders = <Product>[];
      json['today_orders'].forEach((v) {
        todayOrders!.add(Product.fromJson(v));
      });
    }
    todayIncome = json['today_income'];
    totalUsers = json['total_users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['_id'] = sId;
    data['deviceToken'] = deviceToken;

    data['email'] = email;
    data['name'] = name;
    data['photoUrls'] = photoUrls;
    data['phone'] = phone;
    if (address != null) {
      data['address'] = address!.toJson();
    }

    if (outOfStock != null) {
      data['out_of_stock'] = outOfStock!.map((v) => v.toJson()).toList();
    }
    if (sold != null) {
      data['sold'] = sold!.map((v) => v.toJson()).toList();
    }
    if (unsold != null) {
      data['unsold'] = unsold!.map((v) => v.toJson()).toList();
    }
    if (almostFinished != null) {
      data['almost_finished'] = almostFinished!.map((v) => v.toJson()).toList();
    }
    if (mostSell != null) {
      data['most_sell'] = mostSell!.map((v) => v.toJson()).toList();
    }
    if (todayOrders != null) {
      data['today_orders'] = todayOrders!.map((v) => v.toJson()).toList();
    }
    data['today_income'] = todayIncome;
    data['total_users'] = totalUsers;
    return data;
  }
}
