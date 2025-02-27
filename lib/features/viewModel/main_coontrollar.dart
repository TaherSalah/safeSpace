import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safe_space_app/features/view/emergency/emergencyView.dart';
import 'package:safe_space_app/features/view/home/homeView.dart';
import 'package:safe_space_app/features/view/sound/soundView.dart';

class MainController extends ControllerMVC {
  int currentIndex = 0;
  List<Widget> screens = [
    HomeView(),
    EmergencyView(),
    SoundView(),
    HomeView(),
  ];

  void changeScreens({required int index}) {
    setState(() {
      currentIndex = index;
    });
  }
}
