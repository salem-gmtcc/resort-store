
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../resources/color_manger.dart';
import '../../resources/textStyle_manger.dart';



class CustomAlertDialog extends StatelessWidget {
  final Widget widget;
  final String title;
  final String image;
  const CustomAlertDialog({
    required this.widget,
    required this.title,
     required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Column(
        children: [
          Container(
              height: 30.h,
              width: 80.w,
              child: SvgPicture.asset("assets/icons/${image}")),
          Text(title,
              textAlign: TextAlign.center,style: mediumTextStyle(
              fontSize: 13.sp, color: AppColor.primaryAmwaj
          )),
        ],
      ),
      content: widget,
      contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 5.w),
      // actionsPadding:EdgeInsets.zero,
      // insetPadding: EdgeInsets.zero,
      // titlePadding: EdgeInsets.zero ,
      // backgroundColor: AppColor.white,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r)
      ),
    );
  }
}

