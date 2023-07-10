import 'package:resort_store/core/constants/route_constant.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/textStyle_helper.dart';

class CustomSubCategories extends StatelessWidget {
  String? id, name, image;

  CustomSubCategories(
      {required this.id, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRouter.to(context, RouteConstants.showProductByCategoryId,
            arguments: {"id": id, "name": name});
      },
      child: SizedBox(
        height: 150.h,
        width: 100.w,
        child: Card(
          color: AppColor.primaryLight,
          elevation: 8.0,
          shadowColor: AppColor.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            children: [
              Container(
                height: 70.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.8, image: NetworkImage(image!)),
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColor.white,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                  width: 150.w,

                  decoration: BoxDecoration(
                      color: AppColor.primaryLight,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.r),
                          bottomRight: Radius.circular(15.r))),
                  child: Center(
                      child: Text(name!,
                          overflow: TextOverflow.ellipsis,
                          style: textStyleCustom(
                            fontSize: 13.sp,
                            fontColor:Colors.white,
                          )
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
