// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:components/components.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_database/local_db.dart';
import 'package:remote_data/src/error/failure.dart';
import 'package:remote_data/src/model/models.dart';
import 'package:uuid/uuid.dart';
import 'storage_repository.dart';

class FirestoreRepository {
  // Get instance of Firebase Firestore
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Cerate instance of products Database
  static var productsDB = firestore.collection('products');
// Cerate instance of products Database
  static var sellerDB = firestore.collection('seller');
  // Stream<QuerySnapshot>
  static var productStream = productsDB.snapshots();
  static var offerDB = firestore.collection('offers');
  static var offerStream = offerDB.snapshots();
  // Stream<QuerySnapshot>
  // static var orderStream = sellerDB.doc('order').snapshots();
  //
  Future<void> setupDeviceToken() async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    // Dashboard dashboard = Dashboard();
    try {
      sellerDB
          .doc('admin_data')
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          sellerDB.doc('admin_data').update({'deviceToken': deviceToken});
        } else {
          sellerDB.doc('admin_data').set({'deviceToken': deviceToken});
          sellerDB.doc('overview').set(emptyDash.toJson());
          sellerDB.doc('overview').collection('orders');
          // sellerDB.doc('order').set({'orders': []});
        }
      });
    } catch (_) {}
  }

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
    } catch (e) {
      log(e.toString());
    }
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
  static Future<void> setupOrder() async {
    try {
      String orderId = const Uuid().v4();
      // demoOrder
      sellerDB
          .doc('overview')
          .collection('orders')
          .doc(orderId)
          .set(demoOrder.toJson());
    } catch (_) {}
  }

//! TODO delete this above code
  static Future<void> orderMoveToDelivered(Orders orders) async {
    try {
      // String orderId = const Uuid().v4();
      // demoOrder
      await sellerDB
          .doc('overview')
          .collection('orders')
          .doc(orders.sId)
          .delete();
      //
      sellerDB
          .doc('overview')
          .collection('delivered')
          .doc(orders.sId)
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
  //
  Future<void> setupDashboard(Dashboard dashboard) async {
    try {
      sellerDB.doc('overview').get().then((DocumentSnapshot documentSnapshot) {
        if (!documentSnapshot.exists) {
          sellerDB.doc('overview').set(dashboard.toJson());
        }
      });
    } catch (_) {}
  }

  //
  // Upload a new Product to products Database
  //
  static Future<void> addProduct(
      BuildContext context, Product product, List<XFile>? images) async {
    // Store Multiple Images urls
    List<String> photoUrls = [];
    // Set<String> subv = <String>{};
    List minPrice = [];
    // Store sinlgel Images urls
    // String photoUrl = "";
    try {
      // creates unique id based on time
      String productId = const Uuid().v1();
      // Find a minimum price in list
      for (var variant in product.variant!) {
        for (var subvariant in variant.subvariant!) {
          minPrice.add(double.parse(subvariant.price!));
        }
      }
      var minimumPrice = minPrice
          .reduce((value, element) => value < element ? value : element);

      Price price =
          Price(value: minimumPrice.toString(), currency: LocalDB.getCurrency);

      // upload Singel Image to Firestore, and get Url
      // photoUrl = await StorageRepository().uploadImages(productId, xfile);
      Rivews rivews = Rivews(ratingValue: '0', reviewCount: '0');
      // upload Multiple Images to Firestore, and get Urls
      photoUrls = await StorageRepository().uploadFiles(images!, productId);
      var modifiyProduct = product.copyWith(
        sId: productId,
        thumbnail: photoUrls[0],
        price: price,
        rivews: rivews,
        images: photoUrls,
      );
      productsDB.doc(productId).set(modifiyProduct.toJson()).then((value) =>
          DialogBoxes.showAutoCloseDialog(context,
              type: InfoDialog.successful,
              message: 'It was successfully uploaded !'));
    } on FirebaseException catch (e) {
      var msg = AppFirebaseFailure.fromCode(e.code);
      DialogBoxes.showAutoCloseDialog(context,
          type: InfoDialog.error, message: msg.message);
      //  DialogBoxes.showAutoCloseDialog(context);

    } catch (_) {}
  }

//
  static Future<void> updateProduct(
    BuildContext context,
    Product product,
    List<XFile>? images,
    List<Variant> variant,
    // String discount,
  ) async {
    List photoUrls = [];
    // Set<String> subv = <String>{};
    List minPrice = [];

    try {
      if (images!.isNotEmpty) {
        photoUrls = await StorageRepository().uploadFiles(images, product.sId!);
      }
      for (var image in product.images!) {
        photoUrls.add(image);
      }

      // Find a minimum price in list
      for (var variant in product.variant!) {
        for (var subvariant in variant.subvariant!) {
          minPrice.add(double.parse(subvariant.price!));
        }
      }
      var minimumPrice = minPrice
          .reduce((value, element) => value < element ? value : element);
      Price price =
          Price(value: minimumPrice.toString(), currency: LocalDB.getCurrency);

      var newProduct = product.copyWith(
        thumbnail: photoUrls[0],
        price: price,
        images: photoUrls,
      );

      productsDB.doc(product.sId).update(newProduct.toJson()).then((value) =>
          DialogBoxes.showAutoCloseDialog(context,
              type: InfoDialog.successful,
              message: 'It was successfully updated !'));
    } on FirebaseException catch (e) {
      var msg = AppFirebaseFailure.fromCode(e.code);
      DialogBoxes.showAutoCloseDialog(context,
          type: InfoDialog.error, message: msg.message);
    } catch (_) {
      DialogBoxes.showAutoCloseDialog(context,
          type: InfoDialog.error, message: 'An unknown exception occurred.');
    }
  }

  // Delete Product
  static Future<void> deleteProduct(String pId) async {
    try {
      await productsDB.doc(pId).delete();
    } on FirebaseException catch (e) {
      throw AppFirebaseFailure.fromCode(e.code);
    } catch (_) {
      throw const AppFirebaseFailure();
    }
  }
}

// class MyOrder {
//   final List orders;
//   MyOrder({required this.orders});

//   static MyOrder formJson(data) {
//     return MyOrder(orders: data['newOrder']);
//   }

//   Map<String, dynamic> toJson() => {"newOrder": orders};
// }
//
