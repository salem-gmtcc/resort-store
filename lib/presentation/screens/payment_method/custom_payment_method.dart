import 'package:resort_store/business_logic/cart/cubit.dart';
import 'package:resort_store/business_logic/change_theme/cubit.dart';
import 'package:resort_store/business_logic/main/cubit.dart';
import 'package:resort_store/business_logic/order/cubit.dart';
import 'package:resort_store/business_logic/payment_method/cubit.dart';
import 'package:resort_store/business_logic/payment_method/state.dart';
import 'package:resort_store/core/constants/route_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/core/helpers/textStyle_helper.dart';
import 'package:resort_store/data/repository/order/order.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/custom_button.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:resort_store/presentation/widgets/dialog/custom_general_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../business_logic/order/state.dart';
import '../../../data/repository/cart/cart.dart';
import '../../widgets/dialog/custom_awesome_dialog.dart';


class CustomPaymentMethods extends StatefulWidget {
  @override
  State<CustomPaymentMethods> createState() => _CustomPaymentMethodsState();
}

class _CustomPaymentMethodsState extends State<CustomPaymentMethods> {
  String? selectValue ;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OrderCubit(confirmOrderRepository: instance<ConfirmOrderRepository>())),

        BlocProvider(create: (context) => CartCubit(
                cartRepository: instance<CartRepository>())),
      ],
      child: BlocBuilder<PaymentMethodsCubit, PaymentMethodStates>(
        builder: (context, state) {
          if (state is SuccessFinalPayMethodState) {
            print("------------------------------------------------------- 1");
            //TODO :  Dialog 1

            //TODO : Close This Dialog 1
            // print("-------------------------------------------- 1");
            // //TODO: Here i want open Dialog 2
            // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            //   AwesomeDialog(
            //     context: context,
            //     dialogType: DialogType.question,
            //     animType: AnimType.rightSlide,
            //     title: AppStrings.AreYouSureToPay.tr(),
            //     btnOk: OutlinedButton(
            //       style: ButtonStyle(
            //         elevation: MaterialStateProperty.all(2.0),
            //         backgroundColor: MaterialStateProperty.all(AppColor.green),
            //       ),
            //       onPressed: () {
            //         print("----------------------------------------------- Success !!!!");
            //         context.read<OrderCubit>().confirmFinalOrderCubit();
            //       },
            //       child: Text("Ok",
            //           style: mediumTextStyle(
            //               fontSize: 15.sp, color: AppColor.white)),
            //     ),
            //     btnCancel: OutlinedButton(
            //       onPressed: () {
            //         print("******************************* back");
            //         AppRouter.back(context);
            //       },
            //       child: Text("Cancel",
            //           style: mediumTextStyle(
            //               fontSize: 15.sp, color: AppColor.white)),
            //       style: ButtonStyle(
            //         elevation: MaterialStateProperty.all(2.0),
            //         backgroundColor: MaterialStateProperty.all(AppColor.red),
            //       ),
            //     ),
            //   )
            //     ..show();
            // });

            //
            //   //TODO : Dialog 2   => Write Code here after Dialog 1  build open Dialog 2
               WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                 customGeneralDialog(context, MultiBlocProvider(
                   providers: [
                     BlocProvider(
                         create: (context) => OrderCubit(
                             confirmOrderRepository:
                             instance<ConfirmOrderRepository>())),
                     BlocProvider(
                         create: (context) => CartCubit(
                             cartRepository: instance<CartRepository>()))
                   ],
                   child: BlocBuilder<OrderCubit, OrderStates>(
                     builder: (context, state) {
                       if (state is FinalOrderSuccessState) {
                         // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                         //   customAwesomeDialog(context, "Create Order Successfully",DialogType.success);
                         // });
                         showToast(text: "Create Order Successfully", color: ToastColors.SUCCESS).then((value){
                         AppRouter.offNamed(context, RouteConstants.main);
                           context.read<MainCubit>().changeBottomNavBar(2);
                           context.read<CartCubit>().getCartCubit();
                         });

                       } else if (state is OrderErrorState) {
                         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                           customAwesomeDialog(context,"No order in session",DialogType.error);
                         });
                       }
                       return Stack(
                         children: [
                           Center(
                             child: Column(
                               children: [
                                 Icon(Icons.question_mark_rounded,color: AppColor.primaryAmwaj,size: 120.sp,),
                                 SizedBox(height: 100.h,),
                                 Row(
                                   mainAxisAlignment:
                                   MainAxisAlignment.center,
                                   crossAxisAlignment:
                                   CrossAxisAlignment.center,
                                   children: [
                                     CustomButton(
                                       onPressed: () {
                                         AppRouter.back(context);
                                       },
                                       width: 120.w,
                                       height: 40.h,
                                       color: AppColor.red,
                                       elevation: 0.0,
                                       radius: 10.r,
                                       title: AppStrings.cancel.tr(),
                                       textStyle: mediumTextStyle(
                                           fontSize: 15.sp,
                                           color: AppColor.white),
                                     ),
                                     SizedBox(
                                       width: 10.w,
                                     ),
                                     CustomButton(
                                       onPressed: () {
                                         context
                                             .read<OrderCubit>()
                                             .confirmFinalOrderCubit();
                                         print("*************************************************************-");
                                       },
                                       height: 40.h,
                                       width: 120.w,
                                       color: context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
                                       elevation: 0.0,
                                       radius: 10.r,
                                       title: AppStrings.confirm.tr(),
                                       textStyle: mediumTextStyle(
                                           fontSize: 15.sp,
                                           color: AppColor.white),
                                     ),
                                   ],
                                 ),
                               ],
                             ),
                           ),
                           if (state is OrderLoadingState)
                             Center(
                               child: CircularProgressIndicator(
                                   color: AppColor.primaryAmwaj),
                             )
                         ],
                       );
                     },
                   ),
                 ), AppStrings.AreYouSureToPay.tr());
               });
          }
          if (state is SuccessPaymentMethodState) {
            return Column(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.paymentMethodModel.getPaymentMethodModel!
                      .paymentMethodDataModel!.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                        activeColor: AppColor.primaryAmwaj,
                        value: state.paymentMethodModel.getPaymentMethodModel!
                            .paymentMethodDataModel![index].sortOrder,
                        groupValue: selectValue,
                        title: Text(state
                            .paymentMethodModel
                            .getPaymentMethodModel!
                            .paymentMethodDataModel![index]
                            .title
                            .toString()),
                        onChanged: (value) {
                          setState(() {
                            selectValue = value!;
                          });
                        });
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomButton(
                    color: context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
                    title: AppStrings.ok.tr(),
                    textStyle:
                        textStyleCustom(fontSize: 15.sp, fontColor: AppColor.white),
                    height: 40.h,
                    width: 120.w,
                    radius: 10.r,
                    elevation: 1.0,
                    onPressed: () {
                      if(selectValue != null){
                        context.read<PaymentMethodsCubit>().finalPayMethodCubit();
                      }else {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          customAwesomeDialog(context, AppStrings.choosePaymentMethod.tr(), DialogType.warning);
                        });
                      }

                    })
              ],
            );
          } else if (state is ErrorPaymentMethodState) {
            showToast(text: state.error.toString(), color: ToastColors.ERROR);
          }

          else if (state is LoadingPaymentMethodState) {
            Center(
              child: CircularProgressIndicator(color: AppColor.primaryAmwaj),
            );
          }
          return CircularProgressIndicator(
            color: AppColor.primaryAmwaj,
          );
        },
      ),
    );
  }
}
