import 'package:resort_store/core/helpers/textStyle_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/color_manger.dart';
import '../../../resources/textStyle_manger.dart';

class CustomBuildText extends StatelessWidget {
  String? text;
  CustomBuildText({required this.text});

  @override
  Widget build(BuildContext context) {
    return   Text(text!,style: textStyleCustom(fontSize: 15.sp));
  }
}
