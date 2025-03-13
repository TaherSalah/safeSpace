import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safeSpace/core/Shared/shared_preferances.dart';
import 'package:safeSpace/core/Utilities/k_color.dart';
import 'package:safeSpace/core/Utilities/router.dart';
import 'package:safeSpace/core/Widgets/default_text_widget.dart';

import '../../../../core/Widgets/custom_button_widget.dart';

class OnboardingItemBuilder extends StatelessWidget {
  const OnboardingItemBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        SizedBox(height: 15),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: SizedBox(),
            ),
            // This non-positioned child gives the Stack finite height.
            SizedBox(height: 400),
            Positioned(
              top: 150,
              left: -100,
              child: Image.asset(
                "assets/images/BG Circle.png",
                color: Color(0xffFCDDEC),
              ),
            ),
          ],
        ),
        Center(
          child: Image.asset(height: 150.h, "assets/images/logoJp.jpg"),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Center(
                child: TextDefaultWidget(
                  title: "Let Us Help You",
                  fontWeight: FontWeight.w600,
                  FontFamily: "Medium",
                  fontSize: 25,
                  color: KColors.KScondary,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 35),
          width: MediaQuery.sizeOf(context).width / 1.7,
          child: CustomButton(
            verticalPadding: 20,
            borderColor: KColors.KBtn,
            radius: 9.r,
            title: "Login",
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            backgroundColor: KColors.KBtn,
            onTap: () async {
              Navigator.pushNamed(context, Routes.loginRoute);
              SharedPref.saveIsEmergencyUser(false);
            },
          ),
        ),
      ],
    );
  }
}
