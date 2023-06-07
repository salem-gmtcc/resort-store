import 'package:resort_store/business_logic/order/cubit.dart';
import 'package:resort_store/business_logic/order/state.dart';
import 'package:resort_store/core/constants/route_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/core/helpers/textStyle_helper.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/background.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/change_theme/cubit.dart';
import '../../../core/helpers/saved_theme.dart';
import '../../widgets/custom_padding.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
        elevation: 0.0,
        title: Text(AppStrings.myOrder.tr(),
            style: textStyleCustom(fontSize: 18.sp)),
      ),
      body: BackGround(
        widget: Center(child: BlocBuilder<OrderCubit, OrderStates>(
          builder: (context, state) {
            if (state is GetAllOrdersSuccessState) {
               if(state.getOrderModel.orderDataModel!.isNotEmpty){
                 return SizedBox(
                   width: 320.w,
                   child: ListView.builder(
                       scrollDirection: Axis.vertical,
                       physics: const BouncingScrollPhysics(),
                       itemCount: state.getOrderModel.orderDataModel!.length,
                       itemBuilder: (context, index) {
                         return InkWell(

                           onTap: () {
                             print("*********************************** ${state.getOrderModel.orderDataModel![index].orderId}");
                             AppRouter.to(context, RouteConstants.orderDetails,
                                 arguments: state.getOrderModel.orderDataModel![index].orderId);
                           },
                           child: Padding(
                             padding: const EdgeInsets.all(5.0),
                             child: Container(
                               height: 110.h,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10.r),
                                   border: Border.all(color: AppColor.primaryLight)),
                               child: Column(
                                 children: [
                                   SizedBox(
                                     height: 2.h,
                                   ),
                                   Text(
                                       state.getOrderModel.orderDataModel![index]
                                           .dataAdded
                                           .toString()
                                           .substring(19, 40),
                                       style: textStyleCustom(
                                           fontSize: 15.sp)),
                                   CustomPadding.symmetric(
                                     horizontal: 15.sp,
                                     child: Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text(
                                             "${state.getOrderModel.orderDataModel![index].products.toString()} product",
                                             style: textStyleCustom(
                                               fontSize: 12.sp,
                                             )
                                         ),
                                         Text(
                                             state.getOrderModel
                                                 .orderDataModel![index].total
                                                 .toString(),
                                             style: textStyleCustom(
                                               fontSize: 12.sp,
                                             )),
                                       ],
                                     ),
                                   ),
                                   SizedBox(
                                     height: 2.h,
                                   ),
                                   Text(
                                       "Order Number : ${state.getOrderModel.orderDataModel![index].orderId}",
                                       style: textStyleCustom(
                                           fontSize: 12.sp,
                                           fontColor: AppColor.primaryLight)),
                                   SizedBox(
                                     height: 2.h,
                                   ),
                                   Text(
                                       state.getOrderModel.orderDataModel![index]
                                           .status!,
                                       style: textStyleCustom(
                                           fontSize: 15.sp,
                                           fontColor: AppColor.primaryLight)),
                                 ],
                               ),
                             ),
                           ),
                         );
                       }),
                 );
               }else {
                 return Center(
                   child: Column(
                     children: [
                       Image.asset("assets/images/empty_box.png"),
                       Text(AppStrings.noProductFound.tr(),
                           style: mediumTextStyle(fontSize: 13.sp,
                           color: AppColor.black)),
                     ],
                   ),
                 );
               }
            } else if (state is OrderErrorState) {
              showToast(text: state.e.toString(), color: ToastColors.ERROR);
            } else if (state is OrderErrorState) {
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          },
        )),
      ),
    );
  }
}
