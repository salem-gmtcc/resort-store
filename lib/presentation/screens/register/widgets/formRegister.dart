import 'package:resort_store/business_logic/change_theme/cubit.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../business_logic/register/cubit.dart';
import '../../../../core/constants/strings_app.dart';
import '../../../../core/helpers/saved_theme.dart';
import '../../../resources/color_manger.dart';
import '../../../widgets/custom_padding.dart';
import '../../../widgets/custom_textFeild.dart';
import '../../../widgets/custom_toast.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final FocusNode firstNameNode;
  final FocusNode lastNameNode;
  final FocusNode passwordNode;
  final FocusNode confirmPasswordNode;
  final FocusNode phoneNode;
  final GlobalKey<FormState> formKey;

  const RegisterForm({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
    required this.emailController,
    required this.firstNameNode,
    required this.lastNameNode,
    required this.passwordNode,
    required this.confirmPasswordNode,
    required this.phoneNode,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TODO: firstName
          CustomTextField(
            controller: firstNameController,
            focusNode: firstNameNode,
            nextNode: lastNameNode,
            labelTextStyle: mediumTextStyle(fontSize: 13.sp, color: AppColor.white),
            cursorColor: AppColor.white,
            textStyle: mediumTextStyle(fontSize: 13.sp, color: AppColor.white),
            containerColor:
                context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
            hintText: '',
            labelText: AppStrings.firstName.tr(),
            height: 35.h,
            validator: (value) {
              if (value!.isEmpty) {
                showToast(
                    text: "${AppStrings.pleaseEnter.tr()} "
                        " ${AppStrings.name.tr()}",
                    color: ToastColors.WARNING);
              }
              return null;
            },
            borderColor: AppColor.white,
            width: 250.w,
            radius: 10.r,
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            enabled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
          ),
          //TODO: lastName
          SizedBox(
            height: 10.h,
          ),
          CustomTextField(
            controller: lastNameController,
            focusNode: lastNameNode,
            nextNode: phoneNode,
            labelTextStyle: mediumTextStyle(fontSize: 13.sp, color: AppColor.white),
            cursorColor: AppColor.white,
            textStyle: mediumTextStyle(fontSize: 13.sp, color: AppColor.white),
            containerColor:
                context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
            hintText: '',
            labelText: AppStrings.lastName.tr(),
            radius: 10.r,
            height: 35.h,
            validator: (value) {
              if (value!.isEmpty) {
                showToast(
                    text: "${AppStrings.pleaseEnter.tr()} "
                        " ${AppStrings.name.tr()}",
                    color: ToastColors.WARNING);
              }
              return null;
            },
            borderColor: AppColor.white,
            width: 250.w,
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            enabled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
          ),
          //TODO: phone field
          SizedBox(height: 10.h),
          SizedBox(
            height: 60.h,
            width: 250.w,
            child: IntlPhoneField(
              cursorColor: AppColor.primaryLight,
              dropdownTextStyle:
                  mediumTextStyle(color: AppColor.primaryLight, fontSize: 18.0),
              validator: (val) {
                if (val!.number.isEmpty) {
                  showToast(
                      text: "${AppStrings.pleaseEnter.tr()}"
                          " ${AppStrings.phoneNumber.tr()}",
                      color: ToastColors.WARNING);
                }
                return;
              },
              controller: phoneController,
              enabled: true,
              style:
                  mediumTextStyle(fontSize: 18.0, color: AppColor.primaryLight,height: 1.2                                                .h),
              decoration: InputDecoration(

                filled: true,
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppColor.primaryLight)),
                hintStyle: mediumTextStyle(
                    fontSize: 18.0, color: AppColor.primaryLight),
                focusColor: AppColor.white,
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppColor.primaryLight)),
                enabled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppColor.primaryLight)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppColor.primaryLight)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppColor.primaryLight)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppColor.primaryLight)),
              ),
              onChanged: (phone) {
                print(phone.completeNumber);
              },
              initialCountryCode: "SA",
              onCountryChanged: (country) {
                print('Country changed to: ' + country.name);
              },
            ),
          ),
          //TODO: Email
          SizedBox(
            height: 5.h,
          ),
          CustomTextField(
            controller: emailController,
            nextNode: phoneNode,
            labelTextStyle: mediumTextStyle(fontSize: 13.sp, color: AppColor.white),
            cursorColor: AppColor.white,
            textStyle: mediumTextStyle(fontSize: 13.sp, color: AppColor.white),
            containerColor:
                context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
            radius: 10.r,
            hintText: '',
            labelText: AppStrings.email.tr(),
            height: 35.h,
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
            width: 250.w,
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            enabled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
          ),
          SizedBox(
            height: 10.h,
          ),
          //TODO: password field
          CustomTextField(
            controller: passwordController,
            focusNode: passwordNode,
            nextNode: confirmPasswordNode,
            labelTextStyle: mediumTextStyle(fontSize: 13.sp, color: AppColor.white),
            cursorColor: AppColor.white,
            textStyle: mediumTextStyle(fontSize: 13.sp, color: AppColor.white),
            containerColor:
                context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
            hintText: '',
            radius: 10.r,
            isSecure: context.read<RegisterCubit>().isSecure,
            suffixIcon: CustomPadding.symmetric(
              horizontal: 10,
              child: IconButton(
                  onPressed: () {
                    context.read<RegisterCubit>().changeSecureCubit();
                  },
                  icon: context.read<RegisterCubit>().isSecure
                      ? Icon(Icons.visibility_off,
                          color: AppColor.primaryLight, size: 20.sp)
                      : Icon(Icons.visibility,
                          color: AppColor.primaryLight, size: 20.sp)),
            ),
            labelText: AppStrings.password.tr(),
            height: 35.h,
            validator: (value) {
              if (value!.isEmpty) {
                showToast(
                    text: "${AppStrings.pleaseEnter.tr()} "
                        " ${AppStrings.password.tr()}",
                    color: ToastColors.WARNING);
              }
              return null;
            },
            borderColor: AppColor.white,
            width: 250.w,
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            enabled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
          ),
          SizedBox(height: 15.h),
          //TODO: confirm password field
          CustomTextField(
            controller: confirmPasswordController,
            focusNode: confirmPasswordNode,
            labelTextStyle: mediumTextStyle(fontSize: 13.sp, color: AppColor.white),
            cursorColor: AppColor.white,
            textStyle: mediumTextStyle(fontSize: 13.sp, color: AppColor.white),
            containerColor:
                context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
            hintText: '',
            isSecure: context.read<RegisterCubit>().confirmPass,
            radius: 10.r,
            labelText: AppStrings.confirmPassword.tr(),
            height: 35.h,
            suffixIcon: CustomPadding.symmetric(
              horizontal: 10,
              child: IconButton(
                  onPressed: () {
                    context.read<RegisterCubit>().changeSecureConfirmPassCubit();
                  },
                  icon: context.read<RegisterCubit>().confirmPass
                      ? Icon(Icons.visibility_off,
                          color: AppColor.primaryLight, size: 20.sp)
                      : Icon(Icons.visibility,
                          color: AppColor.primaryLight, size: 20.sp)),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                showToast(
                    text: "${AppStrings.pleaseEnter.tr()} "
                        " ${AppStrings.confirmPassword.tr()}",
                    color: ToastColors.WARNING);
              }
              return null;
            },
            borderColor: AppColor.white,
            width: 250.w,
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            enabled: true,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColor.primaryLight)),
          ),
        ],
      ),
    );
  }
}
