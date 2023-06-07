import 'dart:ui';
import 'package:resort_store/business_logic/change_text_color/change_text_color_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

TextStyle textStyleCustom(
        {BuildContext? context,
        double? fontSize,
        Color? fontColor,
        double? height}) =>
    TextStyle(
      fontSize: fontSize ?? 15.sp,
      fontWeight: FontWeight.w500,
      color: context?.read<ChangeTextColorCubit>().textColor ?? fontColor,
      height: height ?? 1.0,
    );
