import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBuildCategory extends StatelessWidget {

  String image,title;

  CustomBuildCategory({required this.image,required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40.h,
              width: 80.w,
              child: Image.network(image,height: 30.h,width: 30.w)),
          Container(
            width: 80.w,
              height: 30.h,
              padding: EdgeInsets.zero,
              child: Center(
                child: Padding(
                  padding:  EdgeInsets.only(
                    left: 5.sp,
                    right: 5.sp
                  ),
                  child: Text(title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    maxLines: 2,
                    style: TextStyle(
                        height: 1.h,
                        fontSize: 10.sp, color: AppColor.white),),
                ),
              ))
        ],
      ),
    );
  }
}

