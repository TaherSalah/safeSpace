// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends ControllerMVC {

  factory HomeController([StateMVC? state]) =>
      _this ??= HomeController._(state);
  HomeController._(super.state);

  static HomeController? _this;

  bool loading = false, rememberMe = false, acceptTerms = false;
FirebaseAuth auth =FirebaseAuth.instance;
  final key = GlobalKey<FormState>();
  final DatabaseReference database = FirebaseDatabase.instance.ref();
  String date = "Loading...";
  String gps = "Loading...";
  String time = "Loading...";
  int BPM = 0;
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void dispose() {
    super.dispose();
  }
  void fetchData() {
    database.child("date").onValue.listen((event) {
      setState(() {
        date = event.snapshot.value.toString();
      });
    });
    database.child("time").onValue.listen((event) {
      setState(() {
        time = event.snapshot.value.toString();
      });
    });
    database.child("gps").onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        setState(() {
          latitude = data["Latitude"] ?? 0.0;
          longitude = data["Longitude"] ?? 0.0;
        });
      }
    });
    database.child("pulse_sensor").onValue.listen((event) {
      setState(() {
        final pulseData = event.snapshot.value as Map<dynamic, dynamic>?;
        if (pulseData != null) {
          BPM = pulseData['BPM'];
          setState(() {});
        }
      });
    });
  }
  void saveFCMToken() async {
    String? email = auth.currentUser?.email;
    String? token = await FirebaseMessaging.instance.getToken();

    if (email != null && token != null) {
      await FirebaseFirestore.instance.collection("users").doc(email).set({
        "fcmToken": token,
      }, SetOptions(merge: true));
    }
  }

  Future<void> sendPushNotification(String token, String title, String body) async {
    try {
      String serverKey = "YOUR_SERVER_KEY"; // Get this from Firebase Cloud Messaging settings

      var response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "key=$serverKey",
        },
        body: jsonEncode({
          "to": token,
          "notification": {
            "title": title,
            "body": body,
            "sound": "default",
          },
          "priority": "high",
        }),
      );

      if (response.statusCode == 200) {
        print("Notification Sent Successfully");
      } else {
        print("Failed to send notification: ${response.body}");
      }
    } catch (e) {
      print("Error sending notification: $e");
    }
  }

}
