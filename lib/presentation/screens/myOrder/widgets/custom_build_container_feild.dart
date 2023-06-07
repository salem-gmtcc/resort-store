import 'package:resort_store/core/helpers/textStyle_helper.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBuildContainerField extends StatelessWidget {
  String? hintText;
  TextEditingController? textEditingController;

  CustomBuildContainerField({required this.hintText,required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 230.w,
      child: TextField(
        style: textStyleCustom(fontSize: 10.sp),
        cursorColor: AppColor.white,
        controller: textEditingController,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.white)),
            hintText: hintText,
          hintStyle: textStyleCustom(fontSize: 15.sp,fontColor: AppColor.white),
        ),
      ),
    );
  }
}
