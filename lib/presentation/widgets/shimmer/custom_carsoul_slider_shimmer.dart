import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomCarouselSliderShimmer extends StatelessWidget {
  const CustomCarouselSliderShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPadding.symmetric(
      horizontal: 10.h,
      child: Container(
        height: 150.h,
        width: double.infinity.w,
        decoration: BoxDecoration(
        color: AppColor.white.withOpacity(0.9),
    borderRadius: BorderRadius.circular(10.r),
        ),
        child: Shimmer.fromColors(
          direction: ShimmerDirection.ltr,
          baseColor: AppColor.grey.withOpacity(0.25),
          highlightColor: AppColor.white.withOpacity(0.9),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.white.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }
}
