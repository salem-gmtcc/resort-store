import 'package:resort_store/business_logic/main/cubit.dart';
import 'package:resort_store/core/constants/route_constant.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/screens/address_payment/custom_payment_address.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

customGeneralDialog(ctx,Widget widget,String title) {
  return showGeneralDialog(
    context: ctx,
    barrierDismissible: true,
    barrierColor: Colors.black12.withOpacity(0.6),
    // Background color
    barrierLabel: 'Dialog',
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return Dialog(
        child: Container(
          height: 500.h,
          child: SingleChildScrollView(
            child: Column( 
              children: [
                CustomPadding.symmetric(
                  vertical: 5.h,
                  horizontal: 8.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () {
                        print("********************");
                        AppRouter.back(_);}
                          , icon: Icon(Icons.arrow_back)),
                      Text(title,style: mediumTextStyle(fontSize: 15.sp, color: AppColor.primaryAmwaj),),
                      SizedBox.shrink()
                      // IconButton(onPressed: () {
                      //   ctx.read<MainCubit>().changeBottomNavBar(3);
                      // }, icon: Icon(Icons.close))
                    ],
                  ),
                ),
                widget,
              ],
            ),
          ),
        ),
      );
    },
  );
}
