import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BranchTitle extends StatelessWidget {
  String? title;
  Color? color;
  BranchTitle({required this.title,this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPadding.symmetric(
      horizontal: 10.w,
      child: SizedBox(
        height: 25.h,
        child: Text(title!,
            style: boldTextStyle(fontSize: 12.sp, color:color ?? AppColor.white)),
      ),
    );
  }
}
