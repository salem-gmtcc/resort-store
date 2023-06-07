import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manger.dart';
import '../resources/textStyle_manger.dart';
import 'custom_padding.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String? title;
  final double? width;
  final double? height;
  final double? radius;
  final MainAxisAlignment alignment;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? horizontalMargin;
  final double? elevation;
  final Color? color;
  final Color? borderColor;
  final TextStyle? textStyle;
  final Widget? child;
  final Border? border;

  const CustomButton({
    Key? key,
    required this.onPressed,
    this.title,
    this.width,
    this.height,
    this.radius,
    this.alignment = MainAxisAlignment.center,
    this.horizontalPadding,
    this.verticalPadding,
    this.horizontalMargin,
    this.elevation,
    this.color,
    this.borderColor,
    this.textStyle,
    this.child,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? AppColor.transparent,
      borderRadius: BorderRadius.circular(radius ?? 10.r),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: border,
            borderRadius: BorderRadius.circular(radius!)
          ),
          child: child ?? Text(
                title ?? "empty",
                style: textStyle ??
                    semiBoldTextStyle(
                      fontSize: 15,
                      color: AppColor.white,
                    ),
              ),
        ),
      ),
    );
  }
}
