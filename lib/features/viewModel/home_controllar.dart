// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safe_space_app/core/Shared/shared_preferances.dart';

import '../../core/Utilities/router.dart';

class HomeController extends ControllerMVC {
  // factory HomeController() {
  //   _this ??= HomeController._();
  //   return _this!;
  // }

  // static HomeController? _this;
  // HomeController._();
  factory HomeController([StateMVC? state]) =>
      _this ??= HomeController._(state);
  HomeController._(super.state);

  static HomeController? _this;

  bool loading = false, rememberMe = false, acceptTerms = false;

  final key = GlobalKey<FormState>();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
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
    _database.child("date").onValue.listen((event) {
      setState(() {
        date = event.snapshot.value.toString();
      });
    });
    _database.child("time").onValue.listen((event) {
      setState(() {
        time = event.snapshot.value.toString();
      });
    });
    _database.child("gps").onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        setState(() {
          latitude = data["Latitude"] ?? 0.0;
          longitude = data["Longitude"] ?? 0.0;
        });
      }
    });
    _database.child("pulse_sensor").onValue.listen((event) {
      setState(() {
        final pulseData = event.snapshot.value as Map<dynamic, dynamic>?;
        if (pulseData != null) {
          BPM = pulseData['BPM'];
          setState(() {});
        }
      });
    });
  }

}
