import 'package:resort_store/business_logic/shipping_address/cubit.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/data/repository/shipping_address/shipping_address.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/widgets/custom_button.dart';
import 'package:resort_store/presentation/widgets/custom_textFeild.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/textStyle_manger.dart';

class CustomShippingAddress extends StatefulWidget {
  @override
  State<CustomShippingAddress> createState() => _CustomShippingAddressState();
}

class _CustomShippingAddressState extends State<CustomShippingAddress> {
  TextEditingController? _firstName;
  TextEditingController? _lastName;
  TextEditingController? _city;
  TextEditingController? _addressOne;
  TextEditingController? _addressTwo;
  TextEditingController? _countryId;
  TextEditingController? _postcode;
  TextEditingController? _zoneId;

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _city = TextEditingController();
    _addressOne = TextEditingController();
    _addressTwo = TextEditingController();
    _countryId = TextEditingController();
    _postcode = TextEditingController();
    _zoneId = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShippingAddressCubit(
          shippingAddressRepository: instance<ShippingAddressRepository>()),
      child: Form(
        key: _key,
        child: Column(
          children: [
            //TODO: First Name
            CustomTextField(
              controller: _firstName,
              hintText: "",
              borderColor: AppColor.primaryAmwaj,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabled: true,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              labelText: AppStrings.firstName.tr(),
              height: 50.h,
              radius: 10.r,
              validator: (val) {
                if (val!.isEmpty) {
                  return "required";
                }
                return null;
              },
            ),
            SizedBox(height: 10.h,),
            //TODO: Last Name
            CustomTextField(
              controller: _lastName,
              hintText: "",
              borderColor: AppColor.primaryAmwaj,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabled: true,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              height: 50.h,
              radius: 10.r,
              labelText: AppStrings.lastName.tr(),
              validator: (val) {
                if (val!.isEmpty) {
                  return "required";
                }
                return null;
              },
            ),
            SizedBox(height: 10.h,),
            //TODO: city
            CustomTextField(
              controller: _city,
              hintText: "",
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabled: true,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              labelText: AppStrings.city.tr(),
              height: 50.h,
              radius: 10.r,
              validator: (val) {
                if (val!.isEmpty) {
                  return "required";
                }
                return null;
              },
            ),
            SizedBox(height: 10.h,),
            //TODO: address one
            CustomTextField(
              controller: _addressOne,
              hintText: "",
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabled: true,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              height: 50.h,
              radius: 10.r,
              labelText: "${AppStrings.address.tr()} 1",
              validator: (val) {
                if (val!.isEmpty) {
                  return "required";
                }
                return null;
              },
            ),
            SizedBox(height: 10.h,),
            //TODO: address two
            CustomTextField(
              controller: _addressTwo,
              hintText: "",
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabled: true,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              height: 50.h,
              labelText: "${AppStrings.address.tr()} 2",
              radius: 10.r,
              validator: (val) {
                if (val!.isEmpty) {
                  return "required";
                }
                return null;
              },
            ),
            SizedBox(height: 10.h,),
            //TODO: Country id
            CustomTextField(
              controller: _countryId,
              hintText: "",
              labelText: AppStrings.country.tr(),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabled: true,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              height: 50.h,
              radius: 10.r,
              validator: (val) {
                if (val!.isEmpty) {
                  return "required";
                }
                return null;
              },
            ),
            SizedBox(height: 10.h,),
            //TODO: post code
            CustomTextField(
              controller: _postcode,
              hintText: "",
              labelText: AppStrings.postCode.tr(),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabled: true,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              height: 50.h,
              radius: 10.r,
              validator: (val) {
                if (val!.isEmpty) {
                  return "required";
                }
                return null;
              },
            ),
            SizedBox(height: 10.h,),
            //TODO: zone Id
            CustomTextField(
              controller: _zoneId,
              hintText: "",
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              labelText: AppStrings.zone.tr(),
              enabled: true,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              height: 50.h,
              radius: 10.r,
              validator: (val) {
                if (val!.isEmpty) {
                  return "required";
                }
                return null;
              },
            ),
            SizedBox(height: 10.h),
            CustomButton(
                radius: 20.r,
                height: 50.h,
                width: 100.w,
                title: "Send",
                elevation: 5.0,
                color: AppColor.primaryAmwaj,
                textStyle:
                    mediumTextStyle(fontSize: 18.0, color: AppColor.white),
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    context
                        .read<ShippingAddressCubit>()
                        .getShippingAddressCubit({
                      "firstname": _firstName!.text,
                      "lastname": _lastName!.text,
                      "city": _city!.text,
                      "address_1": _addressOne!.text,
                      "address_2": _addressTwo!.text,
                      "country_id": _countryId!.text,
                      "postcode": _postcode!.text,
                      "zone_id": _zoneId!.text
                    });
                  }
                })
          ],
        ),
      ),
    );
  }
}
