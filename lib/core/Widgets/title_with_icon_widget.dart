import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Theme/theme.dart';
import 'gradien_asset_widget.dart';

class TitleWithIconWidget extends StatelessWidget {
  const TitleWithIconWidget({Key? key, required this.image, required this.firstTitle, this.secondTitle, this.thirdTitle, this.fourthTitle}) : super(key: key);
  final String image;
  final String firstTitle;
  final   String? secondTitle;
  final String? thirdTitle;
  final    String? fourthTitle;
  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        GradientAssetWidget(image: image,height:24.w, width: 24.w, ),

        SizedBox(width: 4.w),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            RichText(
              text: TextSpan(
                  text: "$firstTitle\t",
                  style: ThemeClass.getTextStyle(
                      color: ThemeClass.blackDarktColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500)
                      .copyWith(
                    textBaseline: TextBaseline.alphabetic,
                  ),
                  children: [
                    TextSpan(
                        text: secondTitle ?? "",
                        style: ThemeClass.getTextStyle(
                            color: ThemeClass.blackDarktColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500)
                      //.copyWith(textBaseline: TextBaseline.alphabetic),
                    ),
                  ]),
            ),
          ],
        ),
        if (thirdTitle != null) SizedBox(width: 10.w),
        thirdTitle != null
            ? Column(
          children: [
            SizedBox(height: 12.h),
            RichText(
              text: TextSpan(
                  text: "$thirdTitle\t",
                  style: ThemeClass.getTextStyle(
                      color: ThemeClass.blackDarktColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500)
                      .copyWith(textBaseline: TextBaseline.ideographic),
                  children: [
                    TextSpan(
                        text: fourthTitle,
                        style: ThemeClass.getTextStyle(
                            color: ThemeClass.blackDarktColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500)
                      //.copyWith(textBaseline: TextBaseline.ideographic),
                    ),
                  ]),
            ),
          ],
        )
            : const SizedBox(),
      ],
    );
  }
}