import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPadding extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final Widget? child;

  const CustomPadding._({
    Key? key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.child,
  }) : super(key: key);

  factory CustomPadding.symmetric({
    double? vertical,
    double? horizontal,
    Widget? child,
  }) {
    return CustomPadding._(
      top: vertical?.h,
      bottom: vertical?.h,
      left: horizontal?.w,
      right: horizontal?.w,
      child: child,
    );
  }

  factory CustomPadding.fromEdgeInsets({
    required EdgeInsets padding,
    Widget? child,
  }) {
    return CustomPadding._(
      top: padding.top.h,
      bottom: padding.bottom.h,
      left: padding.left.w,
      right: padding.right.w,
      child: child,
    );
  }

  factory CustomPadding.all({
    required double value,
    Widget? child,
  }) {
    return CustomPadding._(
      top: value.w,
      bottom: value.w,
      left: value.w,
      right: value.w,
      child: child,
    );
  }

  factory CustomPadding.only({
    double? top,
    double? bottom,
    double? left,
    double? right,
    Widget? child,
  }) {
    return CustomPadding._(
      top: top?.h,
      bottom: bottom?.h,
      left: left?.w,
      right: right?.w,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    double defaultValue = 0;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        left ?? defaultValue,
        top ?? defaultValue,
        right ?? defaultValue,
        bottom ?? defaultValue,
      ),
      child: child,
    );
  }
}
