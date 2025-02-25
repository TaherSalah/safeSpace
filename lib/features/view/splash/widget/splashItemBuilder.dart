import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safespaceapp/core/Theme/theme.dart';
import 'package:safespaceapp/core/Widgets/default_text_widget.dart';

import '../../../../core/Widgets/custom_button_widget.dart';

class SplashItemBuilder extends StatelessWidget {
  const SplashItemBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 40,
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
        Container(
          child: Column(
            children: [
              Center(
                child: TextDefaultWidget(
                  title: "Let Us Help You",
                  fontWeight: FontWeight.bold,
                  FontFamily: "Bold",
                  fontSize: 37,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
            verticalPadding: 10,
            radius: 6.r,
            title: "Login",
            fontSize: 12.sp,
            backgroundColor: ThemeClass.blueLightColor,
            onTap: () async {
              // if (_registerFormKey.currentState!.validate()) {
              //   await register.register();
              // }
            },
          ),
        ),
      ],
    );
  }
}
