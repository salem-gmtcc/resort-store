import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBuildCategory extends StatelessWidget {

  String image,title;

  CustomBuildCategory({required this.image,required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(image,height: 40.h,width: 40.w),
        Text(title,style: mediumTextStyle(fontSize: 12.sp, color: AppColor.white),)
      ],
    );
  }
}

