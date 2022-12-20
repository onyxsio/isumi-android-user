// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:components/components.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_database/local_db.dart';
import 'package:remote_data/src/error/failure.dart';
import 'package:remote_data/src/key/api_key.dart';
import 'package:remote_data/src/model/models.dart';
import 'package:remote_data/src/model/seller.dart';
import 'package:uuid/uuid.dart';
import 'storage_repository.dart';
import 'package:google_sign_in/google_sign_in.dart' as gs;

class FirestoreRepository {
  // ! USE
  // Get instance of Firebase Firestore
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Cerate instance of products Database
  static var customerDB = firestore.collection('customers');
  // Cerate instance of products Database
  static var productsDB = firestore.collection('products');
  static var sellerDB = firestore.collection('sellers');
  // Stream<QuerySnapshot>
  static var productStream = productsDB.snapshots();
  static var productLimitStream = productsDB.limit(20).snapshots();

  // static var customerStream = customerDB.doc().snapshots();
  // ! not used blow line

  // Cerate instance of products Database

  static var offerDB = firestore.collection('offers');
  static var offerStream = offerDB.snapshots();
  // Stream<QuerySnapshot>
  // static var orderStream = sellerDB.doc('order').snapshots(); .limit(1).
  // ! USE
  // static setupcustomerStream() async {
  //   final user = auth.FirebaseAuth.instance.currentUser;
  //   return customerDB.doc(user!.uid).snapshots();
  // }

  //
  static Future<void> createAccount(auth.User user) async {
    try {
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      await customerDB.doc(user.uid).set(demoCustomer
          .copyWith(
            email: user.email,
            id: user.uid,
            deviceToken: deviceToken,
          )
          .toJson());
    } on FirebaseException catch (e) {
      AppFirebaseFailure.fromCode(e.code);
    } catch (_) {}
  }

  // static Future<void> createAccountGoogle(gs.GoogleSignInAccount user) async {
  //   try {
  //     String? deviceToken = await FirebaseMessaging.instance.getToken();
  //     await customerDB.doc(user.id).set(demoCustomer
  //         .copyWith(
  //           email: user.email,
  //           id: user.id,
  //           deviceToken: deviceToken,
  //         )
  //         .toJson());
  //   } on FirebaseException catch (e) {
  //     AppFirebaseFailure.fromCode(e.code);
  //   } catch (_) {}
  // }

  //
  static Future<void> setupDeviceToken() async {
    final user = auth.FirebaseAuth.instance.currentUser;
    String? deviceToken = await FirebaseMessaging.instance.getToken();

    try {
      customerDB.doc(user!.uid).get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          customerDB.doc(user.uid).update({'deviceToken': deviceToken});
        }
      });
    } on FirebaseException catch (e) {
      AppFirebaseFailure.fromCode(e.code);
    } catch (_) {}
  }

  static Future<String> setupQuantity(Items item) async {
    String stock = '';
    try {
      await productsDB
          .doc(item.productId)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Product product = Product.fromSnap(documentSnapshot);

          for (var variant in product.variant!) {
            if (variant.color!.contains(item.color!)) {
              for (var subvariant in variant.subvariant!) {
                if (subvariant.size!.contains(item.size!)) {
                  stock = subvariant.stock.toString();
                }
              }
            }
          }
        }
      });
      return stock;
    } catch (_) {
      return stock;
    }
  }

  static Future<Customer> getCustomer() async {
    try {
      final user = auth.FirebaseAuth.instance.currentUser;
      var customer = await customerDB.doc(user!.uid).get();
      return Customer.fromDocumentSnapshot(customer);
    } on FirebaseException catch (e) {
      AppFirebaseFailure.fromCode(e.code);
      return Customer();
    } catch (_) {
      return Customer();
    }
  }

  static Future<String> setupAddress(Address address) async {
    final user = auth.FirebaseAuth.instance.currentUser;

    try {
      customerDB.doc(user!.uid).get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          customerDB.doc(user.uid).update({'address': address.toJson()});
        }
      });
      return 'done';
    } on FirebaseException catch (e) {
      return AppFirebaseFailure.fromCode(e.code).message;
    } catch (_) {
      return const AppFirebaseFailure().message;
    }
  }

