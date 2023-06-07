import 'package:resort_store/business_logic/change_theme/cubit.dart';
import 'package:resort_store/business_logic/return_order/cubit.dart';
import 'package:resort_store/business_logic/return_order/state.dart';
import 'package:resort_store/core/constants/route_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/core/helpers/textStyle_helper.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/background.dart';
import 'package:resort_store/presentation/widgets/custom_loading.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helpers/saved_theme.dart';


import '../../resources/color_manger.dart';

class ReturnOrder extends StatelessWidget {
  const ReturnOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
        title: Text(AppStrings.returnOrder.tr(),
            style: textStyleCustom(fontSize: 18.sp, fontColor: AppColor.white)),
        elevation: 0.0,
      ),
      body: BlocBuilder<ReturnOrderCubit, ReturnOrderStates>(
        builder: (context, state) {
          if (state is SuccessReturnOrderState) {
            print("********************* success ");
            if (state.returnOrderModel.data!.isNotEmpty) {
              return BackGround(
                widget: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        AppRouter.to(context, RouteConstants.returnOrderDetails,
                            arguments:
                            state.returnOrderModel.data![index].returnId);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 80.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: AppColor.primaryLight)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                  state.returnOrderModel.data![index].dateAdded
                                      .toString()
                                      .substring(19, 40),
                                  style: textStyleCustom(
                                      fontSize: 15.sp, fontColor: AppColor.white)),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                  "${AppStrings.orderNumber.tr()} : ${state.returnOrderModel.data![index].orderId.toString()}",
                                  style: textStyleCustom(
                                      fontSize: 14.sp,
                                      fontColor: AppColor.primaryLight)),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                  state.returnOrderModel.data![index].status
                                      .toString(),
                                  style: textStyleCustom(
                                      fontSize: 14.sp,
                                      fontColor: AppColor.primaryLight)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: state.returnOrderModel.data!.length,
                ),
              );
            } else {
              return  Center(
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
          } else if (state is ErrorReturnOrderState) {
            showToast(text: state.error.toString(), color: ToastColors.ERROR);
          } else if (state is LoadingReturnOrderState) {
            Center(
                child: CircularProgressIndicator(
              color: AppColor.white,
            ));
          }
          return Center(
              child: CircularProgressIndicator(
            color: AppColor.white,
          ));
        },
      ),
    );
  }
}
