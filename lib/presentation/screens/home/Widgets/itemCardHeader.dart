import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/textStyle_helper.dart';
import '../../../resources/color_manger.dart';

class ItemCardHeader extends StatelessWidget {
  final Color? color;
  final String? title;
  ItemCardHeader({required this.color,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 70.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Center(
        child: Text(
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
            title!,
            style:TextStyle(
              fontSize: 12.sp,
              color:Colors.white,
            )),
      ),
    );
  }
}
