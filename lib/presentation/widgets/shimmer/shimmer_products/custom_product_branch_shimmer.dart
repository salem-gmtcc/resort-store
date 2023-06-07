import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/textStyle_manger.dart';

//TODO: المنتجات الفرعية
class CustomBranchProductShimmer extends StatelessWidget {
  const CustomBranchProductShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) {
          return CustomPadding.symmetric(
            horizontal: 5.h,
            child: Container(
              height: 300.h,
              width: 300.w,
              decoration: BoxDecoration(
                color: AppColor.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Shimmer.fromColors(
                // period: const Duration(seconds: 3),
                direction: ShimmerDirection.ltr,
                baseColor: AppColor.grey.withOpacity(0.25),
                highlightColor: AppColor.white.withOpacity(0.9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODO : IMAGE CARD
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              height: 100.h,
                              decoration: BoxDecoration(
                                  color: AppColor.white.withOpacity(0.5)),
                              width: double.infinity,
                            ),
                          ),
                          //TODO : compare card
                          Card(
                            elevation: 10.0,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.r),
                                borderSide: BorderSide(
                                    color: AppColor.white.withOpacity(0.5),
                                    width: 0.1)),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.r),
                                    color: Colors.white.withOpacity(0.5)),
                                width: 35,
                                height: 35),
                          ),
                        ],
                      ),
                    ),
                    // TODO : TEXT
                    SizedBox(
                      height: 5.h,
                    ),
                    CustomPadding.symmetric(
                      horizontal: 3.w,
                      child: Container(
                        height: 20.h,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColor.white.withOpacity(0.5)),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    //TODO : Price
                    CustomPadding.symmetric(
                      horizontal: 8.w,
                      child: Container(
                        height: 25.h,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColor.white.withOpacity(0.5)),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    //TODO : Price with Tax
                    CustomPadding.symmetric(
                      horizontal: 8.w,
                      child: Container(
                        height: 20.h,
                        width: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColor.white.withOpacity(0.5)),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    //TODO : cart button
                    Center(
                      child: Container(
                        height: 40.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                            color: AppColor.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.6,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          crossAxisCount: 2),
      ),
    );
  }
}