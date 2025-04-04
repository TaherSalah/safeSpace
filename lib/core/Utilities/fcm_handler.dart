import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:safeSpace/core/Utilities/toast_helper.dart';
import 'package:safeSpace/features/view/contactUser/emergencyView.dart';

import '../../main.dart';

class MyFirebaseMessagingService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Request notification permissions
  static Future<void> requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint("User denied notifications.");
    } else {
      debugPrint("User granted notifications: ${settings.authorizationStatus}");
    }
  }

  // Initialize Firebase Messaging
  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap event
        debugPrint("Notification Clicked: ${response.payload}");
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Foreground Notification: ${message.notification?.title}");
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("User opened app via notification: ${message.data}");
      debugPrint("User: ${message.data}");

      Navigator.push(navigatorKey.currentState!.context, MaterialPageRoute(builder: (context) => ContactView(),));

    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        debugPrint("App opened from terminated state: ${message.data}");
      }
    });

    // Subscribe to topic when initializing (Optional)
    await subscribeToTopic("rate-update");
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    debugPrint("Handling background message: ${message.messageId}");
  }

  static fcmToken(fcmToken) =>
      FirebaseMessaging.instance.getToken().then((fcmToken) {
        debugPrint("FCM Token: $fcmToken");
      });
  // Subscribe to a topic
  static Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    debugPrint("Subscribed to topic: $topic");
  }

  // Unsubscribe from a topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    debugPrint("Unsubscribed from topic: $topic");
  }

  // Show Local Notification
  static Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }
}

class NotificationsHelper {
  // creat instance of fbm
  final _firebaseMessaging = FirebaseMessaging.instance;

  // initialize notifications for this app or device
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    // get device token
    String? deviceToken = await _firebaseMessaging.getToken();

