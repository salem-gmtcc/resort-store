import 'package:resort_store/presentation/widgets/shimmer/shimmer_products/custom_product_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/color_manger.dart';
import '../../custom_padding.dart';
import 'custom_product_main_shimmer.dart';

class CustomProductDetailsShimmer extends StatelessWidget {
  const CustomProductDetailsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.white.withOpacity(0.3),
      highlightColor: AppColor.white.withOpacity(0.9),
      direction: ShimmerDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO : IMAGE
          Container(
            height: 180.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColor.white.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r))),
          ),
          SizedBox(
            height: 10.h,
          ),
          //TODO: NAME
          CustomPadding.symmetric(
            horizontal: 10,
            child: Container(
              height: 30.h,
              width: 230.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: AppColor.white.withOpacity(0.8),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          //TODO : COUNTER AND PRICE
          CustomPadding.symmetric(
            horizontal: 8.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Todo:  counter
                Container(
                  width: 120.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: AppColor.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                //todo : price
                Container(
                  width: 120.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: AppColor.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                )
              ],
            ),
          ),
          //TODO: Product Details
          CustomPadding.symmetric(
            horizontal: 4.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  height: 30.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColor.white.withOpacity(0.8)),
                ),
                SizedBox(
                  height: 5.h,
                ),
                const Text(
                    "****************************************** \n ******************************************** \n ************************** \n *******************")
              ],
            ),
          ),
          //TODO: Specification
          //TODO: Review
          CustomPadding.symmetric(
            vertical: 5.h,
            horizontal: 5.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColor.white.withOpacity(0.5),
                  ),
                ),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => SizedBox(
                    height: 50.h,
                    child: Icon(
                      Icons.star,
                      color: AppColor.white.withOpacity(0.5),
                      size: 40.sp,
                    ),
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                )
              ],
            ),
          ),
          //TODO: Button
          Center(
            child: Container(
              height: 30.h,
              width: 200.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.white,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          //TODO: Product Related
          const CustomMainProductShimmer(),
        ],
      ),
    );
  }
}
