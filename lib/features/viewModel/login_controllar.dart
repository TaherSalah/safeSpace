// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

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
  // final _auth = FirebaseAuth.instance;
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

  // login(BuildContext context) {
  //   // You can add your login logic here
  //   print(
  //       "Login attempt with email: ${loginEmailController.text} and password: ${loginPasswordController.text}");
  // }
  // Method to handle login
  Future<void> login() async {
    // try {
    //   // Attempt to sign in with email and password
    //   UserCredential userCredential = await _auth.signInWithEmailAndPassword(
    //     email: emailController.text,
    //     password: passwordController.text,
    //   );
    //
    //   // Handle successful login
    //   if (userCredential.user != null) {
    //     // Navigate to home screen or another page
    //     // Navigator.pushReplacementNamed(context, '/home');
    //     print('Login successful: ${userCredential.user?.email}');
    //   }
    // } on FirebaseAuthException catch (e) {
    //   // Handle errors
    //   setState(() {
    //     errorMessage = e.message ?? 'An error occurred';
    //   });
    //   print('Error: ${e.message}');
    // }
  }

  // Update password visibility toggle
  void toggleVisiblePassword() {
    setState(() {
      isVisible = !isVisible;
    });
  }
}
