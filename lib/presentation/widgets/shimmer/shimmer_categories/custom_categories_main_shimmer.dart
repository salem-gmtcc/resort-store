import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/color_manger.dart';
import '../../custom_padding.dart';

class CustomCategoriesMainShimmer extends StatelessWidget {
  const CustomCategoriesMainShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPadding.symmetric(
     vertical: 5.h,
      horizontal: 2.h,
      child: SizedBox(
        height: 40.h,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return CustomPadding.symmetric(
                horizontal: 3.h,
                child: Container(
                  height: 40.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                      color: AppColor.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12.r)),
                  child: Shimmer.fromColors(
                    direction: ShimmerDirection.ltr,
                    baseColor: AppColor.white.withOpacity(0.25),
                    highlightColor: AppColor.white.withOpacity(0.9),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
