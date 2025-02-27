import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safe_space_app/features/view/home/homeView.dart';

class MainController extends ControllerMVC {



   int currentIndex =0;
  List<Widget>screens=[
    HomeView(),
    HomeView(),
    HomeView(),
    HomeView(),

  ];

  void changeScreens({required int index}){
    setState((){
      currentIndex = index;

    });
  }
}