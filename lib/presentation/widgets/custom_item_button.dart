import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_padding.dart';

class CustomIconButton extends StatelessWidget {
  final Function()? onTap;
  final Widget child;
  final double? padding;
  final double? radius;
  final Color? bgColor;
  final double angle;

  const CustomIconButton(
      {Key? key,
        required this.onTap,
        required this.child,
        this.padding,
        this.radius,
        this.bgColor,
        this.angle = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor ?? Colors.transparent,
      borderRadius: BorderRadius.circular(radius ?? 2.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius ?? 2.r),
        child: CustomPadding.all(
          value: padding ?? 6,
          child: Transform.rotate(
            angle: angle,
            child: child,
          ),
        ),
      ),
    );
  }
}
