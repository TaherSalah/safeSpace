// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/core/Shared/shared_preferances.dart';
import 'package:safeSpace/core/Utilities/toast_helper.dart';

import '../../core/Utilities/router.dart';

class LoginController extends ControllerMVC {
  // factory LoginController() {
  //   _this ??= LoginController._();
  //   return _this!;
  // }

  // static LoginController? _this;
  // LoginController._();
  factory LoginController([StateMVC? state]) =>
      _this ??= LoginController._(state);
  LoginController._(super.state);

  static LoginController? _this;

  bool loading = false, rememberMe = false, acceptTerms = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final loginFormKey = GlobalKey<FormState>();
  String? errorMessage;
  bool isVisible = false;
  int role = 2;


  Future<void> login(BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        // Create a user object
        Map<String, dynamic> userData = {
          "uid": userCredential.user?.uid,
          "email": userCredential.user?.email,
          "displayName": userCredential.user?.displayName,
          "photoURL": userCredential.user?.photoURL,
        };

        // Save user object to SharedPreferences
        await SharedPref.saveUserObj(userData);

        // Check if the user is an emergency user
        bool isEmergencyUser = userCredential.user?.email == "user2@yahoo.com";
        await SharedPref.saveIsEmergencyUser(isEmergencyUser);
        // Navigate to the main screen
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
        SharedPref.saveIsUserLogin(true);
        print('Login successful: ${userCredential.user?.email}');
        ToastHelper.showSuccess(message: "Login successful");

      }
    } on FirebaseAuthException catch (e) {
      ToastHelper.showError(message: e.message.toString());
      setState(() {
        errorMessage = e.message ?? 'An error occurred';
      });
      print('Error: ${e.message}');
    }
  }
  
  Future<void> signOut(BuildContext context) async {
   return await _auth.signOut();
  }

  // Update password visibility toggle
  void toggleVisiblePassword() {
    setState(() {
      isVisible = !isVisible;
    });
  }
  Future<void> sendMessage(String chatId, String text, String receiverId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final messageData = {
      "senderId": user.uid,
      "receiverId": receiverId,
      "text": text,
      "timestamp": FieldValue.serverTimestamp()
    };

    await FirebaseFirestore.instance
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .add(messageData);

    // Update last message in chat document
    await FirebaseFirestore.instance.collection("chats").doc(chatId).set({
      "lastMessage": text,
      "timestamp": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }


  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }



}


