import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class Dashboard {
  List<Product>? outOfStock;
  List<Product>? sold;
  List<Product>? unsold;
  List<Product>? almostFinished;
  List<Product>? mostSell;
  List<Product>? todayOrders;
  String? todayIncome;
  String? totalUsers;

  Dashboard(
      {this.outOfStock,
      this.sold,
      this.unsold,
      this.almostFinished,
      this.mostSell,
      this.todayOrders,
      this.todayIncome,
      this.totalUsers});

//
  Dashboard.fromJsonFirebase(DocumentSnapshot snap) {
    Map<String, dynamic> json = snap.data() as Map<String, dynamic>;
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
  Dashboard.fromJson(Map<String, dynamic> json) {
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

Dashboard emptyDash = Dashboard(
  almostFinished: [],
  todayIncome: "",
  outOfStock: [],
  sold: [],
  unsold: [],
  mostSell: [],
  todayOrders: [],
  totalUsers: "",
);
