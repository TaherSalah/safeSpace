import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/core/Utilities/k_color.dart';
import 'package:safeSpace/core/Utilities/toast_helper.dart';
import 'package:safeSpace/core/Widgets/default_text_widget.dart';
import 'package:safeSpace/features/view/emergency/emergencyView.dart';
import 'package:safeSpace/features/view/home/widget/homeViewItemBuilder.dart';
import 'package:safeSpace/features/viewModel/home_controllar.dart';
import 'package:http/http.dart' as http;
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
    // con.fetchData();
  }

  @override
  Widget build(BuildContext context) {
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
    Future<void> sendPushMessage(
        {required String fcmToken, required String title, required String body}) async {
      try {
        final response = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=YOUR_SERVER_KEY',
          },
          body: jsonEncode(
            {
              "to": fcmToken,
              "notification": {
                "title": title,
                "body": body,
                "sound": "default"
              },
              "data": {
                "click_action": "FLUTTER_NOTIFICATION_CLICK",
                "customKey": "customValue"
              }
            },
          ),
        );

        print("Response: ${response.body}");
      } catch (e) {
        print("Error sending notification: $e");
      }
    }
    return Scaffold(
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
//                   onTap: () {
//                     ToastHelper.showSuccess(message: "Help");
//                     sendPushMessage(fcmToken: token.toString(),title: "test fcm",body: "test body");
// Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(friendEmail: con.auth.currentUser?.email??"")));
//                   },
                  onTap: () async {
                    ToastHelper.showSuccess(message: "Busy");

                    // Ensure token is retrieved before proceeding
                    await getToken();
                    if (token == null) {
                      print("Error: FCM Token not retrieved");
                      return;
                    }

                    // Add 'Busy' status to Firestore
                    await FirebaseFirestore.instance.collection("sosRequest").add({
                      "isBusy": "true"
                    });

                    try {
                      // Fetch the user document
                      DocumentSnapshot userDoc = await FirebaseFirestore.instance
                          .collection("users")
                          .doc("user@gmail.com")
                          .get();

                      if (!userDoc.exists) {
                        print("Error: User document does not exist!");
                        return;
                      }

                      String? fcmToken = userDoc.get("fcmToken");

                      if (fcmToken != null && fcmToken.isNotEmpty) {
                        await sendPushMessage(fcmToken: fcmToken, title: "SOS Alert", body: "User is busy!");
                      } else {
                        print("Error: FCM Token not found for user!");
                      }
                    } catch (e) {
                      print("Error fetching user document: $e");
                    }
                  },

                  child: Card(
                    color: KColors.KBtn2,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
                      child: TextDefaultWidget(title: "Help",fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
                InkWell(
                  // onTap: () async {
                  //   ToastHelper.showSuccess(message: "Busy");
                  //
                  //   await FirebaseFirestore.instance.collection("sosRequest").add({
                  //     "isBusy": "true"
                  //   });
                  //
                  //   // Fetch the FCM token of the target user
                  //   DocumentSnapshot userDoc = await FirebaseFirestore.instance
                  //       .collection("users")
                  //       .doc("user@gmail.com")
                  //       .get();
                  //
                  //   String? fcmToken = userDoc.get("fcmToken");
                  //
                  //   if (fcmToken != null) {
                  //     con.sendPushNotification(fcmToken, "SOS Alert", "User is busy!");
                  //   }
                  // },
                  onTap: () async {
                    ToastHelper.showSuccess(message: "Busy");
                    await   getToken();
                    await FirebaseFirestore.instance.collection("sosRequest").add({
                      "isBusy": "true"
                    });

                    // Fetch the user document
                    DocumentSnapshot userDoc = await FirebaseFirestore.instance
                        .collection("users")
                        .doc("user@gmail.com")
                        .get();

                    if (!userDoc.exists) {
                      print("User document does not exist!");
                      return; // Exit if document does not exist
                    }

                    String? fcmToken = userDoc.get("fcmToken");

                    if (fcmToken != null) {
                      con.sendPushNotification(fcmToken, "SOS Alert", "User is busy!");
                    } else {
                      print("FCM Token not found for user!");
                    }
                  },

                  child: Card(
                    color: KColors.KBtn2,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
                      child: TextDefaultWidget(title: "Busy",fontWeight: FontWeight.bold,),
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
