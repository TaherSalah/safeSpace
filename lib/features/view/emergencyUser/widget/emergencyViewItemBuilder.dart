import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safeSpace/core/Utilities/router.dart';
import 'package:safeSpace/core/Widgets/default_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyViewItemBuilder extends StatefulWidget {
  const EmergencyViewItemBuilder({super.key});

  @override
  State<EmergencyViewItemBuilder> createState() =>
      _EmergencyViewItemBuilderState();
}

class _EmergencyViewItemBuilderState extends State<EmergencyViewItemBuilder> {
  String url({required String longitude, latitude}) =>
      //       //  طول//
      "https://www.google.com/maps/place/$latitude,$longitude";

  Future<void> _launchURL() async {
    Uri uri = Uri.parse(url(longitude: "31.32288", latitude: "30.31141"));
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
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
              title: "Ai assistsant",
              onTap: () {
                Navigator.pushNamed(context, Routes.chatRoute);
              },
              iconPath: "assets/images/Meetup Icon.png"),
          CardItemBuilderWidget(
              onTap: () async {
                _launchURL;
                print("object");
              },
              title: "Panic attack guidelines",
              iconPath: "assets/images/BookOpen.png"),
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
              color: Color(0xffFCDDEC)),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: TextDefaultWidget(
                  title: title,
                  color: Colors.black,
                  fontSize: 20.sp,
                ),
              ),
              Spacer(),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 55,
                  width: 60,
                  child: Image.asset(iconPath),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
