import 'package:remote_data/src/model/order.dart';

class Seller {
  // String? deviceToken;
  String? sId;
  List<Orders>? orders;

  Seller({this.sId, this.orders});

  Seller.fromJson(Map<String, dynamic> json) {
    // deviceToken = json['deviceToken'];
    sId = json['_id'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['deviceToken'] = deviceToken;
    data['_id'] = sId;
    if (orders != null) {
      data[''] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
