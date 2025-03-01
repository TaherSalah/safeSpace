import 'package:flutter/material.dart';

class TextDefaultWidget extends StatelessWidget {
  const TextDefaultWidget({
    super.key,
    required this.title,
    this.fontSize,
    this.fontWeight,
    this.FontFamily,
    this.color,
    this.gradientColors,
    this.maxLines,
    this.height,
    this.underlineText,
    this.textBaseline,
    this.textAlign,
    this.textOverflow,
  });
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? FontFamily;
  final Color? color;
  final Paint? gradientColors;
  final String title;
  final int? maxLines;
  final bool? underlineText;
  final TextBaseline? textBaseline;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          height: height,
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? Colors.black,
          textBaseline: textBaseline,
          fontFamily: FontFamily ?? "RegularAr",
          foreground: gradientColors,
          overflow: textOverflow ?? TextOverflow.ellipsis,
          decoration: underlineText == true
              ? TextDecoration.underline
              : TextDecoration.none),
      maxLines: maxLines ?? 5,
      overflow: textOverflow ?? TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}
