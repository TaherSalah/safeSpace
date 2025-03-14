// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/core/Shared/shared_preferances.dart';
import 'package:safeSpace/core/Utilities/toast_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends ControllerMVC {
  factory HomeController([StateMVC? state]) =>
      _this ??= HomeController._(state);
  HomeController._(super.state);

  static HomeController? _this;
  TextEditingController emailController = TextEditingController();

  bool loading = false, rememberMe = false, acceptTerms = false;
  FirebaseAuth auth = FirebaseAuth.instance;
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

  String url({required String longitude, latitude}) =>
      "https://www.google.com/maps/place/$latitude,$longitude";
  Future<void> launchURL({dynamic latitude, longitude}) async {
    Uri uri = Uri.parse(url(longitude: "$longitude", latitude: "$latitude"));
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $url";
    }
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

  TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final loginFormKey = GlobalKey<FormState>();
  String? errorMessage;
  bool isVisible = false;

  Future<void> login(BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: "123456",
      );

      if (userCredential.user != null) {
        // Create a user object
        Map<String, dynamic> userData = {
          "uid": userCredential.user?.uid,
          "email": userCredential.user?.email,
          "displayName": userCredential.user?.displayName,
          "photoURL": userCredential.user?.photoURL,
        };
        await SharedPref.saveUserObj(userData);
        // bool isEmergencyUser = userCredential.user?.email == "user2@yahoo.com";
        // await SharedPref.saveIsEmergencyUser(isEmergencyUser);
        Navigator.pop(context);
        SharedPref.saveIsUserLogin(true);
        await saveUserToken();
        print('Login successful: ${userCredential.user?.email}');
      }
    } on FirebaseAuthException catch (e) {
      ToastHelper.showError(message: e.message.toString());
      setState(() {
        errorMessage = e.message ?? 'An error occurred';
      });
      print('Error: ${e.message}');
    }
  }

  Future<void> saveUserToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && token != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .set({'token': token, 'userId': user.uid}, SetOptions(merge: true));
    }
  }
}
