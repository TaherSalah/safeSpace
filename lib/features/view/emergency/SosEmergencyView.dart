import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/features/view/emergency/emergencyView.dart';
import 'package:safeSpace/features/view/home/widget/homeViewItemBuilder.dart';
import 'package:safeSpace/features/viewModel/home_controllar.dart';

class SosEmergencyView extends StatefulWidget {
  const SosEmergencyView({super.key});

  @override
  SosEmergencyViewState createState() => SosEmergencyViewState();
}

class SosEmergencyViewState extends StateMVC<SosEmergencyView> {
  late HomeController con;

  SosEmergencyViewState() : super(HomeController()) {
    con = controller as HomeController;
    ();
    con.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF7E8DA),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardItemBuilderWidget(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                friendEmail: con.emailController.text ?? ""),
                          ));
                    },
                    title: "Help your friend",
                    iconPath: "assets/images/Message circle.png"),
                CardItemBuilderWidget(
                    onTap: () async {
                      await con.launchURL(
                          latitude: con.latitude, longitude: con.longitude);
                    },
                    title: "View friend location",
                    iconPath: "assets/images/location_on@2x.png"),
              ],
            ),
          ),
        ));
  }
}
