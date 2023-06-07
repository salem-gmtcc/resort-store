import 'package:resort_store/business_logic/order/cubit.dart';
import 'package:resort_store/business_logic/order/state.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/textStyle_helper.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/screens/myOrder/widgets/custom_build_container_feild.dart';
import 'package:resort_store/presentation/screens/myOrder/widgets/custom_build_text.dart';
import 'package:resort_store/presentation/widgets/background.dart';
import 'package:resort_store/presentation/widgets/custom_button.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/change_theme/cubit.dart';
import '../../../core/helpers/saved_theme.dart';

class ReasonReturnOrderScreen extends StatefulWidget {
  Map data;

  ReasonReturnOrderScreen({required this.data});

  @override
  State<ReasonReturnOrderScreen> createState() =>
      _ReasonReturnOrderScreenState();
}

class _ReasonReturnOrderScreenState extends State<ReasonReturnOrderScreen> {
  List<String> texts = [
    AppStrings.othersPleaseExplain.tr(),
    AppStrings.iReceivedDifferentProductThanIOrdered.tr(),
    AppStrings.productArrivedToMeDamaged.tr(),
    AppStrings.thereErrorInMyOrder.tr(),
    AppStrings.ThereErrorPleaseExplain.tr()
  ];

  String selectValue = "";
  String selectValue1 = "";
  int value = 1;

  TextEditingController? firstName;

  TextEditingController? lastName;

  TextEditingController? email;

  TextEditingController? phone;

  TextEditingController? orderNo;

  TextEditingController? orderDate;

  TextEditingController? productName;

  TextEditingController? productType;

  TextEditingController? quantity;

  TextEditingController? selectValueText;
  TextEditingController? selectValueText2;
  TextEditingController? comment;

