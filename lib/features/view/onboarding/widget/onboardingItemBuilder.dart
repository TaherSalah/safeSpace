import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_space_app/core/Utilities/k_color.dart';
import 'package:safe_space_app/core/Utilities/router.dart';
import 'package:safe_space_app/core/Widgets/default_text_widget.dart';

import '../../../../core/Widgets/custom_button_widget.dart';

class OnboardingItemBuilder extends StatelessWidget {
  const OnboardingItemBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: TextDefaultWidget(
                title: "SafeSpace",
                fontWeight: FontWeight.bold,
                FontFamily: "Bold",
                fontSize: 37,
                color: Colors.black,
              ),
            ),
            // This non-positioned child gives the Stack finite height.
            SizedBox(
              height: 400, // Adjust the height to fit your design needs.
            ),
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
        Spacer(),
        Column(
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
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
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
            },
          ),
        ),
      ],
    );
  }
}
