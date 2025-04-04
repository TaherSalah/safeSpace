import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/features/viewModel/main_coontrollar.dart';

import '../../../core/Shared/shared_preferances.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => _MainViewBuilderState();
}

class _MainViewBuilderState extends StateMVC<MainView> {
  /// Let the 'business logic' run in a Controller
  _MainViewBuilderState() : super(MainController()) {
    /// Acquire a reference to the passed Controller.
    con = controller as MainController;
  }
  late MainController con;

  @override
  void initState() {
    super.initState();
    // Ensure appState is initialized before using it
    if (rootState != null) {
      appState = rootState!;
      var con = appState.controller;
      // Retrieve the correct controller by type or ID
      con = appState.controllerByType<MainController>();
      con = appState.controllerById(con?.keyId);
    } else {
      // Handle the case where rootState is not initialized
      print('rootState is null');
    }
  }

  late AppStateMVC appState;
  @override
  Widget build(BuildContext context) {
    con.getUserDetails();
    return Scaffold(
      backgroundColor: Color(0xffF7E8DA),
      bottomNavigationBar: BottomNavigationBarWidget(
        onTap: (index) {
          con.changeScreens(index: index);
        },
        currentIndex: con.currentIndex,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(width: 70, child: Image.asset("assets/images/logoJp.jpg")),
            Expanded(
              // ✅ This prevents overflow
              child: con.screens != null
                  ? con.screens![con.currentIndex]
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget(
      {super.key, required this.onTap, required this.currentIndex});

  final void Function(int)? onTap;
  final int currentIndex;

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return BottomNavigationBar(
      items: (user?.email == "user@gmail.com" ||
              SharedPref.getIsEmergencyUser() == false)
          ? <BottomNavigationBarItem>[
              _buildNavItem(
                  "assets/images/noun_Home_2976614.png", 0, 22.h, 22.w, false),
              _buildNavItem(
                  "assets/images/Message circle.png", 1, 22.h, 22.w, false),
              _buildNavItem("assets/images/image-removebg-preview (1).png", 2,
                  30.h, 30.w, false),
              _buildNavItem("assets/images/settings.png", 3, 32.h, 32.w, false),
            ]
          : <BottomNavigationBarItem>[
              _buildNavItem(
                  "assets/images/noun_Home_2976614.png", 0, 22.h, 22.w, false),
              _buildNavItem(
                  "assets/images/Message circle.png", 1, 22.h, 22.w, false),
              _buildNavItem("assets/images/settings.png", 3, 32.h, 32.w, false),
            ],
      currentIndex: widget.currentIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: const Color(0xffCDD0E3),
      type: BottomNavigationBarType.fixed,
      unselectedFontSize: 10.sp,
      selectedFontSize: 10.sp,
      onTap: widget.onTap,
    );
  }

  BottomNavigationBarItem _buildNavItem(
      String assetPath, int index, double height, double width, bool? isIcon) {
    bool isSelected = widget.currentIndex == index;
    return BottomNavigationBarItem(
      backgroundColor: Theme.of(context).cardColor,
      icon: ColorFiltered(
        colorFilter: ColorFilter.mode(
          isSelected ? Colors.black : const Color(0xffCDD0E3),
          BlendMode.srcIn,
        ),
        child: SizedBox(
            width: width,
            height: height,
            child: isIcon == true
                ? Icon(Icons.music_note, size: 35, color: Color(0xffCDD0E3))
                : Image.asset(assetPath)),
      ),
      label: "",
    );
  }
}
