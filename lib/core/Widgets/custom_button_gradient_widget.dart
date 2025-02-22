import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGradientButtonWidget extends StatelessWidget {
  final _GradientPainter _painter;
  final String title;
  final void Function()? _callback;
  final Color _color;
  final double? width,height, verticalPadding;
  final bool? isGradient;

  CustomGradientButtonWidget(
      {super.key,
      required this.title,
      final void Function()? onPressed,
      Color? color, this.width, this.isGradient=true, this.height, this.verticalPadding})
      : _painter = _GradientPainter(
          strokeWidth: 2,
          gradient: const LinearGradient(colors: [
            Color(0xff42DEBF),
            Color(0xff6CA5C2),
            Color(0xff6CA5C2),
            Color(0xff315FAA),
            Color(0xff315FAA),
            Color(0xff4876B2),
          ]),
        ),
        _callback = onPressed,
        _color = color ?? const Color(0xff070707);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter:isGradient==true? _painter:null,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _callback,
        child: InkWell(
          borderRadius: BorderRadius.circular(30.r),
          onTap: _callback,
          child: Container(
            // height: 200.h,
            // width: 321.w,
            padding: EdgeInsets.all(1.6.w),
            // constraints: BoxConstraints(minWidth: 88.w, minHeight: 50.h),
            child: Container(
              alignment: AlignmentDirectional.center,
              padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 14.h),
              width:width,
              height: height,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter({required this.strokeWidth, required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect = RRect.fromRectAndRadius(outerRect, Radius.circular(30.r));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect =
        RRect.fromRectAndRadius(innerRect, Radius.circular(30.r - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
