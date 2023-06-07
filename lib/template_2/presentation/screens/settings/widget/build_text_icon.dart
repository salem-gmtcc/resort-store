import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../presentation/resources/color_manger.dart';

class BuildTextIcon extends StatelessWidget {
  String? name, icon;

  BuildTextIcon({required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: 190.w,
      child: Padding(
        padding:  EdgeInsets.only(
          left: 5.sp,
          right: 5.sp
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/$icon"),
            SizedBox(width: 5.w),
            Text(name!,style: boldTextStyle(fontSize: 12.sp, color: AppColor.spareTKTemplate),)
          ],
        ),
      ),
    );
  }
}
