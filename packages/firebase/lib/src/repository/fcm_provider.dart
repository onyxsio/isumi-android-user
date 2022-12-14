import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart'
    show FirebaseMessaging, RemoteMessage;
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_service.dart';

class FCMProvider with ChangeNotifier {
  static BuildContext? _context;

  static void setContext(BuildContext context) =>
      FCMProvider._context = context;

  /// when app is in the foreground
  static Future<void> onTapNotification(NotificationResponse? response) async {
    //  if (FCMProvider._context == null || response?.payload == null) return;
    if (response?.payload == null) return;
    final data = FCMProvider.convertPayload(response!.payload!);
    if (data.containsKey('status')) {
      // !  check the _context it's not null
      // await Navigator.of(FCMProvider._context!).pushNamed('/OrderDetails');
      // FlutterAppBadger.removeBadge();
      //
    }
  }

  static convertPayload(String payload) {
    final String newpayload = payload.substring(1, payload.length - 1); // - 1

    List<String> split = [];
    newpayload.split(",").forEach((String s) => split.addAll(s.split(":")));
    var mapped = {};
    for (int i = 0; i < split.length + 1; i++) {
      if (i % 2 == 1) {
        mapped.addAll({split[i - 1].trim().toString(): split[i].trim()});
      }
    }
    return mapped;
  }

// Crude counter to make messages unique
  static int messageCount = 0;
  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      messageCount++;
      // if (FCMProvider._refreshNotifications != null) {
      //   await FCMProvider._refreshNotifications!(true);
      // }

      // if this is available when Platform.isIOS, you'll receive the notification twice
      if (Platform.isAndroid) {
        await NotificationService.localNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          NotificationService.platformChannelSpecifics,
          payload: message.data.toString(),
        );
      }
      if (message.data['status'] == 'order') {
        // await NotificationService.getIcons();
      }
      // FlutterAppBadger.updateBadgeCount(messageCount);
    });
  }

  static Future<void> backgroundHandler(RemoteMessage message) async {
    messageCount++;
    Stream<RemoteMessage> stream = FirebaseMessaging.onMessageOpenedApp;
    // FlutterAppBadger.updateBadgeCount(messageCount);
    stream.listen((RemoteMessage event) async {
      if (event.data.isNotEmpty) {
        await Navigator.of(FCMProvider._context!).pushNamed('/ProductAdd');
      }
    });
  }
}
