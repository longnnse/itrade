import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/utils/app_settings.dart';
import 'package:i_trade/firebase_options.dart';
import 'package:i_trade/src/presentation/pages/chat/index.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseMessagingHandler {
  FirebaseMessagingHandler._();
  static AndroidNotificationChannel channel_call =
      const AndroidNotificationChannel(
    'com.dbestech.chatty_chat.call',
    'chatty_call',
    importance: Importance.max,
    enableLights: true,
    playSound: true,
    sound: RawResourceAndroidNotificationSound("alert"),
  );

  static AndroidNotificationChannel channel_message =
      const AndroidNotificationChannel(
    'com.dbestech.chatty_chat.call',
    'chatty_message',
    importance: Importance.defaultImportance,
    enableLights: true,
    playSound: true,
  );

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<NotificationDetails> notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      groupKey: 'com.example.flutter_push_notifications',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      color: const Color(0xff2196f3),
    );
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();
    return const NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
  }

  static Future<void> config() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      await messaging.requestPermission(
          sound: true,
          badge: true,
          alert: true,
          announcement: false,
          carPlay: false,
          criticalAlert: false,
          provisional: false);

      var initializationSettingsAndroid =
          const AndroidInitializationSettings("ic_launcher");
      var darwinInitializationSettings = const DarwinInitializationSettings();
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: darwinInitializationSettings,
          macOS: darwinInitializationSettings);
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: (value) {
        var result = value.payload!.split("/");
        Get.toNamed(ChatPage.routeName,
            parameters: {"trading_id": result[0], "to_avatar": result[1]});
      });
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
              alert: true, badge: true, sound: true);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        _receiveNotification(message);
      });
    } on Exception catch (e) {
      print("$e");
    }
  }

  static Future<void> _receiveNotification(RemoteMessage message) async {
    if (!Get.currentRoute.contains(ChatPage.routeName) &&
        AppSettings.getValue(KeyAppSetting.isDangNhap)) {
      var details = await notificationDetails();

      print(message.data['tradingId']);
      print(message.data['toAvatar']);

      await flutterLocalNotificationsPlugin.show(12345,
          message.notification?.title, message.notification?.body, details,
          payload: '${message.data['tradingId']}/${message.data['toAvatar']}');
    }
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackground(RemoteMessage message) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    if (AppSettings.getValue(KeyAppSetting.isDangNhap)) {
      var details = await notificationDetails();
      await flutterLocalNotificationsPlugin.show(12345,
          message.notification?.title, message.notification?.body, details,
          payload: '${message.data['tradingId']}/${message.data['toAvatar']}');
    }
  }
}
