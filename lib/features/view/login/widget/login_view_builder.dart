import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/core/Utilities/k_color.dart';
import 'package:safeSpace/core/Widgets/custom_button_widget.dart';
import 'package:safeSpace/core/Widgets/custom_textfeild_widget.dart';
import 'package:safeSpace/core/Widgets/default_text_widget.dart';
import 'package:safeSpace/features/viewModel/login_controllar.dart';

class LoginViewBuilder extends StatefulWidget {
  const LoginViewBuilder({super.key});

  @override
  _LoginViewBuilderState createState() => _LoginViewBuilderState();
}

class _LoginViewBuilderState extends StateMVC<LoginViewBuilder> {
  /// Let the 'business logic' run in a Controller
  _LoginViewBuilderState() : super(LoginController()) {
    /// Acquire a reference to the passed Controller.
    con = controller as LoginController;
  }
  late LoginController con;

  @override
  void initState() {
    super.initState();
    // Ensure appState is initialized before using it
    if (rootState != null) {
      appState = rootState!;
      var con = appState.controller;
      // Retrieve the correct controller by type or ID
      con = appState.controllerByType<LoginController>();
      con = appState.controllerById(con?.keyId);
    } else {
      // Handle the case where rootState is not initialized
      print('rootState is null');
    }
  }

  late AppStateMVC appState;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: con.loginFormKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 50.h),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextDefaultWidget(
                  fontSize: 18.sp,
                  title: "Login",
                  fontWeight: FontWeight.bold,
                  color: KColors.darkerColor,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            CustomTextFieldWidget(
              controller: con.emailController,
              validator: (val) {
                if (val!.trim().isEmpty) {
                  return "please enter your email ";
                } else {
                  return null;
                }
              },
              backGroundColor: Theme.of(context).cardColor,
              label: "email",
              prefixIcon: Icon(
                FontAwesomeIcons.user,
                size: 14.sp,
              ),
              hint: "enter your Email",
              borderRadiusValue: 15,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: 15.h),
            CustomTextFieldWidget(
              backGroundColor: Theme.of(context).cardColor,
              label: "password",
              prefixIcon: Icon(
                FontAwesomeIcons.lock,
                size: 14.sp,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  con.toggleVisiblePassword();
                },
                icon: con.isVisible
                    ? Icon(
                        Icons.visibility,
                        size: 18.sp,
                      )
                    : Icon(
                        Icons.visibility_off,
                        size: 18.sp,
                      ),
              ),
              validator: (val) {
                if (val!.trim().isEmpty) {
                  return "please enter your password";
                } else {
                  return null;
                }
              },
              controller: con.passwordController,
              hint: "enter your Password",
              borderRadiusValue: 15,
              obscure: !con.isVisible,
              textInputType: TextInputType.visiblePassword,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.sizeOf(context).width / 1.5,
              child: CustomButton(
                verticalPadding: 12.h,
                borderColor: KColors.KBtn,
                radius: 9.r,
                title: "Login",
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                backgroundColor: KColors.KBtn,
                onTap: () async {
                  if (con.loginFormKey.currentState!.validate()) {
                    // You can add your login logic here
                    con.login(context);
                    print("object");
                  }
                  // Navigator.pushNamed(context, Routes.mainRoute);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
