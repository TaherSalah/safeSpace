import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/core/Utilities/k_color.dart';
import 'package:safeSpace/core/Utilities/toast_helper.dart';
import 'package:safeSpace/core/Widgets/default_text_widget.dart';
import 'package:safeSpace/features/view/emergency/emergencyView.dart';
import 'package:safeSpace/features/viewModel/home_controllar.dart';

import '../../../core/Utilities/fcm_handler.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  ContactViewState createState() => ContactViewState();
}

class ContactViewState extends StateMVC<ContactView> {
  late HomeController con;

  ContactViewState() : super(HomeController()) {
    con = controller as HomeController;
    ();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> sendNotification() async {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc('user@gmail.com')
          .get();

      if (!snapshot.exists) return;

      String? userToken = snapshot['token'];
      if (userToken == null) return;

      String serverKey =
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDO1Z9OLWLKhBMi\ntZMBi/Hf3/9nIVEn9cSQTXKIhBWTzjCzQ2aVTyTipLeuiDa+814DkQQPlM59qt8/\n9zFvKBOQm4EhQO67/s5Wd+d9458Bz5Kp8rrxTxA0uMB4Z9kLj0Dd7MosyqsgxZBa\ncNJc+rtLYniie5T7DPY+ynzfDRtbC1UDANnR5O93rjRITTdk/Zzym8ujjhlWIB6u\n25CQU9WGLLlwvDuYEZcS+0Gqx6iJTUvTBWX0gpHejOfVtVg1y51J4oGthMbJOW0E\nE92VzQs1/fXGx7CFo9e41sngRRA5WWAdaAkx37P6meYXwHiYqO+q8+1rO0rbW54g\nw7Rd3AMFAgMBAAECggEAEmlKIbmhCGFq2aVblWDpcjH8iGfbE0lJisXWGuhVCl/p\njl+Cz2oo4KLkdd0KsIM13G/pcmCe4+lUr5s3s4sX+MCa5USkK6hiIijQurBLHGxn\nhAjHEslkqijC+0TVOXXyQn78PTH6OzPS5nYSB7RK/Uoh7ma9S36rIcpBBNLkGz21\nRN0JixPQl2UfJC2b+XQIbJDH3OEdI2FwpHKqPcelShNFeHpFYQp214EWetv76Wxr\nIdZUxH/Qaa2jZx4t0yNRuZLxuL0hHGn5nAnUqrcZtnxF1mljXnnioimrmx3I3+mk\nkwwD/dDI12w2ZJbhVkDcreTscwflbJ8TcNqYivYwSQKBgQDrL4IYQpefXeuDEGOR\nExxDpF9Ks74j8GtFak6pBwC1iOilRkwSMTTSB215KS/fkCNn5z7DIQFK/jezUQ6F\nFlmaXopseuYZcbq0LJg6JFJSm2VHWiz0hAd7IUwrsRgks2/XpyaN+a2I2yirqWbd\nG0TdgZFj4Z8Og6K96cVFHjtZ3QKBgQDhI8aeL3UsPUYsgRvbCsHbhdk484sbJcQe\na7DvSLwIwTiOvadRRDO3m4OD8Ses06EpJUCzqaBfHFypYJDMVD2h8Yj6GmoGTQOm\n/e09zyguXrghh/degmq8lT8KUgBH5fLQlenCJCP3Lb7i9bc+vPUB0Kv4fFTlRJQR\nDFlwyvo/SQKBgFsVAhgtKhVhRUV0Amt78DVOIk2HAPtgL9spSZ9yg9bKV/cyG2Hs\nRp2UnNQQnGbDpsKlrwvY62xEugOrP6lRN5BuTsOmcRinj/wZTTcvO+acIgQZK1Hj\nFBaelaZSJpyIFad6J5dSe9+FqOGacKju16PFey4ogfYYCt3r/CdBhxDNAoGBANyI\nctIYoqpHCyok/eg+TU5/ehxzU9uvzsANtS9vC+F3g7Muy2qraA1+ZAEmhDqiwsbP\nGuXiTplb6thvIudDzWuIcSisHxc08VLugSl+dlmVpsARs5n8HhnECBBP6r6C3Kq9\nblEhnalOQiGHl4v5A/ZXNV0eTPqXhoJ8mlAGQ8MhAoGATpiRyzMsQ6l2oN21PDOU\nu4qBKUCnGYEdcoWlPcCQW4QSLuINN7wgV382O7XLBOOMKqtTuY8/2Z5M7cWdXcuN\ne7XS3nMgDYDD1B6dwwRuhTFzpjQP0gm7TPIJruJyjpSsXMRVs3oBPDgNUBTl0QXl\nwibii+f/n2FaOC6Sju2Y6DM=\n-----END PRIVATE KEY-----\n"; // استبدلها بمفتاح الخادم الخاص بـ FCM
      final url = Uri.parse(
          'https://fcm.googleapis.com/v1/projects/215436311561/messages:send');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      };
      final body = jsonEncode({
        'to': userToken,
        'notification': {
          'title': 'SOS Alert',
          'body': 'An emergency request was sent!',
        },
        'priority': 'high',
      });

      final response = await http.post(url, headers: headers, body: body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }

    String? token;
    Future<void> getToken() async {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      // Request permission for notifications (iOS-specific)
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // Get the FCM token
        token = await messaging.getToken();
        print("FCM Token: $token");
      } else {
        print("User denied permission");
      }
    }

    return Scaffold(
        backgroundColor: Color(0xffF7E8DA),
        appBar: AppBar(
          title: TextDefaultWidget(title: "Contact"),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TextDefaultWidget(title: "Contact User"),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        ToastHelper.showSuccess(message: "Help");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    friendEmail:
                                        con.auth.currentUser?.email ?? "")));
                      },
                      child: Card(
                        color: KColors.KBtn2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 10.h),
                          child: TextDefaultWidget(
                            title: "Help",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        FirebaseFirestore fire = FirebaseFirestore.instance;
                        String targetEmail =
                            "user@gmail.com"; // Target user email
                        try {
                          // Fetch the user document based on email
                          DocumentSnapshot userDoc = await fire
                              .collection("users")
                              .doc(targetEmail)
                              .get();

                          if (userDoc.exists) {
                            Map<String, dynamic>? userData =
                                userDoc.data() as Map<String, dynamic>?;

                            if (userData != null &&
                                userData.containsKey("token") &&
                                userData.containsKey("userId")) {
                              String fcmToken = userData["token"];
                              String userId = userData["userId"];
                              // Send notification dynamically
                              NotificationsHelper().sendNotifications(
                                fcmToken: fcmToken, // Dynamic FCM Token
                                title: "Sos Notification",
                                body: "Sos Busy Now",
                                userId: userId, // Dynamic User ID
                              );
                            } else {
                              print(
                                  "Error: Required fields (token/userId) are missing in Firestore.");
                            }
                          } else {
                            print(
                                "Error: User document does not exist in Firestore.");
                          }
                        } catch (e) {
                          print("Error retrieving user data: $e");
                        }
                      },
                      child: Card(
                        color: KColors.KBtn2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 10.h),
                          child: TextDefaultWidget(
                            title: "Busy",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
