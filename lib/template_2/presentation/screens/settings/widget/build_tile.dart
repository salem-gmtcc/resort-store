import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildTile extends StatelessWidget {
    String? name;
    Function()? onClick;
    BuildTile({required this.name,required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 20.h,
        child: ListTile(
          title: Text(name!,style: mediumTextStyle(fontSize: 12.sp,
              color: AppColor.primaryAmwaj.withOpacity(0.5))),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 12.sp,
            color: AppColor.colorGreyLight,
          ),
        ),
      ),
    );
  }
}
