// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'fcm_provider.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  static FirebaseMessaging? _firebaseMessaging;
  static FirebaseMessaging get firebaseMessaging =>
      NotificationService._firebaseMessaging ?? FirebaseMessaging.instance;

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    NotificationService._firebaseMessaging = FirebaseMessaging.instance;
    await NotificationService.initializeLocalNotifications();
    await FCMProvider.onMessage();
    await NotificationService.onBackgroundMsg();
  }

  Future<String?> getDeviceToken() async =>
      await FirebaseMessaging.instance.getToken();
  //
  // final BehaviorSubject<String> behaviorSubject = BehaviorSubject();
//!
  // static late BigPictureStyleInformation bigPictureStyleInformation;
  static ByteArrayAndroidBitmap? largeIcon;
//!
  static FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initializeLocalNotifications() async {
    const InitializationSettings initSettings = InitializationSettings(
        android: AndroidInitializationSettings("ic_launcher"),
        iOS: DarwinInitializationSettings());

    /// on did receive notification response = for when app is opened via notification while in foreground on android
    await NotificationService.localNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: FCMProvider.onTapNotification);
// !
    // var details = await NotificationService.localNotificationsPlugin
    //     .getNotificationAppLaunchDetails();
    // if (details != null && details.didNotificationLaunchApp) {}
// !
    /// need this for ios foregournd notification
    await NotificationService.firebaseMessaging
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

// Required to display a heads up notification
  static NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: AndroidNotificationDetails(
      "high_importance_channel",
      "High Importance Notifications",
      priority: Priority.high,
      importance: Importance.max,
      icon: 'ic_launcher',
      largeIcon: largeIcon,
    ),
  );

  // Required to display a Right side image on notification
  static getIcons({String? url}) async {
    largeIcon = ByteArrayAndroidBitmap(await _getByteArrayFromUrl(url: url));
  }

  // Required to display a Right side image Download
  static Future<Uint8List> _getByteArrayFromUrl({String? url}) async {
    final http.Response response = await http.get(Uri.parse(url!));
    return response.bodyBytes;
  }

  // for receiving message when app is in background or foreground
  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (Platform.isAndroid) {
        // !
        // await getIcons();
        // !
        // if this is available when Platform.isIOS, you'll receive the notification twice
        await NotificationService.localNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          NotificationService.platformChannelSpecifics,
          payload: message.data.toString(),
        );
      }
    });
  }

  static Future<void> onBackgroundMsg() async {
    FirebaseMessaging.onBackgroundMessage(FCMProvider.backgroundHandler);
  }
}
