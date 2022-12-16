// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart' as auth;
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
  // ! USE
  // Get instance of Firebase Firestore
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Cerate instance of products Database
  static var customerDB = firestore.collection('customers');
  // Cerate instance of products Database
  static var productsDB = firestore.collection('products');
  // Stream<QuerySnapshot>
  static var productStream = productsDB.snapshots();
  static var productLimitStream = productsDB.limit(20).snapshots();
  // ! not used blow line

  // Cerate instance of products Database
  static var sellerDB = firestore.collection('seller');
  static var offerDB = firestore.collection('offers');
  static var offerStream = offerDB.snapshots();
  // Stream<QuerySnapshot>
  // static var orderStream = sellerDB.doc('order').snapshots(); .limit(1).
  // ! USE
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

  static Future<String> setupQuantity(Cart data) async {
    String stock = '';
    try {
      await productsDB
          .doc(data.pid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Product product = Product.fromSnap(documentSnapshot);

          for (var variant in product.variant!) {
            if (variant.color!.contains(data.color)) {
              for (var subvariant in variant.subvariant!) {
                if (subvariant.size!.contains(data.size)) {
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
      productsDB.doc(productId).set(modifiyProduct.toJson());
      // .then((value) =>
      // DialogBoxes.showAutoCloseDialog(context,
      //     type: InfoDialog.successful,
      //     message: 'It was successfully uploaded !'));
    } on FirebaseException catch (e) {
      var msg = AppFirebaseFailure.fromCode(e.code);
      // DialogBoxes.showAutoCloseDialog(context,
      //     type: InfoDialog.error, message: msg.message);
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
}
