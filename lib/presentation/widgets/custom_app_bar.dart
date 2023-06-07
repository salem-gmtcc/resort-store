import 'package:resort_store/business_logic/main/cubit.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../business_logic/change_theme/cubit.dart';
import '../../core/helpers/saved_theme.dart';

class CustomAppBar extends StatelessWidget {
    final String? title;
    final IconData? icon;
    final Color? color;
    final Color? iconColor;

    CustomAppBar({this.title,this.icon,this.color,this.iconColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
      elevation: 0.0,
      primary: true,
      title: CustomPadding.symmetric(
          horizontal: 15.h,
          child: Text(title ?? "",style: mediumTextStyle(fontSize: 15.sp, color: AppColor.white))),
      actions: [
       Padding( padding: const EdgeInsets.all(10.0) ,child:  Icon(Icons.notifications,size: 18.sp,color: iconColor?? AppColor.black),)
      ],
    );
  }
}
