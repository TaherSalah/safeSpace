import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safe_space_app/features/viewModel/main_coontrollar.dart';

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
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(
        onTap: (index) {
          con.changeScreens(index: index);
        }, currentIndex: con.currentIndex,
      ),
      body: con.screens[con.currentIndex],
    );

  }
}


class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key, required this.onTap, required this.currentIndex});

  final void Function(int)? onTap;
  final int currentIndex;

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        _buildNavItem("assets/images/noun_Home_2976614.png", 0,22.h,22.w),
        _buildNavItem("assets/images/Message circle.png", 1,22.h,22.w),
        _buildNavItem("assets/images/noun_users_847316 2.png", 2,22.h,22.w),
        _buildNavItem("assets/images/settings.png", 3,32.h,32.w),
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

  BottomNavigationBarItem _buildNavItem(String assetPath, int index,double height,double width) {
    bool isSelected = widget.currentIndex == index;
    return BottomNavigationBarItem(

      backgroundColor: Theme.of(context).cardColor,
      icon: ColorFiltered(
        colorFilter: ColorFilter.mode(

          isSelected ? Colors.black : const Color(0xffCDD0E3),
          BlendMode.srcIn,
        ),
        child: SizedBox(width: width, height:height, child: Image.asset(assetPath)),
      ),
      label: "",
    );
  }
}
