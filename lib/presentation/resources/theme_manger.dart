import 'package:resort_store/presentation/resources/size_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manger.dart';

ThemeData lightTheme(Color mainColor) {
  return ThemeData(
    fontFamily: TextStyleManager.fontFamily,
    brightness: Brightness.light,
    //TODO: main colors
    primaryColor: mainColor,
    primaryColorLight: mainColor.withOpacity(0.2),
    primaryColorDark:mainColor,
    canvasColor: AppColor.canvasColor,
    colorScheme: ThemeData().colorScheme.copyWith(primary: mainColor),
    splashColor: mainColor,
    disabledColor: AppColor.grey,
    tabBarTheme: TabBarTheme(
      labelStyle: boldTextStyle(
        fontSize: 13,
        color: mainColor,
      ),
      unselectedLabelStyle: boldTextStyle(
        fontSize: 13,
        color:mainColor,
      ),
    ),
    //TODO: card theme
    cardTheme: CardTheme(
      color: AppColor.white,
      elevation: 4,
      shadowColor: AppColor.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
    ),
    //TODO: app bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: mainColor,
      elevation: 4,
      shadowColor: AppColor.primaryLight,
      titleSpacing: 0.w,
      titleTextStyle: semiBoldTextStyle(
        color: mainColor,
        fontSize: 15,
        height: 1.5,
      ),
    ),
    //TODO: button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      buttonColor:mainColor,
    ),

    //TODO: text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        onSurface: mainColor,
      ),
    ),

    //TODO: elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: mainColor,
        onPrimary: AppColor.primaryLight,
        textStyle: regularTextStyle(
          color: AppColor.white,
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    ),
    //TODO: text field decoration
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        vertical: 8.h,
        horizontal: 10.w,
      ),
      hintStyle: TextStyleManager.hintStyle(),
      labelStyle: TextStyleManager.hintStyle(),
      errorStyle: regularTextStyle(fontSize: 8, color: AppColor.red),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.border,
          width: 0.7.w,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(SizeManager.radius.r),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.border,
          width: 0.7.w,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(SizeManager.radius.r),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color:mainColor,
          width: 0.7.w,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(SizeManager.radius.r),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.red,
          width: 0.7.w,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(SizeManager.radius.r),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color:mainColor,
          width: 0.7.w,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(SizeManager.radius.r),
        ),
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: mainColor,
      inactiveTrackColor: AppColor.lightBlack2,
      trackHeight: 1.0.h,
      thumbColor: mainColor,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
      overlayColor: Colors.red.withAlpha(32),
      overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0.r),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: MaterialStateProperty.all(mainColor),
    ),
  );
}

