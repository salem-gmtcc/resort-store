import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manger.dart';

class TextStyleManager {
  const TextStyleManager._();
  static const String fontFamily = 'Cairo';

  // TODO: drop down , multi select cupertino widget, text field
  static TextStyle hintStyle() {
    return mediumTextStyle(
      fontSize: 12,
      color: AppColor.colorGreyDark,
    );
  }

  // TODO: drop down , multi select cupertino widget, text field
  static TextStyle activeStyle() {
    return semiBoldTextStyle(
      fontSize: 12,
      color: AppColor.hintColor,
    );
  }

  // TODO: drop down , multi select cupertino widget, text field
  static TextStyle headerStyle() {
    return boldTextStyle(
      fontSize: 13,
      color: AppColor.primaryAmwaj,
    );
  }
}

TextStyle _getTextStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color, {
      double? height,
    }) {
  return TextStyle(
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
    height: height,
    fontFamily: TextStyleManager.fontFamily,
  );
}

//TODO: light text style
TextStyle lightTextStyle({
  required double fontSize,
  required Color color,
  double? height,
}) {
  return _getTextStyle(
    fontSize,
    FontWeight.w300,
    color,
    height: height,
  );
}

//TODO: regular text style
TextStyle regularTextStyle({
  required double fontSize,
  required Color color,
  double? height,
}) {
  return _getTextStyle(
    fontSize,
    FontWeight.w400,
    color,
    height: height,
  );
}

//TODO: medium text style
TextStyle mediumTextStyle({
  required double fontSize,
  required Color color,
  double? height,
})  {
  return _getTextStyle(
    fontSize,
    FontWeight.w500,
    color,
    height: height,
  );
}

//TODO: semiBold text style
TextStyle semiBoldTextStyle({
  required double fontSize,
  required Color color,
  double? height,
}) {
  return _getTextStyle(
    fontSize,
    FontWeight.w600,
    color,
    height: height,
  );
}

//TODO: bold text style
TextStyle boldTextStyle({
  required double fontSize,
  required Color color,
  double? height,
}) {
  return _getTextStyle(
    fontSize,
    FontWeight.w700,
    color,
    height: height,
  );
}