import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/strings_app.dart';
import '../../../resources/color_manger.dart';
import '../../../resources/size_manger.dart';
import '../../../resources/textStyle_manger.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textFeild.dart';

class CustomResendCode extends StatelessWidget {
  final TextEditingController _userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Form(
          child: Column(
        children: [
          //TODO: phoneNumber field
          CustomTextField(
            controller: _userName,
            hintText: '',
            labelText: "",
            height: 60.h,
            width: 200.w,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.border,
                width: 0.7.w,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.r),
              ),
            ),
            prefixIcon: Icon(Icons.person, color: AppColor.primaryAmwaj),
          ),
          SizedBox(
            height: 5.h,
          ),
          SizedBox(
            height: 15.h,
          ),
          CustomButton(
            onPressed: () {},
            color: AppColor.primaryAmwaj,
            elevation: 5.0,
            width: 120.w,
            height: 50.h,
            radius: 10.0,
            title: AppStrings.send.tr(),
            textStyle: boldTextStyle(
              color: AppColor.white,
              fontSize: 15.0,
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      )),
    );
  }
}
