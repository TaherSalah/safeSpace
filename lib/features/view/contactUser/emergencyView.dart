import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safeSpace/core/Utilities/k_color.dart';
import 'package:safeSpace/core/Utilities/toast_helper.dart';
import 'package:safeSpace/core/Widgets/default_text_widget.dart';
import 'package:safeSpace/features/view/home/widget/homeViewItemBuilder.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextDefaultWidget(title: "Contact"),
      ),
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextDefaultWidget(title: "Contact User"),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    ToastHelper.showSuccess(message: "Help");

                  },
                  child: Card(
                    color: KColors.KBtn2,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
                      child: TextDefaultWidget(title: "Help",fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
ToastHelper.showSuccess(message: "Busy");
                  },
                  child: Card(
                    color: KColors.KBtn2,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
                      child: TextDefaultWidget(title: "Busy",fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
              ],
            )
            
          ],
        ),
      ),
    ));
  }
}
