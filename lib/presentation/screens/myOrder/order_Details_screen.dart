import 'package:resort_store/business_logic/order/cubit.dart';
import 'package:resort_store/business_logic/order/state.dart';
import 'package:resort_store/core/constants/route_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/core/helpers/textStyle_helper.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/background.dart';
import 'package:resort_store/presentation/widgets/custom_button.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/change_theme/cubit.dart';
import '../../../core/helpers/saved_theme.dart';
import '../../resources/color_manger.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
      appBar: AppBar(
        backgroundColor:
            context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
        elevation: 0.0,
        title: Text(AppStrings.orderDetails.tr(),
            style: textStyleCustom(context: context,fontSize: 18.sp)),
      ),
      body: BlocBuilder<OrderCubit, OrderStates>(
        builder: (context, state) {
          if (state is GetDetailsOrdersSuccessState) {
            return BackGround(
              widget: Center(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      height: 150.h,
                      width: 350.w,
                      decoration: BoxDecoration(
                          color: AppColor.primaryLight,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: DataTable(columns: [
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          AppStrings.productDetails.tr(),
                          style: textStyleCustom(
                              fontSize: 12.sp, fontColor: AppColor.primaryAmwaj),
                        ))),
                        DataColumn(
                            label: Text(AppStrings.paymentMethod.tr(),
                                style: textStyleCustom(
                                    fontSize: 12.sp,
                                    fontColor: AppColor.primaryAmwaj))),
                      ], rows: [
                        DataRow(cells: [
                          DataCell(
                            Text(
                                "${AppStrings.orderNumber.tr()}: ${state.orderDetailsModel.getOrderDetailsModel!.orderId!}",
                                style: textStyleCustom(
                                    fontSize: 12.sp, fontColor: Colors.black)),
                          ),
                          DataCell(
                            Text(
                                state.orderDetailsModel.getOrderDetailsModel!
                                    .paymentMethod!,
                                style: textStyleCustom(
                                    fontSize: 12.sp, fontColor: Colors.black)),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Text(
                                "${AppStrings.date.tr()} : ${state.orderDetailsModel.getOrderDetailsModel!.dateModified ?? ""}",
                                style: textStyleCustom(
                                    fontSize: 12.sp, fontColor: Colors.black)),
                          ),
                          DataCell(
                            Text(
                                state.orderDetailsModel.getOrderDetailsModel!
                                        .shippingMethod ??
                                    "",
                                style: textStyleCustom(
                                    fontSize: 12.sp, fontColor: Colors.black)),
                          ),
                        ]),
                      ]),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: 350.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColor.primaryLight),
                      child: DataTable(columns: [
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          AppStrings.paymentAddress.tr(),
                          style: textStyleCustom(
                              fontSize: 15.sp, fontColor: AppColor.primaryAmwaj),
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(AppStrings.shippingAddress.tr(),
                                    style: textStyleCustom(
                                        fontSize: 15.sp,
                                        fontColor: AppColor.primaryAmwaj)))),
                      ], rows: [
                        DataRow(cells: [
                          DataCell(Text(
                              "${state.orderDetailsModel.getOrderDetailsModel!.paymentFirstname ?? ""}  ${state.orderDetailsModel.getOrderDetailsModel!.paymentLastname ?? ""} ")),
                          DataCell(Text(
                              "${state.orderDetailsModel.getOrderDetailsModel!.shippingFirstname ?? ""}  ${state.orderDetailsModel.getOrderDetailsModel!.shippingLastname ?? ""} ")),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(state.orderDetailsModel
                                  .getOrderDetailsModel!.paymentAddress1 ??
                              "")),
                          DataCell(Text(state.orderDetailsModel
                                  .getOrderDetailsModel!.shippingAddress1 ??
                              "")),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(state.orderDetailsModel
                                  .getOrderDetailsModel!.paymentAddress2 ??
                              "")),
                          DataCell(Text(state.orderDetailsModel
                                  .getOrderDetailsModel!.shippingAddress2 ??
                              "")),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                              "${state.orderDetailsModel.getOrderDetailsModel!.paymentCity ?? ""} ${state.orderDetailsModel.getOrderDetailsModel!.paymentPostCode ?? ""} ")),
                          DataCell(Text(
                              "${state.orderDetailsModel.getOrderDetailsModel!.shippingCity ?? ""} ${state.orderDetailsModel.getOrderDetailsModel!.shippingPostCode ?? ""} ")),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                              "${state.orderDetailsModel.getOrderDetailsModel!.paymentZone ?? ""} ")),
                          DataCell(Text(
                              "${state.orderDetailsModel.getOrderDetailsModel!.shippingZone ?? ""} ")),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(
                              "${state.orderDetailsModel.getOrderDetailsModel!.paymentCountry ?? ""} ")),
                          DataCell(Text(
                              "${state.orderDetailsModel.getOrderDetailsModel!.shippingCountry ?? ""} ")),
                        ]),
                      ]),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomPadding.symmetric(
                      horizontal: 5.0,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColor.primaryLight),
                        width: double.infinity,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: DataTable(
                              columns: [
                                DataColumn(
                                    label: Expanded(
                                  child: Center(
                                      child: Text(
                                    AppStrings.name.tr(),
                                    style: textStyleCustom(
                                        fontSize: 15.sp,
                                        fontColor: AppColor.primaryAmwaj),
                                  )),
                                )),
                                DataColumn(
                                    label: Expanded(
                                        child: Center(
                                            child: Text(AppStrings.model.tr(),
                                                style: textStyleCustom(
                                                    fontSize: 15.sp,
                                                    fontColor: AppColor
                                                        .primaryAmwaj))))),
                                DataColumn(
                                    label: Expanded(
                                        child: Center(
                                            child: Text(
                                                AppStrings.quantity.tr(),
                                                style: textStyleCustom(
                                                    fontSize: 15.sp,
                                                    fontColor: AppColor
                                                        .primaryAmwaj))))),
                                DataColumn(
                                    label: Expanded(
                                        child: Center(
                                            child: Text(AppStrings.price.tr(),
                                                style: textStyleCustom(
                                                    fontSize: 15.sp,
                                                    fontColor: AppColor
                                                        .primaryAmwaj))))),
                                DataColumn(
                                    label: Expanded(
                                        child: Center(
                                            child: Text(
                                                AppStrings.totalPrice.tr(),
                                                style: textStyleCustom(
                                                    fontSize: 15.sp,
                                                    fontColor: AppColor
                                                        .primaryAmwaj))))),
                                const DataColumn(label: Text("")),
                              ],
                              rows: List.generate(
                                  state.orderDetailsModel.getOrderDetailsModel!
                                      .products!.length, (index) {
                                return DataRow(cells: [
                                  DataCell(Text(state
                                      .orderDetailsModel
                                      .getOrderDetailsModel!
                                      .products![index]
                                      .name!)),
                                  DataCell(Text(state
                                      .orderDetailsModel
                                      .getOrderDetailsModel!
                                      .products![index]
                                      .model!)),
                                  DataCell(Text(state
                                      .orderDetailsModel
                                      .getOrderDetailsModel!
                                      .products![index]
                                      .quantity!)),
                                  DataCell(Text(state
                                      .orderDetailsModel
                                      .getOrderDetailsModel!
                                      .products![index]
                                      .price!)),
                                  DataCell(Text(state
                                      .orderDetailsModel
                                      .getOrderDetailsModel!
                                      .products![index]
                                      .total!)),
                                  DataCell(Row(
                                    children: [
                                      CustomButton(
                                        onPressed: () {
                                          print(
                                              "**********/ ${state.orderDetailsModel.getOrderDetailsModel!.products![index].orderProductId.toString()}");
                                          context
                                              .read<OrderCubit>()
                                              .reOrderOrderCubit(
                                                  state
                                                      .orderDetailsModel
                                                      .getOrderDetailsModel!
                                                      .orderId!,
                                                  state
                                                      .orderDetailsModel
                                                      .getOrderDetailsModel!
                                                      .products![index]
                                                      .orderProductId!);
                                        },
                                        radius: 5.r,
                                        width: 30.w,
                                        height: 30.h,
                                        color: AppColor.primaryAmwaj,
                                        child: Icon(
                                            Icons.shopping_cart_outlined,
                                            color: AppColor.white),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      CustomButton(
                                        onPressed: () {
                                          AppRouter.to(context,
                                              RouteConstants.reasonReturnOrder,
                                              arguments: {
                                                "order_id": state
                                                    .orderDetailsModel
                                                    .getOrderDetailsModel!
                                                    .orderId,
                                                "firstname": state
                                                    .orderDetailsModel
                                                    .getOrderDetailsModel!
                                                    .firstName,
                                                "lastname": state
                                                    .orderDetailsModel
                                                    .getOrderDetailsModel!
                                                    .lastName,
                                                "email": state
                                                    .orderDetailsModel
                                                    .getOrderDetailsModel!
                                                    .email,
                                                "phone": state
                                                    .orderDetailsModel
                                                    .getOrderDetailsModel!
                                                    .phone,
                                                "date": state
                                                    .orderDetailsModel
                                                    .getOrderDetailsModel!
                                                    .dateModified,
                                                "productName": state
                                                    .orderDetailsModel
                                                    .getOrderDetailsModel!
                                                    .products![index]
                                                    .name,
                                                "model": state
                                                    .orderDetailsModel
                                                    .getOrderDetailsModel!
                                                    .products![index]
                                                    .model,
                                                "quantity": state
                                                    .orderDetailsModel
                                                    .getOrderDetailsModel!
                                                    .products![index]
                                                    .quantity,
                                              });
                                        },
                                        radius: 5.r,
                                        width: 30.w,
                                        height: 30.h,
                                        color: AppColor.red,
                                        child: Icon(Icons.keyboard_return,
                                            color: AppColor.white),
                                      ),
                                    ],
                                  )),
                                ]);
                              })),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ReOrderOrderState) {
            showToast(
                    text: state.reorderOrderModel.message![1],
                    color: ToastColors.SUCCESS)
                .then((value) {
              AppRouter.back(context);
            });
          } else if (state is SendReturnOrderState) {
            showToast(text: "Order Return Success", color: ToastColors.SUCCESS)
                .then((value) {
              AppRouter.back(context);
            });
          } else if (state is OrderLoadingState) {
            CircularProgressIndicator(color: AppColor.white);
          } else if (state is OrderErrorState) {
            print("sdf'dffd ${state.e.toString()}");
            showToast(text: state.e.toString(), color: ToastColors.ERROR);
          }
          return BackGround(
              widget: Center(
            child: CircularProgressIndicator(
              color: AppColor.white,
            ),
          ));
        },
      ),
    );
  }
}
