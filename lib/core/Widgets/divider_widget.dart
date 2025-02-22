import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Theme/theme.dart';

class DividerWidget extends StatelessWidget {
  double? width;

   DividerWidget({
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width ?? 136.w,
      height: 1.h,
      decoration: BoxDecoration(
      color: ThemeClass.greyLightColor,
      borderRadius: BorderRadius.circular(8.r)),
    );
  }
}
