import 'package:resort_store/business_logic/cart/cubit.dart';
import 'package:resort_store/business_logic/change_theme/cubit.dart';
import 'package:resort_store/business_logic/counter/cubit.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../business_logic/cart/state.dart';
import '../../../../core/helpers/textStyle_helper.dart';
import '../../../resources/color_manger.dart';
import '../../../resources/textStyle_manger.dart';
import '../../../widgets/custom_padding.dart';

class PagItem extends StatelessWidget {
  String? productKey, title, image, price, quantity,taxAmount;
  num? totalRaw;
  PagItem({
    required this.productKey,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
    required this.taxAmount,
    required this.totalRaw,
  });

  int qty = 1 ;
  @override
  Widget build(BuildContext context) {
    return CustomPadding.symmetric(
      horizontal: 5.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO: IMAGE Container
          Stack(
            children: [
              Container(
                height: 80.h,
                width: 80.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: AppColor.white),
                child: Center(
                    child: Image.network(image!,
                        fit: BoxFit.cover, height: 50.h, width: 50.w)),
              ),
              Padding(
                padding: EdgeInsets.all(5.sp),
                child: Container(
                    height: 20.h,
                    width: 20.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: AppColor.white1),
                    child: InkWell(
                      onTap: () {
                        context.read<CartCubit>().deleteItemFromCartCubit(productKey!);
                        context.read<CounterCubit>().removeItemCountCubit();
                      },
                      child: Icon(Icons.close,
                          color: AppColor.black, size: 15.sp),
                    )),
              ),
            ],
          ),
          //TODO: Product Name
          SizedBox(
            width: 10.w,
          ),
          Flexible(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style:
                          boldTextStyle(fontSize: 10.sp, color: AppColor.white),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "${AppStrings.price.tr()}  ${price.toString()}",
                      style: textStyleCustom(fontSize: 10.sp,fontColor: AppColor.white1),
                    ),
                    SizedBox(height:3.h),
                    Text(
                      "${AppStrings.tax.tr()} ${taxAmount.toString()}",
                      style: textStyleCustom(fontSize: 10.sp,fontColor: AppColor.white1),
                    ),
                    SizedBox(height:3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.quantity.tr(),
                          style: textStyleCustom(
                            fontColor: AppColor.white1,
                            fontSize: 10.sp
                          ),
                        ),
                        SizedBox(
                          width: 25.w,
                        ),
                        Text(
                         "x${quantity!}",
                          style: textStyleCustom(
                              fontSize: 10.sp,
                              fontColor:AppColor.white1.withOpacity(0.9) ,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:8.h),
                    Text(
                      "${AppStrings.totalPrice.tr()}  ${totalRaw.toString()}",
                      style: textStyleCustom(
                        fontSize: 10.sp,
                        fontColor: AppColor.white
                      ),
                    ),
                  ],
                ),
                // TODO : Counter
                // Container(
                //   width: 95.w,
                //   height: 30.h,
                //   decoration: BoxDecoration(
                //     color: AppColor.white1,
                //     borderRadius:
                //     BorderRadius.circular(10.r),
                //   ),
                //   child: CustomPadding.symmetric(
                //     horizontal: 5.sp,
                //     child: Row(
                //       mainAxisAlignment:
                //       MainAxisAlignment
                //           .spaceBetween,
                //       crossAxisAlignment:
                //       CrossAxisAlignment.center,
                //       children: [
                //         Container(
                //             height: 20.h,
                //             width: 25.w,
                //             decoration: BoxDecoration(
                //                 color: AppColor.spareTKTemplate,
                //                 borderRadius:
                //                 BorderRadius
                //                     .circular(
                //                     5.r)),
                //             child: InkWell(
                //                 onTap: () {
                //                   context
                //                       .read<
                //                       CartCubit>()
                //                       .increment();
                //                 },
                //                 child: Icon(Icons.add,
                //                     size: 15.sp,
                //                     color: AppColor
                //                         .white))),
                //         BlocBuilder<CartCubit,
                //             CartStates>(
                //             builder:
                //                 (context, state) {
                //               if (state
                //               is ChangeQuantityItemState) {
                //                 qty = state.qty;
                //               }
                //               return Text(qty.toString(),
                //                   style: mediumTextStyle(
                //                       height: 1.5.h,
                //                       fontSize: 20.0,
                //                       color: AppColor
                //                           .lightBlack));
                //             }),
                //         Container(
                //             height: 20.h,
                //             width: 25.w,
                //             decoration: BoxDecoration(
                //                 color: AppColor.spareTKTemplate,
                //                 borderRadius:
                //                 BorderRadius
                //                     .circular(
                //                     5.r)),
                //             child: InkWell(
                //                 onTap: () {
                //                   context.read<CartCubit>().decrement();
                //                 },
                //                 child: Icon(
                //                     Icons.remove,
                //                     size: 15.sp,
                //                     color: AppColor
                //                         .white))),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
