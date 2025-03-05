import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safeSpace/core/Utilities/k_color.dart';
import 'package:safeSpace/core/Widgets/default_text_widget.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscure;
  final bool? readOnly;
  final String? hint;
  final String? label;
  final Color? backGroundColor;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final int? maxLine;
  final int? prefixWidth;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool? enable, isDense;
  final Color? borderColor;
  final double? borderRadiusValue, width, height;
  final EdgeInsets? insidePadding;
  final Widget? prefixIcon, suffixIcon;
  final void Function(String)? onchange;
  final void Function(String)? onFieldSubmitted;
  final Function()? onSuffixTap;
  final void Function()? onTap;
  final List<TextInputFormatter>? formatter;
  final TextInputAction? textInputAction;
  final bool? noBorder;
  final TextDirection? textDirection;
  const CustomTextFieldWidget({
    Key? key,
    this.isDense,
    this.style,
    this.onchange,
    this.insidePadding,
    this.validator,
    this.maxLine,
    this.hint,
    this.label,
    this.backGroundColor,
    this.controller,
    this.obscure = false,
    this.enable = true,
    this.readOnly = false,
    this.textInputType = TextInputType.text,
    this.textInputAction,
    this.borderColor,
    this.borderRadiusValue,
    this.prefixIcon,
    this.width,
    this.hintStyle,
    this.suffixIcon,
    this.onSuffixTap,
    this.height,
    this.onTap,
    this.prefixWidth,
    // this.noBorder = true,
    this.formatter,
    this.onFieldSubmitted,
    this.textDirection,
    this.noBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: TextFormField(
        // cursorHeight: 20.h,
        readOnly: readOnly ?? false,
        autocorrect: true,
        textAlignVertical: TextAlignVertical.center,
        validator: validator,
        textDirection: TextDirection.ltr,
        onTap: () => onTap,
        enabled: enable,
        inputFormatters: formatter ?? [],
        obscureText: obscure ?? false,
        obscuringCharacter: obscure != null ? "*" : '',
        textInputAction: textInputAction,
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          errorStyle: const TextStyle(height: 0),
          label: TextDefaultWidget(
            title: label ?? "",
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
          enabledBorder: noBorder == true
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(borderRadiusValue ?? 10.w),
                  borderSide: BorderSide(color: borderColor ?? Colors.black)),
          disabledBorder: noBorder == true
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(borderRadiusValue ?? 10.w),
                  borderSide: BorderSide(
                      color: borderColor ?? const Color(0xff555555))),
          focusedBorder: noBorder == true
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(borderRadiusValue ?? 10.w),
                  borderSide:
                      BorderSide(color: borderColor ?? KColors.primaryColor)),
          border: noBorder == true
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(borderRadiusValue ?? 10.w),
                  borderSide: BorderSide(
                      color: borderColor ?? const Color(0xFF555555))),
          isDense: isDense ?? false,
          prefixIconConstraints: BoxConstraints(
              minWidth: prefixIcon == null ? 0 : 35.w, maxHeight: 20.w),
          suffixIconConstraints: BoxConstraints(
              minWidth: suffixIcon == null ? 0 : 45.w, maxHeight: 40.h),
          contentPadding: insidePadding ?? EdgeInsets.symmetric(vertical: 6.h),
          fillColor: backGroundColor,
          filled: backGroundColor != null,
          hintText: hint,
          prefixIcon: prefixIcon == null
              ? SizedBox(width: 10.w)
              : SizedBox(width: 30.w, child: prefixIcon),
          suffixIcon: suffixIcon == null
              ? SizedBox(width: 5.w)
              : InkWell(
                  onTap: onSuffixTap,
                  child: SizedBox(width: 30.w, child: suffixIcon),
                ),
          hintStyle: hintStyle ??
              TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFFA5A5A5),
                  height: 1.5.h,
                  fontWeight: FontWeight.w400),
          // labelStyle: TextStyle(
          //    // fontSize: 12.sp,
          //     color: ThemeClass.orangeColor,
          //     height: 1.5.h,
          //    // fontWeight: FontWeight.w400
          // )
        ),
        onChanged: onchange,
        textCapitalization: TextCapitalization.words,
        maxLines: maxLine ?? 1,
        keyboardType: textInputType,
        style: style ??
            TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
        cursorColor: KColors.primaryColor,
        onEditingComplete: () {
          if (controller?.text.indexOf(' ', 0) != null) {
            controller?.text.replaceFirst(" ", '');
          }
        },
      ),
    );
  }
}
