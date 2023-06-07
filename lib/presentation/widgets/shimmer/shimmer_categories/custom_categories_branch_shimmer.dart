import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../resources/color_manger.dart';

class CustomCategoriesBranchShimmer extends StatelessWidget {
  const CustomCategoriesBranchShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(right: 10,left: 10,top: 10.0) ,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemBuilder: (context,index){
        return Shimmer.fromColors(
          direction: ShimmerDirection.ltr,
          baseColor: AppColor.white.withOpacity(0.25),
          highlightColor: AppColor.white.withOpacity(0.9),
          child: SizedBox(
            height: 150.h,
            width: 100.w,
            child: Card(
              color: AppColor.white.withOpacity(0.5),
              elevation: 8.0,
              shadowColor: AppColor.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Column(
                children: [
                  Container(
                    height: 60.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColor.white.withOpacity(0.5),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color:AppColor.white.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.r),
                            bottomRight: Radius.circular(15.r)
                        )
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
