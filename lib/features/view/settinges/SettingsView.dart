import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/core/Shared/shared_preferances.dart';
import 'package:safeSpace/core/Utilities/router.dart';
import 'package:safeSpace/core/Utilities/toast_helper.dart';
import 'package:safeSpace/core/Widgets/default_text_widget.dart';
import 'package:safeSpace/features/viewModel/home_controllar.dart';
import 'package:safeSpace/features/viewModel/login_controllar.dart';
import 'package:safeSpace/features/viewModel/main_coontrollar.dart';

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
      // backgroundColor: Color(0xffaeaff7),
      body: SafeArea(
          child: Column(
        children: [
          TextDefaultWidget(title: "SettingsView"),
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
