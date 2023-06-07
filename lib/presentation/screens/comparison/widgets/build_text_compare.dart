import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/textStyle_helper.dart';

class BuildTextCompare extends StatelessWidget {
  String? text;
  BuildTextCompare({required this.text});

  @override
  Widget build(BuildContext context) {
    return  CustomPadding.symmetric(
      vertical: 2.h,
      child: Container(
        height: 40.h,
        width: 120.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1.r),
            color: AppColor.primaryLight
        ),
        child: Center(child: Text(text!,style:textStyleCustom(
          fontSize: 12.sp,
        ),)),
      ),
    );
  }
}