    print(
        "===================Device FirebaseMessaging Token====================");
    print(deviceToken);
    print(
        "===================Device FirebaseMessaging Token====================");
  }

  // handle notifications when received
  void handleMessages(RemoteMessage? message) {
    if (message != null) {
      print("message in handle ${message.data}");
      print("message in  ${message}");
    }
  }

  // handel notifications in case app is terminated
  void handleBackgroundNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then((handleMessages));
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
  }

  Future<String?> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "measure-heart-rate",
      "private_key_id": "6cbdb0ef1033bf51c4851a541189f134a4ee339c",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDO1Z9OLWLKhBMi\ntZMBi/Hf3/9nIVEn9cSQTXKIhBWTzjCzQ2aVTyTipLeuiDa+814DkQQPlM59qt8/\n9zFvKBOQm4EhQO67/s5Wd+d9458Bz5Kp8rrxTxA0uMB4Z9kLj0Dd7MosyqsgxZBa\ncNJc+rtLYniie5T7DPY+ynzfDRtbC1UDANnR5O93rjRITTdk/Zzym8ujjhlWIB6u\n25CQU9WGLLlwvDuYEZcS+0Gqx6iJTUvTBWX0gpHejOfVtVg1y51J4oGthMbJOW0E\nE92VzQs1/fXGx7CFo9e41sngRRA5WWAdaAkx37P6meYXwHiYqO+q8+1rO0rbW54g\nw7Rd3AMFAgMBAAECggEAEmlKIbmhCGFq2aVblWDpcjH8iGfbE0lJisXWGuhVCl/p\njl+Cz2oo4KLkdd0KsIM13G/pcmCe4+lUr5s3s4sX+MCa5USkK6hiIijQurBLHGxn\nhAjHEslkqijC+0TVOXXyQn78PTH6OzPS5nYSB7RK/Uoh7ma9S36rIcpBBNLkGz21\nRN0JixPQl2UfJC2b+XQIbJDH3OEdI2FwpHKqPcelShNFeHpFYQp214EWetv76Wxr\nIdZUxH/Qaa2jZx4t0yNRuZLxuL0hHGn5nAnUqrcZtnxF1mljXnnioimrmx3I3+mk\nkwwD/dDI12w2ZJbhVkDcreTscwflbJ8TcNqYivYwSQKBgQDrL4IYQpefXeuDEGOR\nExxDpF9Ks74j8GtFak6pBwC1iOilRkwSMTTSB215KS/fkCNn5z7DIQFK/jezUQ6F\nFlmaXopseuYZcbq0LJg6JFJSm2VHWiz0hAd7IUwrsRgks2/XpyaN+a2I2yirqWbd\nG0TdgZFj4Z8Og6K96cVFHjtZ3QKBgQDhI8aeL3UsPUYsgRvbCsHbhdk484sbJcQe\na7DvSLwIwTiOvadRRDO3m4OD8Ses06EpJUCzqaBfHFypYJDMVD2h8Yj6GmoGTQOm\n/e09zyguXrghh/degmq8lT8KUgBH5fLQlenCJCP3Lb7i9bc+vPUB0Kv4fFTlRJQR\nDFlwyvo/SQKBgFsVAhgtKhVhRUV0Amt78DVOIk2HAPtgL9spSZ9yg9bKV/cyG2Hs\nRp2UnNQQnGbDpsKlrwvY62xEugOrP6lRN5BuTsOmcRinj/wZTTcvO+acIgQZK1Hj\nFBaelaZSJpyIFad6J5dSe9+FqOGacKju16PFey4ogfYYCt3r/CdBhxDNAoGBANyI\nctIYoqpHCyok/eg+TU5/ehxzU9uvzsANtS9vC+F3g7Muy2qraA1+ZAEmhDqiwsbP\nGuXiTplb6thvIudDzWuIcSisHxc08VLugSl+dlmVpsARs5n8HhnECBBP6r6C3Kq9\nblEhnalOQiGHl4v5A/ZXNV0eTPqXhoJ8mlAGQ8MhAoGATpiRyzMsQ6l2oN21PDOU\nu4qBKUCnGYEdcoWlPcCQW4QSLuINN7wgV382O7XLBOOMKqtTuY8/2Z5M7cWdXcuN\ne7XS3nMgDYDD1B6dwwRuhTFzpjQP0gm7TPIJruJyjpSsXMRVs3oBPDgNUBTl0QXl\nwibii+f/n2FaOC6Sju2Y6DM=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-fbsvc@measure-heart-rate.iam.gserviceaccount.com",
      "client_id": "110196620480251439225",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40measure-heart-rate.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

      auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
              auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
              scopes,
              client);

      client.close();
      print(
          "Access Token: ${credentials.accessToken.data}"); // Print Access Token
      return credentials.accessToken.data;
    } catch (e) {
      print("Error getting access token: $e");
      return null;
    }
  }

  Map<String, dynamic> getBody({
    required String fcmToken,
    required String title,
    required String body,
    required String userId,
    String? type,
  }) {
    return {
      "message": {
        "token": fcmToken,
        "notification": {"title": title, "body": body},
        "android": {
          "notification": {
            "notification_priority": "PRIORITY_MAX",
            "sound": "default"
          }
        },
        "apns": {
          "payload": {
            "aps": {"content_available": true}
          }
        },
        "data": {
          "type": type,
          "id": userId,
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      }
    };
  }

  Future<void> sendNotifications({
    required String fcmToken,
    required String title,
    required String body,
    required String userId,
    String? type,
  }) async {
    try {
      var serverKeyAuthorization = await getAccessToken();

      // change your project id
      const String urlEndPoint =
          "https://fcm.googleapis.com/v1/projects/measure-heart-rate/messages:send";

      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $serverKeyAuthorization';

      var response = await dio.post(
        urlEndPoint,
        data: getBody(
          userId: userId,
          fcmToken: fcmToken,
          title: title,
          body: body,
          type: type ?? "message",
        ),
      );

      // Print response status code and body for debugging
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error sending notification: $e");
    }
  }
}
