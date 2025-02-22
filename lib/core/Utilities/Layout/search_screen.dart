import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Theme/theme.dart';

  class SearchScreen extends StatelessWidget {
  final Widget child;
  final bool search, withDropdown;
  const SearchScreen({Key? key, required this.child, this.search = false,  this.withDropdown=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
          search
              ? Positioned.fill(
                  child: Container(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                )
              : const SizedBox(),
          search
              ? Positioned(
                  child:
                  // Container(
                  //     decoration: BoxDecoration(color: ThemeClass.primaryColor),
                  //     child: Image.asset(
                  //       "assets/images/Guidlle.gif",
                  //       height: 150.h,
                  //       width: 250.w,
                  //     )),
                  CircularProgressIndicator(
                      color:withDropdown ==true ?Colors.transparent: ThemeClass.primaryColor, ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
