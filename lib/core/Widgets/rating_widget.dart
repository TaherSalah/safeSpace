import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Theme/theme.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    this.titleOrRate,
    this.fontSize,
    this.color,
    this.edgeInsetsGeometry,
    this.child,
    this.fontWeight,
    this.width,
    this.height,
    this.onTap,
    super.key,
  });

  final String? titleOrRate;
  final double? fontSize, height, width;
  final Color? color;
  final EdgeInsetsGeometry? edgeInsetsGeometry;
  final Widget? child;
  final FontWeight? fontWeight;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: edgeInsetsGeometry ??
            EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: color ?? const Color(0xffC7C5C2).withOpacity(0.7),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: child ??
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                    // textBaseline: TextBaseline.alphabetic,
                    children: [
                      SvgPicture.asset("assets/images/star.svg"),
                      SizedBox(width: 8.w),
                      Padding(
                        padding:  EdgeInsets.only(top: 8.h),
                        child: Text(
                          titleOrRate!,
                          style: TextStyle(
                            fontSize: fontSize ?? 18.sp,
                            fontWeight: fontWeight ?? FontWeight.w500,
                            color: ThemeClass.whiteColor,
                            // textBaseline: TextBaseline.alphabetic
                          ),
                        ),
                      ),
                    ],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
