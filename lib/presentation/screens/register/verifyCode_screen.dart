import 'package:resort_store/presentation/screens/register/widgets/resend_code.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/strings_app.dart';
import '../../../core/helpers/app_router.dart';
import '../../resources/color_manger.dart';
import '../../resources/textStyle_manger.dart';
import '../../widgets/dialog/custom_alert_dailog.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_cliper.dart';
import '../../widgets/custom_reset_password.dart';
import '../../widgets/custom_textFeild.dart';
import '../../widgets/custom_toast.dart';

class VerifyCodeScreen extends StatelessWidget {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _key = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //TODO : Clip Shape
            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                  height: 150.h,
                  width: double.infinity,
                  color: AppColor.primaryAmwaj),
            ),
            //TODO: TEXT
            Text(AppStrings.pleaseEnterCode.tr(),
                style:
                boldTextStyle(fontSize: 20.0, color: AppColor.black)),
            // TODO : code Feild
            SizedBox(
              height: 20.h,
            ),
            Form(
              key: _key,
              child: Column(
                children: [
                  //TODO: User Name
                  CustomTextField(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: AppColor.primaryAmwaj, width: 0.5),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.grey, width: 0.5),
                    ),
                    height: 60.h,
                    controller: _nameController,
                    prefixIcon: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.primaryAmwaj,
                      ),
                      child: Icon(Icons.person,
                          color: AppColor.white, size: 20.sp),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        showToast(
                            text: "Please Enter Your user Name",
                            color: ToastColors.WARNING);
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    labelText:"",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  //TODO: Code verfiy
                  CustomTextField(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: AppColor.primaryAmwaj, width: 0.5),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.grey, width: 0.5),
                    ),
                    height: 60.h,
                    controller: _codeController,
                    prefixIcon: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.primaryAmwaj,
                      ),
                      child: Icon(Icons.code,
                          color: AppColor.white, size: 20.sp),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        showToast(
                            text: "Please Enter Your Code",
                            color: ToastColors.WARNING);
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    labelText: AppStrings.code,
                  )
                ],
              ),
            ),
            //TODO : Resend Code
            SizedBox(
              height: 10.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppStrings.ifNotReceiveCode,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.black,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  width: 5.w,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomAlertDialog(
                        image:"",
                        widget: CustomResendCode(),
                        title: AppStrings.resendCode,
                      ),
                    );
                  },
                  child: Text(
                    AppStrings.resendCode.tr(),
                    textAlign: TextAlign.center,
                    style: boldTextStyle(
                        fontSize: 15.0, color: AppColor.primaryAmwaj),
                  ),
                ),
              ],
            ),
            //TODO: Send
            SizedBox(height: 250.h),
            CustomButton(
              onPressed: () {

              },
              color: AppColor.primaryAmwaj,
              elevation: 5.0,
              width: 180.w,
              height: 50.h,
              radius: 50.0,
              title: AppStrings.send.tr().toUpperCase(),
              textStyle: boldTextStyle(
                color: AppColor.white,
                fontSize: 15.0,
              ),
              horizontalMargin: 22,
              verticalPadding: 8,
            ),
            //TODO : Cancel
            SizedBox(
              height: 15.h,
            ),
            CustomButton(
              onPressed: () {
                AppRouter.back(context);
              },
              color: AppColor.white,
              elevation: 5.0,
              width: 180.w,
              height: 35.h,
              radius: 50.0,
              title: AppStrings.cancel.tr().toUpperCase(),
              textStyle: boldTextStyle(
                color: AppColor.primaryAmwaj,
                fontSize: 15.0,
              ),
              horizontalMargin: 22,
              verticalPadding: 8,
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
