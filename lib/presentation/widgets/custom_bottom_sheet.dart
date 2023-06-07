import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manger.dart';


class CustomBottomSheet extends StatelessWidget {
  final Widget widget ;
  final double height;


  CustomBottomSheet({required this.widget,required this.height});
  @override
  Widget build(context) {
    return  Container(
        height:height,
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(50.0),
            topLeft: Radius.circular(50.0)
          )
        ),
        child:widget
    );
  }
}
