import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manger.dart';
import '../resources/size_manger.dart';
import '../resources/textStyle_manger.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final String? hintText;
  final String? labelText;
  final String? title;
  final String? errorText;
  final String? autoFillHint;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isSecure;
  final bool? filled;
  final double? radius;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? cursorColor;

  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;

  final String? Function(String? value)? validator;
  final Function(String value)? onChanged;
  final int? length;
  final int maxLines;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final bool enableInteractiveSelection;
  final bool hasError;
  final String? errorMessage;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final TextStyle? labelTextStyle;
  final bool autoFocus;
  final double? width;
  final double? height;
  final bool? enabled;
  final bool readOnly;
  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final Color? borderColor;
  final Color? containerColor;

  const CustomTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.nextNode,
    this.hintText,
    this.title,
    this.autoFillHint,
    this.labelText,
    this.labelTextStyle,
    this.cursorColor,
    this.keyboardType,
    this.textInputAction,
    this.textStyle,
    this.isSecure = false,
    this.filled,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.containerColor,
    this.radius,
    this.length,
    this.errorText,
    this.maxLines = 1,
    this.initialValue,
    this.inputFormatters,
    this.contentPadding,
    this.enableInteractiveSelection = true,
    this.hasError = false,
    this.border,
    this.disabledBorder,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.errorMessage,
    this.textAlign,
    this.autoFocus = false,
    this.width,
    this.height,
    this.enabled,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.onTap,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 300.w,
      height: height ?? 60.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 50.0.r),
          color: containerColor ?? AppColor.primaryAmwaj),
      child: TextFormField(
        cursorColor: cursorColor ?? AppColor.primaryAmwaj,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTap: onTap,
        controller: controller,
        focusNode: focusNode,
        initialValue: initialValue,
        style: textStyle ??  TextStyleManager.hintStyle(),
        enabled: enabled,
        textAlign: textAlign ?? TextAlign.start,
        textInputAction: textInputAction ?? TextInputAction.next,
        enableInteractiveSelection: enableInteractiveSelection,
        keyboardType: keyboardType,
        obscureText: isSecure,
        obscuringCharacter: '●',
        readOnly: readOnly,
        autocorrect: false,
        autofocus: autoFocus,
        maxLength: length,
        maxLines: maxLines,
        autofillHints: autoFillHint == null ? null : [autoFillHint!],
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelStyle: labelTextStyle ?? mediumTextStyle(fontSize: 12.sp, color: AppColor.primaryAmwaj),
          errorText: errorText,
            labelText: labelText,
            hintText: hintText,
            filled: filled,
            fillColor: AppColor.white,
            contentPadding: contentPadding,
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints(minWidth: 30.w),
            prefixIconConstraints: BoxConstraints(
              minWidth: 30.w,
              maxWidth: 30.w,
            ),
            prefixIcon: prefixIcon,
            border: border ?? InputBorder.none,
            enabledBorder: enabledBorder ?? InputBorder.none,
            disabledBorder: disabledBorder ?? InputBorder.none,
            focusedBorder: focusedBorder ?? InputBorder.none,
            errorBorder: errorBorder ?? InputBorder.none),
        onFieldSubmitted: onFieldSubmitted ??
            (_) {
              nextNode == null
                  ? null
                  : FocusScope.of(context).requestFocus(nextNode);
            },
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
