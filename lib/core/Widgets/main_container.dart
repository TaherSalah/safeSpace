import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Theme/theme.dart';

class MainContainerWidget extends StatelessWidget {
  const MainContainerWidget({
    required this.child,
    this.tapped = false,
    this.isSelected,
    this.onTap,
    this.isPadding = true,
    this.edgeInsetsGeometry,
    this.height,
    this.image,
    this.width,
    this.backGroundColor,
    super.key,
  });

  final Widget child;
  final bool? tapped;
  final String? image;
  final bool? isSelected, isPadding;
  final EdgeInsetsGeometry? edgeInsetsGeometry;
  final void Function()? onTap;
  final double? height, width;
  final Color? backGroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: height,
          width: width,
          padding: isPadding == true
              ? EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h)
              : edgeInsetsGeometry,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
              image: image != null
                  ? DecorationImage(
                      image: AssetImage(image ?? ''),
                      fit: BoxFit.fill,
                    )
                  : null,
              color: backGroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(10.w),
              boxShadow: ThemeClass.secondaryBoxShadow,
              border: isSelected == true
                  ? Border.all(color: ThemeClass.blackColor, width: 2)
                  : null),
          child: child),
    );
  }
}
