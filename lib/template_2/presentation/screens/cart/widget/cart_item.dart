import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../business_logic/cart/cubit.dart';
import '../../../../../business_logic/cart/state.dart';
import '../../../../../business_logic/counter/cubit.dart';
import '../../../../../presentation/resources/textStyle_manger.dart';
import '../../../../../presentation/widgets/custom_padding.dart';

class NewTemplateCartItem extends StatelessWidget {
  String? productKey, title, image, price, quantity,taxAmount;
  num? totalRaw;

  NewTemplateCartItem({
    required this.productKey,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
    required this.taxAmount,
    required this.totalRaw,
  });
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColor.white,
      ),
      width: 200.w,
      height: 100.h,
      child: Padding(
        padding: EdgeInsets.only(right: 5.sp, left: 5.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //TODO : Image and Name And price
            Row(
              children: [
                //TODO: Image
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.white1,
                      shape: BoxShape.rectangle,
                      border: Border.all(
                          color: AppColor.backgroundColor.withOpacity(0.2)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          opacity: 0.8,
                          image: NetworkImage(
                            image!,
                          )),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    height: 100.h,
                    width: 80.w,
/*                  child: Image.asset("assets/images/img_3.png",
                  height: 60,
                    width: 50.w,
                  )*/
                  ),
                ),
                //TODO: NAME AND PRICE
                Container(
                  height: 95.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      Container(
                        width: 150.w,

                        child: Text(title!,
                            overflow: TextOverflow.ellipsis,
                            style: mediumTextStyle(
                                fontSize: 15.sp,
                                color: AppColor.black,
                                height: 0.5.h)),
                      ),
                      Text("${AppStrings.price.tr()}: ${price!}",
                          style: mediumTextStyle(
                              fontSize: 10.sp,
                              color: AppColor.primaryAmwaj,
                              height: 1.h)),
                      Text("${AppStrings.tax.tr()} $taxAmount",
                          style: mediumTextStyle(
                              fontSize: 10.sp,
                              color: AppColor.primaryAmwaj,
                              height: 1.h)),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        width: 75.w,
                        height: 25.h,
                        child: CustomPadding.symmetric(
                          horizontal: 5.sp,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 15.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                      color: AppColor.primaryAmwaj,
                                      borderRadius: BorderRadius.circular(3.r)),
                                  child: InkWell(
                                      onTap: () {
                                        context.read<CartCubit>().increment();
                                      },
                                      child: Icon(Icons.add,
                                          size: 15.sp, color: AppColor.white))),
                              BlocBuilder<CartCubit, CartStates>(
                                  builder: (context, state) {
                                if (state is ChangeQuantityItemState) {
                                  qty = state.qty;
                                }
                                return Text(qty.toString(),
                                    style: mediumTextStyle(
                                        fontSize: 12.0,
                                        color: AppColor.primaryAmwaj));
                              }),
                              Container(
                                  height: 15.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                      color: AppColor.primaryAmwaj,
                                      borderRadius: BorderRadius.circular(5.r)),
                                  child: InkWell(
                                      onTap: () {
                                        context.read<CartCubit>().decrement();
                                      },
                                      child: Icon(Icons.remove,
                                          size: 15.sp, color: AppColor.white))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //TODO: Price And Tax Price
            Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Text("${AppStrings.quantity.tr()}  ${quantity} x",
                    style: mediumTextStyle(
                        fontSize: 10.sp,
                        color: AppColor.colorBlackLight,
                        height: 0.5.h)),
                SizedBox(height: 3.h,),
                Text("${AppStrings.totalPrice.tr()} ${totalRaw.toString()}",
                    style: mediumTextStyle(
                        fontSize: 10.sp,
                        color: AppColor.colorBlackLight,
                        height: 1.h)),
                SizedBox(height: 20.h),
                IconButton(
                    onPressed: () {
                      context.read<CartCubit>().deleteItemFromCartCubit(productKey!);
                      context.read<CounterCubit>().removeItemCountCubit();
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: AppColor.primaryAmwaj,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
