import 'package:resort_store/business_logic/login/cubit.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../business_logic/change_theme/cubit.dart';
import '../../../../core/constants/strings_app.dart';
import '../../../resources/color_manger.dart';
import '../../../widgets/custom_padding.dart';
import '../../../widgets/custom_textFeild.dart';
import '../../../widgets/custom_toast.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailNode;
  final FocusNode passwordNode;
  final GlobalKey<FormState> formKey;

  LoginForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.emailNode,
    required this.passwordNode,
    required this.formKey,
  }) : super(key: key);

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return CustomPadding.symmetric(
      horizontal: 16.sp,
      vertical: 10.sp,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(AppStrings.login.tr(),style: mediumTextStyle(fontSize: 18.sp, color: AppColor.white,height: 0.1)),
            Text(AppStrings.welcomeBack.tr(),style: mediumTextStyle(fontSize: 18.sp, color: AppColor.white)),

            SizedBox(height: 15.h,),
            //TODO: email field
            CustomTextField(
              radius: 8.r,
              controller: emailController,
              labelTextStyle: mediumTextStyle(fontSize: 13.sp, color: AppColor.white),
              cursorColor: AppColor.white,
              textStyle: mediumTextStyle(fontSize: 13.sp, color: AppColor.white),
              focusNode: emailNode,
              nextNode: passwordNode,
              containerColor: context.read<ThemeDataCubit>().recolor ??
                  AppColor.primaryAmwaj,
              hintText: '',
              labelText: AppStrings.email.tr(),

              height: 40.h,
              validator: (value) {
                if (value!.isEmpty) {
                  showToast(
                      text: "${AppStrings.pleaseEnter.tr()} "
                          " ${AppStrings.email.tr()}",
                      color: ToastColors.WARNING);
                }
                return null;
              },
              borderColor: AppColor.white,
              width: 300.w,
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.r),
                  ),
                  borderSide: BorderSide(color: AppColor.white)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  borderSide: BorderSide(color: AppColor.white)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  borderSide: BorderSide(color: AppColor.white)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  borderSide: BorderSide(color: Colors.white)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  borderSide: BorderSide(color: Colors.white)),
            ),
            SizedBox(height: 18.h),
            //TODO: password field

            CustomTextField(
              controller: passwordController,
              focusNode: passwordNode,
              labelTextStyle: mediumTextStyle(fontSize: 13.sp, color: AppColor.white),
              cursorColor: AppColor.white,
              textStyle: mediumTextStyle(fontSize: 13.sp, color: AppColor.white),
              isSecure: context.read<LoginCubit>().isSecure,
              containerColor: context.read<ThemeDataCubit>().recolor ??
                  AppColor.primaryAmwaj,
              hintText: '',
              labelText: AppStrings.password.tr(),
              height: 40.h,
              suffixIcon: CustomPadding.symmetric(
                horizontal: 10,
                child: IconButton(
                    onPressed: () {
                      context.read<LoginCubit>().changeSecureCubit();
                    },
                    icon: context.read<LoginCubit>().isSecure
                        ? Icon(Icons.visibility_off,
                        color: AppColor.primaryLight, size: 20.sp)
                        : Icon(Icons.visibility,
                        color: AppColor.primaryLight, size: 20.sp)),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  showToast(
                      text:
                      "${AppStrings.pleaseEnter.tr()} ${AppStrings.password.tr()}",
                      color: ToastColors.WARNING);
                }
                return null;
              },
              borderColor: AppColor.white,
              width: 300.w,
              radius: 8.r,
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: AppColor.white)),
              enabled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.white)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.white)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
