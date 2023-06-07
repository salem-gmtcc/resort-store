import 'package:resort_store/business_logic/order/cubit.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/textStyle_helper.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/dialog/custom_alert_dailog.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:resort_store/presentation/widgets/dialog/custom_general_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../business_logic/change_theme/cubit.dart';
import '../../../../core/helpers/app_router.dart';
import '../../../../core/helpers/saved_theme.dart';

import '../../address_payment/choose_existing_payment_address.dart';

class CustomCheckOutButton extends StatelessWidget {
  String? totalPrice ,price;
  CustomCheckOutButton({required this.totalPrice,required this.price,});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.h,
      child: CustomPadding.symmetric(
        horizontal: 10.w,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text(AppStrings.totalPrice.tr(),style: mediumTextStyle(fontSize: 15.sp,color: AppColor.black)),
                Text(totalPrice!,style: mediumTextStyle(fontSize: 15, color: AppColor.black))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                 SizedBox(
                   height: 5.h,
                 ),
                //Text(AppStrings.newShipping.tr(),style: textStyleCustom(fontSize: 15.sp,fontColor: AppColor.black)),
               // Text("0.0 SAR",style: textStyleCustom(fontSize: 12.sp,fontColor: AppColor.black)),
              ],
            ),
            SizedBox(height: 5.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                SizedBox(height: 10.h,),
                // Text(AppStrings.valueAdded.tr(),style: mediumTextStyle(fontSize: 15.sp,color: AppColor.black)),
                // Text(priceWithExculduing!,style: textStyleCustom(fontSize: 12.sp,fontColor: AppColor.black)),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            //TODO: TOTAL PRICE
            Container(
              height: 30.h,
              width:250.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: AppColor.primaryLight),
              child: CustomPadding.symmetric(
                horizontal: 10.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(AppStrings.totalPrice.tr(),
                        style:
                            mediumTextStyle(fontSize: 15, color: AppColor.white)),
                    Text(
                        price!),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            //TODO: Confirm button
            InkWell(
              onTap: () {
                context.read<OrderCubit>().confirmOrderCubit().then((value) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    customGeneralDialog(context, ChooseExistingPaymentAddress(),
                        AppStrings.choosePaymentAddress.tr());
                  });
                });
              },
              child: Container(
                height: 30.h,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj),
                child: Center(
                    child: Text(
                 AppStrings.confirm.tr(),
                  style: mediumTextStyle(fontSize: 15.0, color: AppColor.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
