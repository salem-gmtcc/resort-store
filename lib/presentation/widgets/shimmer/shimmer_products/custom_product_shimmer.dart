import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/color_manger.dart';
import '../../custom_padding.dart';


//TODO: PAG , FAVOURITE, COMPIRE

class CustomProductShimmer extends StatelessWidget {
  const CustomProductShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context,i){
        return CustomPadding.symmetric(
          vertical: 10.h,
          child: Shimmer.fromColors(
            baseColor: AppColor.grey.withOpacity(0.25),
            highlightColor: AppColor.white.withOpacity(0.9),
            direction: ShimmerDirection.ltr,
            child: CustomPadding.symmetric(
              horizontal: 5.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TODO: IMAGE Container
                  Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppColor.white
                    ),
                  ),
                  //TODO: Product Name
                  SizedBox(
                    width: 10.w,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 200.w,height: 30.h,decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(5.r),
                        ) ,),
                        SizedBox(height: 10.h,),
                        Container(width: 150.w,height: 30.h,decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(5.r),
                        ) ,),
                        SizedBox(height: 10.h,),
                        Container(width: 70.w,height: 20.h,decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ) ,),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
