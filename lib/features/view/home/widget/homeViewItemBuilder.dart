import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_space_app/core/Widgets/default_text_widget.dart';

class HomeViewItemBuilder extends StatelessWidget {
  const HomeViewItemBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
            child: Image.asset("assets/images/menu.png"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: RichText(
              text: TextSpan(
                text: 'Welcome back, ',
                style: TextStyle(
                    color: Colors.black, fontSize: 20.sp), // Default text style
                children: <TextSpan>[
                  TextSpan(
                    text: 'Sarina!',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          CardItemBuilderWidget(
              title: "Monitor heartbeat rate",
              iconPath: "assets/images/Vector.png"),
          CardItemBuilderWidget(
              title: "Breathing techniques",
              iconPath: "assets/images/Meditation.png"),
          CardItemBuilderWidget(
              title: "Ai assistsant",
              iconPath: "assets/images/Meetup Icon.png"),
        ],
      ),
    );
  }
}

class CardItemBuilderWidget extends StatelessWidget {
  const CardItemBuilderWidget(
      {super.key, required this.title, required this.iconPath});
  final String title, iconPath;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.sp),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Color(0xffFCDDEC)),
        child: Row(
          children: [
            TextDefaultWidget(
              title: title,
              color: Colors.black,
              fontSize: 20.sp,
            ),
            Spacer(),
            Expanded(
              child: SizedBox(
                height: 55,
                width: 60,
                child: Image.asset(iconPath),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
