import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Theme/theme.dart';
import 'default_text_widget.dart';

class PopUpItemWidget extends StatelessWidget {
  const PopUpItemWidget({
    Key? key,
    required this.title,
    required this.iconPAth,
    this.lastItem = false,
    required this.value, this.onTap, this.color,
  }) : super(key: key);

  final String title, iconPAth;
  final bool? lastItem;
  final void Function()? onTap;
  final Color? color;

  final int value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPAth,
              color: color??  ThemeClass.greyColor,
              width: 22.w,
              height: 22.w,
            ),
            SizedBox(width: 12.w),
            TextDefaultWidget(
              title: title,
              color:color?? ThemeClass.greyColor,
            ),
          ],
        ),
        if (lastItem == false) const Divider(),
      ],
    );
  }
}
