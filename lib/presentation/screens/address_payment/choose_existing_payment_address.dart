import 'package:resort_store/business_logic/change_theme/cubit.dart';
import 'package:resort_store/business_logic/order/cubit.dart';
import 'package:resort_store/business_logic/payment_address/cubit.dart';
import 'package:resort_store/business_logic/payment_address/state.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/data/repository/payment_address/payment_address.dart';
import 'package:resort_store/data/repository/payment_method/payment_method.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/screens/payment_method/custom_payment_method.dart';
import 'package:resort_store/presentation/widgets/custom_button.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:resort_store/presentation/widgets/dialog/custom_awesome_dialog.dart';
import 'package:resort_store/presentation/widgets/dialog/custom_general_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../business_logic/payment_method/cubit.dart';
import '../../../core/helpers/textStyle_helper.dart';
import '../../../data/repository/order/order.dart';
import 'custom_payment_address.dart';

class ChooseExistingPaymentAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentAddressCubit(
          paymentAddressRepository: instance<PaymentAddressRepository>())
        ..getAllPaymentAddressCubit(),
      child: Column(
        children: [
          // TODO: get All Payment Address

          BlocBuilder<PaymentAddressCubit, PaymentAddressStates>(
              builder: (context, state) {
            print("******state : $state");
            if (state is SuccessGetAllPaymentAddressState) {
              if (state.paymentAddressModel!.getPaymentAddressModel!
                  .paymentListAddressModel!.isNotEmpty) {
                return SizedBox(
                  height: 200.h,
                  width: 200.w,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state
                          .paymentAddressModel!
                          .getPaymentAddressModel!
                          .paymentListAddressModel!
                          .length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            print(
                                "**** ${state.paymentAddressModel!.getPaymentAddressModel!.paymentListAddressModel![i].addressId!} ");
                            context
                                .read<PaymentAddressCubit>()
                                .sendPaymentAddressCubit(state
                                    .paymentAddressModel!
                                    .getPaymentAddressModel!
                                    .paymentListAddressModel![i]
                                    .addressId!);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              height: 60.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                gradient: LinearGradient(
                                    colors: [
                                      context.read<ThemeDataCubit>().recolor ??
                                          AppColor.primaryAmwaj,
                                      context
                                          .read<ThemeDataCubit>()
                                          .recolor!
                                          .withOpacity(0.7)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                      state
                                          .paymentAddressModel!
                                          .getPaymentAddressModel!
                                          .paymentListAddressModel![i]
                                          .firstname!,
                                      style: textStyleCustom(
                                        fontSize: 10.sp,
                                        fontColor:Colors.white,
                                      )),
                                  Text(
                                      state
                                          .paymentAddressModel!
                                          .getPaymentAddressModel!
                                          .paymentListAddressModel![i]
                                          .country!,
                                      style: textStyleCustom(
                                        fontSize: 10.sp,
                                        fontColor:Colors.white,
                                      )),
                                  Text(
                                      state
                                          .paymentAddressModel!
                                          .getPaymentAddressModel!
                                          .paymentListAddressModel![i]
                                          .city!,
                                      style: textStyleCustom(
                                        fontSize: 10.sp,
                                        fontColor:Colors.white,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return SizedBox(
                    height: 125.h,
                    width: 150.w,
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset("assets/images/empty_box.png",
                              width: 100.w, height: 80.h),
                          Text(
                            AppStrings.listEmpty.tr(),
                            style: textStyleCustom(
                              fontSize: 15.sp,
                              fontColor:Colors.white,
                            ),
                          )
                        ],
                      ),
                    ));
              }
            } else if (state is SuccessSendExistingPaymentAddressState) {
              print("-----------------------------------------");

              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                customGeneralDialog(
                    context,
                    MultiBlocProvider(providers: [
                      BlocProvider(
                          create: (context) => PaymentMethodsCubit(
                              paymentMethodRepository:
                                  instance<PaymentMethodRepository>())
                            ..getPaymentMethodCubit()),
                      BlocProvider(
                          create: (context) => OrderCubit(
                              confirmOrderRepository:
                                  instance<ConfirmOrderRepository>()))
                    ], child: CustomPaymentMethods()),
                    AppStrings.choosePaymentMethod.tr());
              });
            } else if (state is LoadingPaymentAddressState) {
              Center(
                  child: CircularProgressIndicator(
                color: AppColor.primaryAmwaj,
              ));
            } else if (state is ErrorPaymentAddressState) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                customAwesomeDialog(
                    context, state.error.toString(), DialogType.error);
              });
            }
            return Center(
                child: CircularProgressIndicator(
              color: AppColor.primaryAmwaj,
            ));
          }),

          SizedBox(
            height: 25.h,
          ),

          Divider(
            height: 5.h,
            color: AppColor.primaryAmwaj,
          ),

          SizedBox(
            height: 25.h,
          ),
          CustomButton(
            onPressed: () {
              customGeneralDialog(
                  context,
                  BlocProvider(
                    create: (context) => PaymentAddressCubit(
                        paymentAddressRepository:
                            instance<PaymentAddressRepository>()),
                    child:
                        BlocBuilder<PaymentAddressCubit, PaymentAddressStates>(
                      builder: (context, state) {
                        if (state is SuccessSaveNewPaymentAddressState) {
                          showToast(
                              text: AppStrings.addSuccessfully.tr(),
                              color: ToastColors.SUCCESS);
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            customGeneralDialog(
                                context,
                                BlocProvider(
                                  create: (context) => PaymentMethodsCubit(
                                      paymentMethodRepository:
                                          instance<PaymentMethodRepository>())
                                    ..getPaymentMethodCubit(),
                                  child: CustomPaymentMethods(),
                                ),
                                AppStrings.choosePaymentMethod.tr());
                          });
                        } else if (state is ErrorPaymentAddressState) {
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            customAwesomeDialog(context, state.error.toString(),
                                DialogType.error);
                          });
                        }
                        return SingleChildScrollView(
                            child: CustomPaymentAddress());
                      },
                    ),
                  ),
                  AppStrings.addNewAddress.tr());
            },
            color:
                context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
            height: 40.h,
            width: 120.w,
            elevation: 2.0,
            textStyle: textStyleCustom(
              fontSize: 12.sp,
              fontColor:Colors.white,
            ),
            title: AppStrings.addNewAddress.tr(),
            radius: 10.r,
          ),
        ],
      ),
    );
  }
}
