import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeClass {
  static Color primaryColor = const Color(0xffaeaff7);
  static Color accentColor = const Color(0xffE9C37);
  static Color whiteColor = const Color(0xffFFFFFF);
  static Color whiteDarkColor = const Color(0xffFAFBFA);
  static Color blackColor = const Color(0xff2a2a2a);
  static Color blackDarktColor = const Color(0xff191A1C);
  static Color greyColor = const Color(0xff292D32);
  static Color normalgreyColor = const Color(0xffB9B9B9);
  static Color greyLightColor = const Color(0xffF9F9F9);
  static Color greyLightColor2 = const Color(0xffe8e7e8);
  static Color greyDarkColor = const Color(0xff364356);
  static Color greyColorAccent = const Color(0xffFAFBFB);
  static Color messageGreyColor = const Color(0xffefefef);
  static Color blueColor = const Color(0xff22577A);
  static Color blueDarkColor = const Color(0xff031a40);
  static Color blueLightColor0 = const Color(0xff008ABF);
  static Color blueLightColor = const Color(0xff85c8ea);
  static Color blueLightColor2 = const Color(0xffc3dbf7);
  static Color blueLightColor4 = const Color(0xff84c6df);
  static Color blueLightColor5 = const Color(0xffb8deed);
  static Color blueLightColor6 = const Color(0xff6cbbe5);
  static Color blueLightColor7 = const Color(0xffb5ccf9);
  static Color blueLightColor3 = const Color(0xffdfeaef);
  static Color lightBlueColor = const Color(0xffDAEAF1);
  static Color yellowColor = const Color(0xffF0C929);
  static Color mustardColor = const Color(0xffFFCA28);
  static Color orangeColor = const Color(0xffff5f00);
  static Color brown = const Color(0xff886C4D);
  static Color lightYellowColor = const Color(0xffF4E06D);
  static Color hintColor = const Color(0xffF4E06D);
  static Color textFieldBackgroundColor = const Color(0xFFEDF8EC);
  static Color containerBackground = const Color(0xFFDDE9DC);
  static Color containerWBackground = const Color(0xFFFAF7EF);
  static Color backgroundAppBar = Colors.transparent;

  static LinearGradient gradientBtn = LinearGradient(
    colors: [
      primaryColor,
      const Color(0xff00B7A8),
      const Color(0xff10FFEA),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static LinearGradient screenGradient = const LinearGradient(
    colors: [
      Color(0xff42DEBF),
      // Color(0xff42DEBF),
      Color(0xff6CA5C2),
      Color(0xff4876B2),
      Color(0xff315FAA),
      // Color(0xffDaEcD8),
    ],
    // stops: [
    //   0.0,
    //   0.4,
    //   0.55,
    //   0.7,
    //   0.9,
    // ],
    begin: AlignmentDirectional.topStart,
    end: AlignmentDirectional.bottomEnd,
  );
// static Shader shaderCallback (bounds) {
//   return  LinearGradient(
//     colors:currentIndex == 1 ? [
//       Color(0xff42DEBF),
//       Color(0xff6CA5C2),
//       Color(0xff4876B2),
//       Color(0xff315FAA),
//     ] :[
//       ThemeClass.blackColor,
//       ThemeClass.blackColor,
//     ],
//   ).createShader(bounds);
// }
  static List<BoxShadow> primaryBoxShadow = [
    BoxShadow(
      color: const Color.fromRGBO(197, 197, 197, 0.5),
      spreadRadius: 5.r,
      blurRadius: 8.r,
      offset: const Offset(0, 2), // changes position of shadow
    ),
  ];
  static List<BoxShadow> secondaryBoxShadow = [
    BoxShadow(
      color: const Color.fromRGBO(197, 197, 197, 0.5),
      spreadRadius: 1.r,
      blurRadius: 1.r,
      offset: const Offset(0, 0), // changes position of shadow
    ),
  ];

  static Gradient gradientColors = LinearGradient(
    colors: <Color>[
      Color(0xff42DEBF),
      Color(0xff6CA5C2),
      Color(0xff4876B2),
      Color(0xff315FAA),
    ],
  );
  static Shader gradientText = LinearGradient(
    colors: <Color>[
      Color(0xff42DEBF),
      Color(0xff6CA5C2),
      Color(0xff4876B2),
      Color(0xff315FAA),
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  static TextStyle defaultTextStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: ThemeClass.blackColor);

  static TextStyle getTextStyle(
          {Color? color, FontWeight? fontWeight, double? fontSize}) =>
      TextStyle(
        fontSize: fontSize!,
        fontWeight: fontWeight,
        color: color,
        fontFamily: 'Tajawal',
      );

  static BoxDecoration defaultDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.w),
    boxShadow: ThemeClass.secondaryBoxShadow,
  );
  static BoxDecoration customDecoration = BoxDecoration(
    color: Colors.white,
    image: const DecorationImage(
        image: AssetImage('assets/images/lists/AD Bar - 1.png'),
        fit: BoxFit.cover),
    borderRadius: BorderRadius.circular(10.w),
  );
}
