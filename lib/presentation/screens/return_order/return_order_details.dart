import 'package:resort_store/business_logic/return_order/cubit.dart';
import 'package:resort_store/business_logic/return_order/state.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/textStyle_helper.dart';
import 'package:resort_store/presentation/widgets/background.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/change_theme/cubit.dart';
import '../../resources/color_manger.dart';
import '../../resources/textStyle_manger.dart';
import '../../../core/helpers/saved_theme.dart';


class ReturnOrderDetailsScreen extends StatelessWidget {
  const ReturnOrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor:  context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
        title: Text(AppStrings.returnOrderDetails.tr(),
            style: mediumTextStyle(fontSize: 16.0, color: AppColor.white)),
      ),
      body: BackGround(
        widget: BlocBuilder<ReturnOrderCubit, ReturnOrderStates>(
          builder: (context, state) {
            if (state is SuccessReturnOrderDetailsState) {
              return Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 130.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: AppColor.primaryLight)),
                      child: CustomPadding.symmetric(
                        horizontal: 10.w,
                        child: Column(
                          children: [
                            SizedBox(height: 8.h,),
                            Text(AppStrings.returnOrderDetails.tr(),
                                style: textStyleCustom(
                                    fontSize: 15.sp, fontColor: AppColor.white)),
                            SizedBox(height: 8.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${AppStrings.returnOrderNumber.tr()}:",
                                    style: textStyleCustom(
                                        fontSize: 12.0, fontColor: AppColor.white)),
                                Text(state.returnOrderDetailsModel.returnOrderDataModel!.returnId.toString() ?? "",
                                    style: textStyleCustom(
                                        fontSize: 12.0, fontColor: AppColor.white)),
                              ],
                            ),
                            SizedBox(height: 8.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${AppStrings.returnOrderDate.tr()}:",
                                    style: textStyleCustom(
                                        fontSize: 12.0, fontColor: AppColor.white)),
                                Text(state.returnOrderDetailsModel.returnOrderDataModel!.dateAdded!.substring(20,32),
                                    style: textStyleCustom(
                                        fontSize: 12.0, fontColor: AppColor.white)),
                              ],
                            ),
                            SizedBox(height: 8.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${AppStrings.orderNumber.tr()} :",
                                    style: mediumTextStyle(
                                        fontSize: 12.0, color: AppColor.white)),
                                Text(state.returnOrderDetailsModel.returnOrderDataModel!.orderId ?? "",
                                    style: textStyleCustom(
                                        fontSize: 12.0, fontColor: AppColor.white)),
                              ],
                            ),
                            SizedBox(height: 8.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${AppStrings.date.tr()}:",
                                    style: mediumTextStyle(
                                        fontSize: 12.0, color: AppColor.white)),
                                Text(state.returnOrderDetailsModel.returnOrderDataModel!.dateOrdered!.substring(20,32),
                                    style: textStyleCustom(
                                        fontSize: 12.0, fontColor: AppColor.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 130.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: AppColor.primaryLight)),
                      child: CustomPadding.symmetric(
                        horizontal: 10.w,
                        child: Column(
                          children: [
                            SizedBox(height: 8.h,),
                            Text(AppStrings.productDetails.tr(),
                                style: textStyleCustom(
                                    fontSize: 15.sp, fontColor: AppColor.white)),
                            SizedBox(height: 8.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStrings.name.tr(),
                                    style: textStyleCustom(
                                        fontSize: 12.0, fontColor: AppColor.white)),
                                Text(state.returnOrderDetailsModel.returnOrderDataModel!.product ?? "",
                                    style: mediumTextStyle(
                                        fontSize: 12.0, color: AppColor.white)),
                              ],
                            ),
                            SizedBox(height: 8.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${AppStrings.model.tr()}:",
                                    style: textStyleCustom(
                                        fontSize: 12.0.sp, fontColor: AppColor.white)),
                                Text(state.returnOrderDetailsModel.returnOrderDataModel!.model?? "",
                                    style: textStyleCustom(
                                        fontSize: 12.0.sp, fontColor: AppColor.white)),
                              ],
                            ),
                            SizedBox(height: 8.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStrings.quantity.tr(),
                                    style: textStyleCustom(
                                        fontSize: 12.sp, fontColor: AppColor.white)),
                                Text(state.returnOrderDetailsModel.returnOrderDataModel!.quantity ?? "",
                                    style: textStyleCustom(
                                        fontSize: 12.sp, fontColor: AppColor.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 130.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: AppColor.primaryLight)),
                      child: CustomPadding.symmetric(
                        horizontal: 10.w,
                        child: Column(
                          children: [
                            Text( AppStrings.reasonReturnOrder.tr(),
                                style: mediumTextStyle(
                                    fontSize: 15.sp, color: AppColor.white)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStrings.reason.tr(),
                                    style: textStyleCustom(
                                        fontSize: 12.0, fontColor: AppColor.white)),
                                SizedBox(height: 8.h,),
                                Text(state.returnOrderDetailsModel.returnOrderDataModel!.reason?? "",
                                    style: textStyleCustom(
                                        fontSize: 12.0, fontColor: AppColor.white)),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStrings.open.tr(),
                                    style: textStyleCustom(
                                        fontSize: 12.0, fontColor: AppColor.white)),
                                Text(state.returnOrderDetailsModel.returnOrderDataModel!.opened ?? "",
                                    style: textStyleCustom(
                                        fontSize: 12.0, fontColor: AppColor.white)),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStrings.comments.tr(),
                                    style: textStyleCustom(
                                        fontSize: 12.sp, fontColor: AppColor.white)),
                                Text(state.returnOrderDetailsModel.returnOrderDataModel!.comment!,
                                    style: textStyleCustom(
                                        fontSize: 12.sp, fontColor: AppColor.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else if (state is ErrorReturnOrderState) {
              showToast(text: state.error.toString(), color: ToastColors.ERROR);
            } else if (state is LoadingReturnOrderState) {
              Center(
                child: CircularProgressIndicator(color: AppColor.white),
              );
            }
            return  Center(child: CircularProgressIndicator(color: AppColor.white),);
          },
        ),
      ),
    );
  }
}
