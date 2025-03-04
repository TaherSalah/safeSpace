import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_space_app/features/view/contactUser/emergencyView.dart';
import 'package:safe_space_app/features/view/home/widget/homeViewItemBuilder.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyView extends StatelessWidget {
  const EmergencyView({super.key});

  @override
  Widget build(BuildContext context) {
    String url({required String longitude, latitude}) =>
        //       //  طول//
        "https://www.google.com/maps/place/$latitude,$longitude";

    Future<void> _launchURL() async {
      Uri uri = Uri.parse(url(longitude: "31.32288", latitude: "30.31141"));
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw "Could not launch $url";
      }
    }

    return Scaffold(
        body: SafeArea(
      child: Padding(
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
              child: SizedBox(
                height: 35.h,
                child: Image.asset("assets/images/User plus.png"),
              ),
            ),
            CardItemBuilderWidget(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactView(),
                      ));
                },
                title: "Contact with Taher Salah",
                iconPath: "assets/images/Message circle.png"),
            CardItemBuilderWidget(
                onTap: () async {
                  await _launchURL();
                  print("object");
                },
                title: "Breathing techniques",
                iconPath: "assets/images/location_on@2x.png"),
          ],
        ),
      ),
    ));
  }
}
