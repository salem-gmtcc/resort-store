import 'package:resort_store/business_logic/cart/cubit.dart';
import 'package:resort_store/business_logic/coupon/coupon_cubit.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/dialog/custom_alert_dailog.dart';
import 'package:resort_store/presentation/widgets/custom_button.dart';
import 'package:resort_store/presentation/widgets/custom_loading.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:resort_store/presentation/widgets/custom_textFeild.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../business_logic/cart/state.dart';
import '../../../../business_logic/change_theme/cubit.dart';
import '../../../../data/repository/cart/cart.dart';

class CustomCouponCodeItem extends StatelessWidget {
  CustomCouponCodeItem({Key? key}) : super(key: key);
  final TextEditingController _coupon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomPadding.symmetric(
      horizontal: 10.w,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => BlocProvider(
                        create: (context) => CouponCubit(
                            cartRepository: instance<CartRepository>()),
                        child: BlocBuilder<CouponCubit,   CouponState>(
                          builder: (context, state) {
                            if (state is CouponSuccessState) {
                              showToast(
                                      text: "Add Coupon Code Successfully",
                                      color: ToastColors.SUCCESS)
                                  .then((value) {
                                AppRouter.back(context);
                              });
                            } else if (state is CouponErrorState) {
                              print("*********************-------________----- ${state.error.toString()}");
                              showToast(
                                  text: state.error.toString(),
                                  color: ToastColors.ERROR);
                            }
                            return SizedBox(
                              height: 100.h,
                              width: 200.w,
                              child:   CustomAlertDialog(
                                image: "coupon-Bold.svg",
                                title: AppStrings.useCouponCode.tr(),
                                widget:  Column(
                                  children: [
                                    SizedBox(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  AppColor.primaryAmwaj)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  AppColor.primaryAmwaj)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  AppColor.primaryAmwaj)),
                                          disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  AppColor.primaryAmwaj)),
                                        ),
                                        controller: _coupon,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppStrings.required.tr();
                                          }
                                          return null;
                                        },
                                      ),
                                      width: 180.w,
                                      height: 30.h,
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    CustomButton(
                                      textStyle: mediumTextStyle(
                                          fontSize: 10,
                                          color: AppColor.white),
                                      color: context
                                          .read<ThemeDataCubit>()
                                          .recolor ??
                                          AppColor.primaryAmwaj,
                                      radius: 10.r,
                                      title: AppStrings.send.tr(),
                                      onPressed: () {
                                        context
                                            .read<CouponCubit>()
                                            .getCoupon(_coupon.text);
                                      },
                                      height: 30.h,
                                      width: 80.w,
                                    ),
                                    if(state is CouponLoadingState)
                                      CircularProgressIndicator(color: AppColor.primaryAmwaj,)
                                  ],
                                ),),
                            );
                          },
                        ),
                      ));
            },
            child: Card(
              elevation: 3.0,
              child: Container(
                height: 30.h,
                width: 110.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.r),
                  border: Border.all(color: AppColor.white, width: 0.5),
                  color: context.read<ThemeDataCubit>().recolor ??
                      AppColor.primaryAmwaj,
                ),
                child: Center(
                    child: Text(AppStrings.useCouponCode.tr(),
                        style: mediumTextStyle(
                            fontSize: 10.sp, color: AppColor.white))),
              ),
            ),
          ),
          SizedBox(width: 5.w),
        ],
      ),
    );
  }
}
