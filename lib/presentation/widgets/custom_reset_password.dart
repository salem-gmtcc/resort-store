import 'package:resort_store/core/constants/strings_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../resources/color_manger.dart';
import '../resources/textStyle_manger.dart';
import 'custom_button.dart';
import 'custom_textFeild.dart';



class CustomResetPassword extends StatelessWidget {

  final TextEditingController _phone = TextEditingController();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
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
              enabledBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: AppColor.primaryAmwaj, width: 0.5),
              ),
              focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.5),
              ) ,
              controller:_phone,
              hintText: '',
              labelText: AppStrings.phoneNumber.tr(),
              height: 40.h,
              width: 150.w,
              prefixIcon:Icon(Icons.phone_android,color: AppColor.primaryAmwaj),
            ),
            SizedBox(height: 5.h,),
            //TODO: code field
            CustomTextField(
              enabledBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: AppColor.primaryAmwaj, width: 0.5),
              ),
              focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.5),
              ) ,
              controller:_code,
              keyboardType: TextInputType.number,
              hintText: '',
              labelText: AppStrings.phoneNumber.tr(),
              height: 40.h,
              width: 150.w,
              prefixIcon:Icon(Icons.code,color: AppColor.primaryAmwaj),
            ),
            SizedBox(height: 5.h,),
            //TODO: new password field
            CustomTextField(
              enabledBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: AppColor.primaryAmwaj, width: 0.5),
              ),
              focusedBorder:const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.5),
              ) ,
              controller:_newPassword,
              hintText: '',
              labelText: AppStrings.newPassword.tr(),
              height: 40.h,
              width: 150.w,
              prefixIcon:Icon(Icons.lock,color: AppColor.primaryAmwaj),
            ),
           //TODO : send Request
            SizedBox(height: 15.h,),
          CustomButton(
          onPressed: (){},
          color: AppColor.primaryAmwaj,
          elevation: 5.0,
          width: 120.w,
          height: 30.h,
          radius: 10.0,
          title: AppStrings.sendRequest.tr(),
          textStyle:boldTextStyle(
            color: AppColor.white,
            fontSize: 15.0,
          ),
        ),
            SizedBox(height: 15.h,),
          ],
        )
      ),
    );
  }
}
