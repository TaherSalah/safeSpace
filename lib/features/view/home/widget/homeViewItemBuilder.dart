import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:safeSpace/core/Utilities/router.dart';
import 'package:safeSpace/core/Widgets/default_text_widget.dart';
import 'package:safeSpace/features/viewModel/home_controllar.dart';

class HomeViewItemBuilder extends StatefulWidget {
  const HomeViewItemBuilder({super.key});

  @override
  HomeViewItemBuilderState createState() => HomeViewItemBuilderState();
}

class HomeViewItemBuilderState extends StateMVC<HomeViewItemBuilder> {
  late HomeController con;

  HomeViewItemBuilderState() : super(HomeController()) {
    con = controller as HomeController;
    ();
    con.fetchData();
  }
  @override
  Widget build(BuildContext context) {
    print("con ${con.BPM}");

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            onTap: () {
              Navigator.pushNamed(context, Routes.monitorHeartView,
                  arguments: con.BPM);
            },
            title: "Monitor heartbeat rate",
            iconPath: "assets/images/Vector.png",
          ),
          CardItemBuilderWidget(
              title: "Ai assistsant",
              onTap: () {
                Navigator.pushNamed(context, Routes.chatRoute);
              },
              iconPath: "assets/images/Meetup Icon.png"),
        ],
      ),
    );
  }
}

class CardItemBuilderWidget extends StatelessWidget {
  const CardItemBuilderWidget(
      {super.key, required this.title, required this.iconPath, this.onTap});
  final String title, iconPath;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.sp),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Color(0xffEF5DA8)),
          child: Row(
            spacing: 50,
            children: [
              TextDefaultWidget(
                title: title,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
              Spacer(),
              SizedBox(
                height: 49,
                width: 50,
                child: Image.asset(
                  iconPath,
                  color: Color(0xffFFD0Df), //  change shape color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