// Add items for cart
  static Future<bool> addToCart(Items item) async {
    final user = auth.FirebaseAuth.instance.currentUser;
    try {
      String cartId = const Uuid().v4();
      await customerDB
          .doc(user!.uid)
          .collection('cart')
          .doc(cartId)
          .set(item.copyWith(id: cartId).toJson());
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<void> removeCart(String id) async {
    final user = auth.FirebaseAuth.instance.currentUser;
    try {
      await customerDB.doc(user!.uid).collection('cart').doc(id).delete();
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> quantityUpdate(String value, String id) async {
    final user = auth.FirebaseAuth.instance.currentUser;

    try {
      await customerDB
          .doc(user!.uid)
          .collection('cart')
          .doc(id)
          .update({'quantity': value});
    } catch (e) {
      log(e.toString());
    }
  }

  // customerDB
  static Future<void> setupOrder(Orders order) async {
    final user = auth.FirebaseAuth.instance.currentUser;
    try {
      String orderId = const Uuid().v4();

      // for (var item in order.items!) {
      await sellerDB
          .doc(order.sellerId)
          .collection('orders')
          .doc(orderId)
          .set(order.copyWith(oId: orderId).toJson());
      await customerDB.doc(user!.uid).update({
        'order': FieldValue.arrayUnion([order.copyWith(oId: orderId).toJson()])
      });
      // }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> deleteCart() async {
    final user = auth.FirebaseAuth.instance.currentUser;
    try {
      customerDB
          .doc(user!.uid)
          .collection('cart')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          customerDB.doc(user.uid).collection('cart').doc(doc.id).delete();
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> sendOrder(Orders order) async {
    try {
      await sellerDB
          .doc(order.sellerId)
          .get()
          .then((DocumentSnapshot snapshot) async {
        Seller seller = Seller.fromJsonFirebase(snapshot);
        await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': serverKey,
          },
          body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'body': 'A new order has been received',
                'title': 'You have received a new order'
              },
              'priority': 'high',
              'data': <String, dynamic>{
                'order': order.toJson(),
                'id': 'uid',
                'status': 'order'
              },
              "to": seller.deviceToken,
            },
          ),
        );
      });
    } catch (_) {}
  }
  // ! not user below

  // !

  static Future<void> setupOffers(
      List<Product> products, Offers offers, xfile) async {
    try {
      List productDB = [];
      for (var product in products) {
        await productsDB.doc(product.sId).update({'offers': offers.toJson()});
        productDB.add(product.toJson());
      }
      // !
      String offerId = const Uuid().v1();
      String photoUrl = await StorageRepository().uploadImages('offer', xfile);
      await offerDB.doc(offerId).set({
        'banner': photoUrl,
        'valid': offers.expirationDate,
        'products': productDB
      });
    } on FirebaseException catch (e) {
      AppFirebaseFailure.fromCode(e.code);
    } catch (_) {}
  }

  static Future<void> deleteOffer(String id) async {
    try {
      await offerDB.doc(id).delete();
    } catch (_) {}
  }
// ***
  // static Future<void> getOffers(
  //     List<Product> products, Offers offers, xfile) async {
  //   try {
  //     List productDB = [];
  //     for (var product in products) {
  //       await productsDB.doc(product.sId).update({'offers': offers.toJson()});
  //       productDB.add(product.toJson());
  //     }
  //     // !
  //     String offerId = const Uuid().v1();
  //     String photoUrl = await StorageRepository().uploadImages('offer', xfile);
  //     await offerDB
  //         .doc(offerId)
  //         .set({'banner': photoUrl, 'products': productDB});
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

// ***
// ! TODO delete this below code
  // static Future<void> setupOrder() async {
  //   try {
  //     String orderId = const Uuid().v4();
  //     // demoOrder
  //     sellerDB
  //         .doc('overview')
  //         .collection('orders')
  //         .doc(orderId)
  //         .set(demoOrder.toJson());
  //   } catch (_) {}
  // }

//! TODO delete this above code
  static Future<void> orderMoveToDelivered(Orders orders) async {
    try {
      // String orderId = const Uuid().v4();
      // demoOrder
      await sellerDB
          .doc('overview')
          .collection('orders')
          .doc(orders.oId)
          .delete();
      //
      sellerDB
          .doc('overview')
          .collection('delivered')
          .doc(orders.oId)
          .set(orders.toJson());
      //
    } on FirebaseException catch (e) {
      throw AppFirebaseFailure.fromCode(e.code);
    } catch (_) {}
  }

// !
  static Future<void> deleteDelivery(String pId) async {
    try {
      await sellerDB.doc('overview').collection('delivered').doc(pId).delete();
    } on FirebaseException catch (e) {
      throw AppFirebaseFailure.fromCode(e.code);
    } catch (_) {
      throw const AppFirebaseFailure();
    }
  }

// !
}
