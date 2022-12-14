import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:remote_data/src/key/api_key.dart';

class FireMessage {
  // Get instance of Firebase Firestore
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
//
  static var customerDB = firestore.collection('customer');

  static Future<void> sendMessage(String title, String message) async {
    List<String> tokens = [];
    List<String> uids = [];
    try {
      // !
      await customerDB.get().then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          tokens.add(doc["deviceToken"]);
          uids.add(doc["id"]);
        }
      });
      // !
      for (var token in tokens) {
        await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': serverKey,
          },
          body: jsonEncode(
            <String, dynamic>{
              'notification': <String, dynamic>{
                'body': message,
                'title': title
              },
              'priority': 'high',
              'data': <String, dynamic>{},
              "to": token,
            },
          ),
        );
      }
      // !
      for (var uid in uids) {
        await customerDB.doc(uid).update({
          'notification': FieldValue.arrayUnion([
            {'body': message, 'title': title}
          ])
        });
      }
      // !
      // sellerDB.doc('admin_data').update({
      //   'newOrder': FieldValue.arrayUnion([const Uuid().v1()])
      // });
      // String token =
      //     "eL7qUddHT4-lMqoif_SJnX:APA91bEk-wrs8UVgJ2OYmnNP_akkh94rRCaPWTSBY4MvAhgbIkSJlN_6k5ZoPcN2p6c8XLG1QYB_lSX0JNhyQKNPYKYMqThwg2edCTH-ZBNLB8MkW8Z5XbFC2Ma3CB2tx-Q4VcfQLJxA";

    } catch (_) {}
  }
}
