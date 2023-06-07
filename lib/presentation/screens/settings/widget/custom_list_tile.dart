import 'package:resort_store/core/helpers/textStyle_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/color_manger.dart';
import '../../../resources/textStyle_manger.dart';
import '../../../widgets/custom_padding.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onClick;
  Color? containerColor;
  final Color? textColor;
  final Color? iconColor;
  CustomTile({required this.title,required this.icon,
    this.onClick,
    this.containerColor,
    this.textColor,
    this.iconColor
  });
  @override
  Widget build(BuildContext context) {
    return CustomPadding.symmetric(
      vertical: 1.h,
      horizontal: 5.w,
      child: SizedBox(
        height: 50.h,
        width: double.infinity,
        child: ListTile(
          onTap: onClick,
          title: Text(title,style: textStyleCustom(
            context: context,
              fontSize: 14.sp,
              // fontColor:textColor ?? AppColor.white
          )),
          leading: CircleAvatar(
            radius: 15.r,
            backgroundColor:const Color.fromRGBO(244, 245, 247, 0.2),
            child: Icon(icon,size: 20.sp,color: AppColor.white1),
          ),
        ),
      ),
    );
  }
}

