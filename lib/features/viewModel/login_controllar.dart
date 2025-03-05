// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/core/Shared/shared_preferances.dart';

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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
        Navigator.pushNamed(context, Routes.mainRoute);
        SharedPref.saveIsUserLogin(true);
        print('Login successful: ${userCredential.user?.email}');
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'An error occurred';
      });
      print('Error: ${e.message}');
    }
  }

  // Update password visibility toggle
  void toggleVisiblePassword() {
    setState(() {
      isVisible = !isVisible;
    });
  }
}
