import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/core/Utilities/router.dart';
import 'package:safeSpace/core/Utilities/toast_helper.dart';
import 'package:safeSpace/core/Widgets/default_text_widget.dart';
import 'package:safeSpace/features/viewModel/login_controllar.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  SettingsViewState createState() => SettingsViewState();
}

class SettingsViewState extends StateMVC<SettingsView> {
  late LoginController con;

  SettingsViewState() : super(LoginController()) {
    con = controller as LoginController;
    ();
    // con.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7E8DA),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              con.signOut(context);
              Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
              ToastHelper.showSuccess(message: "sign out  successful");
            },
            child: Card(
              elevation: 5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
                child: Row(
                  children: [
                    TextDefaultWidget(title: "logout"),
                    Spacer(),
                    Icon(Icons.logout)
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
