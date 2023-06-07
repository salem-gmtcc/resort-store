import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomCompareProductShimmer extends StatelessWidget {
  const CustomCompareProductShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
          direction: ShimmerDirection.ltr,
        baseColor: AppColor.white.withOpacity(0.25),
        highlightColor: AppColor.white.withOpacity(0.9),
          child:  Row(
            children: [
              SizedBox(
                height: 350,
                width: 150,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: 40.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: AppColor.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 40.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: AppColor.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 40.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: AppColor.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 40.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: AppColor.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        height: 40.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: AppColor.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 600.h,
                width: 180.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColor.white.withOpacity(0.4),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      height: 100.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          color: AppColor.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 40.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          color: AppColor.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      height: 35.h,
                      width: 95.w,
                      decoration: BoxDecoration(
                          color: AppColor.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      height: 35.h,
                      width: 95.w,
                      decoration: BoxDecoration(
                          color: AppColor.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: AppColor.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20.r)),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      height: 30.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                          color: AppColor.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20.r)),
                    ),
                  ],
                ),
              ),
            ],
          ),),
    );
  }
}