  @override
  void initState() {
    print(
        "**************************************** :${widget.data[productName]}");
    // TODO: implement initState
    firstName = TextEditingController(text: widget.data["firstname"]);
    lastName = TextEditingController(text: widget.data["lastname"]);
    email = TextEditingController(text: widget.data["email"]);
    phone = TextEditingController(text: widget.data["phone"]);
    orderNo = TextEditingController(text: widget.data["order_id"]);
    orderDate = TextEditingController();
    productName = TextEditingController(text: widget.data["productName"]);
    productType = TextEditingController(text: widget.data["model"]);
    quantity = TextEditingController(text: widget.data["quantity"]);
    selectValueText = TextEditingController();
    comment = TextEditingController();
    selectValueText2 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    firstName!.dispose();
    lastName!.dispose();
    email!.dispose();
    phone!.dispose();
    orderNo!.dispose();
    orderDate!.dispose();
    productName!.dispose();
    productType!.dispose();
    quantity!.dispose();
    selectValueText!.dispose();
    comment!.dispose();
    selectValueText2!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor:
            context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
        title: Text(AppStrings.reasonReturnOrder.tr(),
            style: textStyleCustom(fontSize: 18.sp)),
      ),
      body: BlocBuilder<OrderCubit, OrderStates>(
        builder: (context, state) {
          if (state is SendReturnOrderState) {
            showToast(
                text: AppStrings.returnOrderSuccessfully.tr(),
                color: ToastColors.SUCCESS);
          } else if (state is OrderErrorState) {
            showToast(text: state.e.toString(), color: ToastColors.ERROR);
          }
          return BackGround(
              widget: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    //TODO: Order Details
                    CustomPadding.symmetric(
                        horizontal: 10.0,
                        child: Text(
                          AppStrings.orderDetails.tr(),
                          style: textStyleCustom(
                              fontSize: 18.sp, fontColor: AppColor.primaryLight),
                        )),
                    CustomPadding.symmetric(
                      horizontal: 10.0,
                      child: Container(
                        height: 250.h,
                        width: 500.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColor.primaryLight)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            //TODO : FirstName ,
                            CustomPadding.symmetric(
                              horizontal: 8.sp,
                              child: Row(
                                children: [
                                  CustomBuildText(
                                      text: AppStrings.firstName.tr()),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomBuildContainerField(
                                      textEditingController: firstName,
                                      hintText: widget.data["firstname"]),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            //TODO : LastName ,
                            CustomPadding.symmetric(
                              horizontal: 8.sp,
                              child: Row(
                                children: [
                                  CustomBuildText(
                                      text: AppStrings.lastName.tr()),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomBuildContainerField(
                                      textEditingController: lastName,
                                      hintText: widget.data["lastname"]),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            //TODO : email ,
                            CustomPadding.symmetric(
                              horizontal: 8.sp,
                              child: Row(
                                children: [
                                  CustomBuildText(text: AppStrings.email.tr()),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomBuildContainerField(
                                      textEditingController: email,
                                      hintText: widget.data["email"]),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            //TODO : Phone Number ,
                            CustomPadding.only(
                              left: 3.w,
                              right: 3.w,
                              child: Row(
                                children: [
                                  CustomBuildText(
                                      text: AppStrings.phoneNumber.tr()),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  CustomBuildContainerField(
                                      textEditingController: phone,
                                      hintText: widget.data["phone"]),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            //TODO : order Number ,
                            CustomPadding.symmetric(
                              horizontal: 8.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h, width: 10.w),
                                  CustomBuildText(
                                      text: AppStrings.orderNo.tr()),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomBuildContainerField(
                                      textEditingController: orderNo,
                                      hintText: widget.data["order_id"]),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            //TODO : order Date ,
                            CustomPadding.symmetric(
                              horizontal: 8.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h, width: 10.w),
                                  CustomBuildText(text: AppStrings.date.tr()),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomBuildContainerField(
                                      textEditingController: orderDate,
                                      hintText: widget.data["date"]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    //TODO: Product Details
                    CustomPadding.symmetric(
                        horizontal: 10.0,
                        child: Text(
                          AppStrings.productDetails.tr(),
                          style: mediumTextStyle(
                              fontSize: 18.0, color: AppColor.primaryLight),
                        )),
                    CustomPadding.symmetric(
                      horizontal: 10.0,
                      child: Container(
                        height: 150.h,
                        width: 350.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColor.primaryLight)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            //TODO : product Name ,
                            CustomPadding.symmetric(
                              horizontal: 8.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomBuildText(text: AppStrings.name.tr()),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: CustomBuildContainerField(
                                        textEditingController: productName,
                                        hintText: widget.data["productName"]),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            //TODO : Product Type ,
                            CustomPadding.symmetric(
                              horizontal: 8.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h, width: 10.w),
                                  Expanded(
                                      child: CustomBuildText(
                                          text: AppStrings.type.tr())),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                      child: CustomBuildContainerField(
                                          textEditingController: productType,
                                          hintText: widget.data["model"])),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            //TODO : Quantity
                            CustomPadding.symmetric(
                              horizontal: 8.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h, width: 10.w),
                                  CustomBuildText(
                                      text: AppStrings.quantity.tr()),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomBuildContainerField(
                                      textEditingController: quantity,
                                      hintText: widget.data["quantity"]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 15.h,
                    ),
                    //TODO: Product Details
                    CustomPadding.symmetric(
                        horizontal: 10.w,
                        child: Text(
                          AppStrings.reasonReturnOrder.tr(),
                          style: textStyleCustom(
                              fontSize: 18.sp, fontColor: AppColor.primaryLight),
                        )),
                    CustomPadding.symmetric(
                      horizontal: 10.w,
                      child: Container(
                        height: 200.h,
                        width: 350.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColor.primaryLight)),
                        child: ListView.builder(
                            itemCount: texts.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CustomPadding.symmetric(
                                horizontal: 2.0,
                                vertical: 5.0,
                                child: RadioListTile(
                                    activeColor: AppColor.primaryLight,
                                    title: Text(texts[index],
                                        style: mediumTextStyle(
                                            fontSize: 13.0,
                                            color: AppColor.white)),
                                    value: texts[index],
                                    groupValue: selectValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectValue = value!;
                                        print("  ************** $value");
                                        value = selectValueText!.text;
                                        print(
                                            "    value ${selectValueText!.text}");
                                      });
                                    }),
                              );
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    //TODO: OPEN Order ?
                    CustomPadding.symmetric(
                      horizontal: 10.w,
                      child: Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColor.primaryLight)),
                        child: Row(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(
                                right: 3.w,
                                left: 3.w,
                                top: 3.h,
                                bottom: 3.h
                              ),
                              child: Text(
                                "${AppStrings.openOrder.tr()} ?",
                                style: textStyleCustom(
                                    fontSize: 15.sp,
                                    fontColor: AppColor.primaryLight),
                              ),
                            ),
                            SizedBox(
                              width: 115.w,
                              child: RadioListTile(
                                activeColor: AppColor.white,
                                title: Text(AppStrings.yes.tr(),
                                    style: textStyleCustom(
                                        fontSize: 12.sp, fontColor: AppColor.white)),
                                value: "Yes",
                                groupValue: selectValue1,
                                onChanged: (value) {
                                  setState(() {
                                    print(
                                        "************************************************************************ $value");
                                    selectValue1 = value!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 115.w,
                              child: RadioListTile(
                                activeColor: AppColor.white,
                                title: Text(AppStrings.no.tr(),
                                    style: textStyleCustom(
                                        fontSize: 12.sp, fontColor: AppColor.white)),
                                value: "No",
                                groupValue: selectValue1,
                                onChanged: (value) {
                                  setState(() {
                                    selectValue1 = value!;
                                    print(
                                        "************************************************************************ $value");
                                    value = selectValueText2!.text;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    //TODO: Another Comment
                    CustomPadding.symmetric(
                        horizontal: 10.w,
                        child: Text(
                          "${AppStrings.anotherComment.tr()} :",
                          style: mediumTextStyle(
                              fontSize: 15.sp, color: AppColor.primaryLight),
                        )),
                    CustomPadding.symmetric(
                      vertical: 5.0.h,
                      horizontal: 5.0.w,
                      child: Container(
                        height: 100.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: AppColor.primaryLight),
                        ),
                        child: TextField(
                          controller: comment,
                          cursorColor: AppColor.white,
                          style: textStyleCustom(
                              fontSize: 12.sp, fontColor: AppColor.white),
                          decoration: const InputDecoration(
                              hintText: "",
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: CustomButton(
                        onPressed: () {
                          print("*****************1 ${selectValue}");
                          print("*****************2 ${selectValueText2!.text}");
                          context.read<OrderCubit>().sendOrderReturnCubit({
                            "firstname": firstName!.text,
                            "lastname": lastName!.text,
                            "email": email!.text,
                            "telephone": phone!.text,
                            "date_ordered": orderDate!.text,
                            "order_id": orderNo!.text,
                            "product": productName!.text,
                            "model": productType!.text,
                            "return_reason_id": selectValue,
                            "opened": selectValue1,
                            "quantity": quantity!.text,
                            "comment": comment!.text
                          });
                        },
                        title: AppStrings.send.tr(),
                        height: 40.h,
                        width: 100.w,
                        radius: 10.r,
                        elevation: 0.5,
                        color: context.read<ThemeDataCubit>().recolor ??
                            AppColor.primaryAmwaj,
                        textStyle: textStyleCustom(
                            fontSize: 18.sp, fontColor: AppColor.white),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
              if (state is OrderLoadingState)
                Center(
                  child: CircularProgressIndicator(color: AppColor.white),
                )
            ],
          ));
        },
      ),
    );
  }
}
