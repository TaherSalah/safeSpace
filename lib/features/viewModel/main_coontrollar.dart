import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safe_space_app/features/view/emergency/emergencyView.dart';
import 'package:safe_space_app/features/view/emergencyUser/emergencyUser.dart';
import 'package:safe_space_app/features/view/home/homeView.dart';
import 'package:safe_space_app/features/view/settinges/SettingsView.dart';
import 'package:safe_space_app/features/view/sound/soundView.dart';

import '../../core/Shared/shared_preferances.dart';

class MainController extends ControllerMVC {
  int currentIndex = 0;

  List<Widget> screens = SharedPref.getIsEmergencyUser() == true
      ? [
          EmergencyUser(),
          EmergencyView(),
          SettingsView(),
        ]
      : [
          HomeView(),
          EmergencyView(),
          SoundView(),
          SettingsView(),
        ];

  void changeScreens({required int index}) {
    setState(() {
      currentIndex = index;
    });
  }

  Future<void> getUserDetails() async {
    Map<String, dynamic>? user = await SharedPref.getUserObj();
    if (user != null) {
      print('User Email: ${user["email"]}');
      print('User UID: ${user["uid"]}');
    } else {
      print('No user data found');
    }
  }
}
