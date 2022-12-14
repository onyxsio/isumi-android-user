// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:remote_data/src/error/failure.dart';
import 'package:remote_data/src/key/api_key.dart';
import 'package:remote_data/src/model/models.dart';
import 'package:remote_data/src/model/seller.dart';
import 'package:uuid/uuid.dart';
import 'storage.dart';
// import 'package:google_sign_in/google_sign_in.dart' as gs;

class FireRepo {
  // ! USE
  // Get instance of Firebase Firestore
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Cerate instance of products Database
  static var customerDB = firestore.collection('customers');
  // Cerate instance of products Database
  static var productsDB = firestore.collection('products');
  static var sellerDB = firestore.collection('sellers');
  static var ordersDB = firestore.collection('orders');
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
  static Future<bool> isAdmin(String email) async {
    try {
      return await sellerDB
          .where('email', isEqualTo: email)
          .get()
          .then((QuerySnapshot snapshot) {
        if (snapshot.docs.isEmpty) {
          return true;
        } else {
          return false;
        }
      });
      // return true;
    } on FirebaseException catch (e) {
      throw AppFirebaseFailure.fromCode(e.code);
    } catch (_) {
      return false;
    }
  }

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

//
  static Future<void> updateCustomer(Customer customer, xfile) async {
    final user = auth.FirebaseAuth.instance.currentUser;
    try {
      String photoUrl =
          await StorageRepository().uploadImages('profile', xfile);
      await customerDB
          .doc(customer.id)
          .update(customer.copyWith(photoUrls: photoUrl).toJson());
      //
      user!.updateDisplayName(customer.name);
      user.updatePhotoURL(photoUrl);
    } catch (_) {}
  }

//
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

  //
  static Future<void> removeCart(String id) async {
    final user = auth.FirebaseAuth.instance.currentUser;
    try {
      await customerDB.doc(user!.uid).collection('cart').doc(id).delete();
    } catch (e) {
      log(e.toString());
    }
  }

//
  static Future<void> addToRivewCustomerDB(Review review) async {
    final user = auth.FirebaseAuth.instance.currentUser;
    try {
      await customerDB.doc(user!.uid).update({
        'review': FieldValue.arrayUnion([review.toJson()])
      });
    } catch (_) {}
  }

//
  static Future<void> addToRivewProductDB(
      ReviewRating review, String id) async {
    final user = auth.FirebaseAuth.instance.currentUser;
    try {
      await productsDB.doc(id).get().then((DocumentSnapshot doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
          Rivews val = Rivews.fromJson(data['rivews']);
          log(Rivews.fromJson(data['rivews']).toJson().toString());

          var total = (double.parse(val.reviewTot!) +
              double.parse(review.ratingValue!));
          var value = ((total / (val.reviewCount! + 1)) * 5);
          log(value.toString());
          productsDB.doc(id).update({
            'rivews.reviewCount': FieldValue.increment(1),
            'rivews.ratingValue': value.toString(),
            'rivews.reviewTot': total.toString(),
          });
        }
      });
      await productsDB.doc(id).update({
        'reviewRating': FieldValue.arrayUnion(
            [review.copyWith(author: user!.displayName).toJson()])
      });
    } catch (e) {
      log(e.toString());
    }
  }

  //
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

  static Future<void> addToWishList(Product product) async {
    final user = auth.FirebaseAuth.instance.currentUser;
    try {
      await customerDB
          .doc(user!.uid)
          .collection('wishlist')
          .doc(product.sId)
          .set(product.toJson());
      await customerDB.doc(user.uid).update({
        'wishlist': FieldValue.arrayUnion([product.sId])
      });
    } catch (_) {}
  }

  static Future<void> removeWishList(Product product) async {
    final user = auth.FirebaseAuth.instance.currentUser;
    try {
      await customerDB
          .doc(user!.uid)
          .collection('wishlist')
          .doc(product.sId)
          .delete();
      await customerDB.doc(user.uid).update({
        'wishlist': FieldValue.arrayRemove([product.sId])
      });
    } catch (_) {}
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
      //
      await customerDB.doc(user!.uid).update({
        'order': FieldValue.arrayUnion([orderId])
      });
      // This is used to rivew
      await firestore
          .collection('orders')
          .doc(orderId)
          .set(order.copyWith(oId: orderId).toJson());
      //
      await customerDB
          .doc(user.uid)
          .collection('orders')
          .doc(orderId)
          .set(order.copyWith(oId: orderId).toJson());
      //
      for (var item in order.items!) {
        List<Variant> variants = [];
        var product = await productsDB
            .doc(item.productId)
            .get()
            .then((snapshot) => Product.fromSnap(snapshot));
        // **
        await sellerDB.doc(item.sellerId).update({
          'sold': FieldValue.arrayUnion([item.productId])
        });
        // **
        for (var v in product.variant!) {
          variants.add(v);
          if (v.color! == (item.color!)) {
            List<Subvariant> subs = [];
            for (var s in v.subvariant!) {
              subs.add(s);
              if (s.size! == (item.size!)) {
                variants.remove(v);
                subs.remove(s);
                var stock = (int.parse(s.stock!) - int.parse(item.quantity!));
                subs.add(s.copyWith(stock: stock.toString()));
              }
            }
            variants.add(v.copyWith(subvariant: subs));
          }
        }

        await productsDB
            .doc(item.productId)
            .update(product.copyWith(variant: variants).toJson());
      }
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
}
