import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



 AwesomeDialog customAwesomeDialog(context,String title,DialogType type) {
   return  AwesomeDialog(
     autoHide: Duration(seconds:2),
       context: context,
       dialogType: type,
       animType: AnimType.scale,
       title: title,
       desc: "",
     titleTextStyle: mediumTextStyle(fontSize: 15.sp, color: AppColor.primaryAmwaj),
   )..show();
 }
