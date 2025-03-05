import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/features/view/emergency/emergencyView.dart';
import 'package:safeSpace/features/view/emergencyUser/emergencyUser.dart';
import 'package:safeSpace/features/view/home/homeView.dart';
import 'package:safeSpace/features/view/settinges/SettingsView.dart';
import 'package:safeSpace/features/view/sound/soundView.dart';

import '../../core/Shared/shared_preferances.dart';

class MainController extends ControllerMVC {
  int currentIndex = 0;
  FirebaseAuth auth = FirebaseAuth.instance;
  String email = ""; // Initialize email as empty string initially
  late List<Widget> screens;

  MainController() {
    _initializeScreens(); // Initialize screens after the object is created
  }

  // Method to initialize screens based on the user's email
  void _initializeScreens() async {
    await getUserDetails(); // Fetch user details asynchronously
    screens =
    // SharedPref.getIsEmergencyUser() == true
    auth.currentUser?.email == "sos@gmail.com"
        ? [
      EmergencyUser(),
      EmergencyView(),
      SettingsView(),
    ]
        : [
      HomeView(),
      EmergencyView(),
      // ChatScreen(chatId: '1',),
      SoundView(),
      SettingsView(),
    ];
    setState(() {}); // Trigger the UI to rebuild after initialization
  }

  Future<void> getUserDetails() async {
    Map<String, dynamic>? user = await SharedPref.getUserObj();
    if (user != null) {
      email = user["email"];
      print('User Email: $email');
      print('User UID: ${user["uid"]}');
    } else {
      print('No user data found');
    }
  }

  void changeScreens({required int index}) {
    setState(() {
      currentIndex = index;
    });
  }
}

class ChatMessage {
  final String senderId;
  final String receiverId;
  final String text;
  final Timestamp timestamp;

  ChatMessage({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timestamp,
  });

  // Convert data to a map for Firebase storage
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timestamp': timestamp,
    };
  }

  // Create a ChatMessage instance from Firebase data
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      text: map['text'],
      timestamp: map['timestamp'],
    );
  }
}


