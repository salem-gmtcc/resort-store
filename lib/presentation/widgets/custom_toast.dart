import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ToastColors {
  SUCCESS,
  ERROR,
  WARNING,
}

   Future<void> showToast({
    required String text,
    required ToastColors color,
  }) async {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: setToastColor(color),
      textColor: Colors.white,
      fontSize: 15.sp,
    );
  }

  //------------
  Color setToastColor(ToastColors color) {
    Color c;
    switch (color) {
      case ToastColors.ERROR:
        c = Colors.red;
        break;
      case ToastColors.SUCCESS:
        c = Colors.green;
        break;
      case ToastColors.WARNING:
        c = Colors.amber;
        break;
    }

    return c;
  }





