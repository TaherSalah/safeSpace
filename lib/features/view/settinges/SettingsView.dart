import 'package:flutter/material.dart';
import 'package:safe_space_app/core/Shared/shared_preferances.dart';
import 'package:safe_space_app/core/Utilities/router.dart';
import 'package:safe_space_app/core/Widgets/default_text_widget.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // backgroundColor: Color(0xffaeaff7),
      body: SafeArea(
          child: Column(
        children: [TextDefaultWidget(title: "SettingsView"),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
SharedPref.saveIsEmergencyUser(false);

          },
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 11),
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
