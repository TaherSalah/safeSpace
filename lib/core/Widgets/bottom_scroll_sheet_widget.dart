// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:guidlle/Theme/theme.dart';
//
// void showBottomSheetCustomWidget(
//     {required BuildContext context, required Widget child, required callBack, bool? isDismissible=true}) {
//   showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       isDismissible: isDismissible==true?true:false,
//       builder: (BuildContext context) {
//         return DraggableScrollableSheet(
//           // maxChildSize: 0.6,
//           // initialChildSize:  0.6,
//           builder: (context, controller) {
//             return StatefulBuilder(
//                 builder: (ctx, setState) => Container(
//                   // height: 456.h,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadiusDirectional.only(
//                           topStart: Radius.circular(50.r),
//                           topEnd: Radius.circular(50.r)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.17),
//                           offset: Offset(
//                             0.0,
//                             3.w,
//                           ),
//                           blurRadius: 6.r,
//                           spreadRadius: 6.r,
//                         ), //BoxShadow
//                       ]),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 12.h),
//                       Container(
//                         width: 70.w,
//                         height: 3.h,
//                         decoration: BoxDecoration(
//                             color: ThemeClass.blackColor.withOpacity(0.5),
//                             borderRadius: BorderRadius.circular(2.w)),
//                       ),
//                       SizedBox(height: 34.h),
//                       child,
//                     ],
//                   ),
//                 ));
//           },
//         );
//       });
// }