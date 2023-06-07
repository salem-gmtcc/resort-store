import 'package:resort_store/business_logic/country/cubit.dart';
import 'package:resort_store/business_logic/getLocationDetails/get_location_details_cubit.dart';
import 'package:resort_store/business_logic/payment_address/cubit.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/data/model/country/country.dart';
import 'package:resort_store/data/repository/country/country.dart';
import 'package:resort_store/data/repository/getLocationDetails.dart';
import 'package:resort_store/presentation/widgets/custom_google_map.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/textStyle_helper.dart';
import '../../../di/di.dart';
import '../../resources/color_manger.dart';
import '../../resources/textStyle_manger.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textFeild.dart';
import '../../widgets/dialog/search_dailog_widget.dart';

class CustomPaymentAddress extends StatefulWidget {
  @override
  State<CustomPaymentAddress> createState() => _CustomPaymentAddressState();
}

class _CustomPaymentAddressState extends State<CustomPaymentAddress> {
  TextEditingController? _name;
  TextEditingController? _address1;
  TextEditingController? _country;
  TextEditingController? _zone;
  TextEditingController? _landmarkNearby;
  TextEditingController? _addressDetails;

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _name = TextEditingController();
    _address1 = TextEditingController();
    _country = TextEditingController();
    _zone = TextEditingController();
    _landmarkNearby = TextEditingController();
    _addressDetails = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _name!.dispose();
    _address1!.dispose();
    _country!.dispose();
    _zone!.dispose();
    _landmarkNearby!.dispose();
    _addressDetails!.dispose();
    super.dispose();
  }

  String _myCountry = "";
  List<CountryDataModel> list = [];
  bool value = false;

  String query = "";
  double? lat = SharedHelper.sharedPreferences.getDouble(AppStrings.lat);
  double? lon = SharedHelper.sharedPreferences.getDouble(AppStrings.lon);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        BlocProvider(
            create: (context) => GetLocationDetailsCubit(
                getLocationDetailsRepo: instance<GetLocationDetailsRepo>())
              ..getLocationDataCubit(lat?? 26.4084363, lon ?? 50.0470046),
            child: Container(
                height: 120.h,
                child: CustomGoogleMap(
                  address: _address1,
                  zone: _zone,
                  country: _country,
                ))),
        SizedBox(
          height: 10.h,
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: CustomPadding.symmetric(
            horizontal: 5.w,
            child: Form(
              key: _key,
              child: Column(
                children: [
                  //TODO:  Name

                  CustomTextField(
                    controller: _name,
                    hintText: "",
                    borderColor: AppColor.primaryAmwaj,
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(
                          color: AppColor.red,
                        )),
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
                    labelText: AppStrings.name.tr(),
                    height: 35.h,
                    radius: 50.r,
                  ),

                  SizedBox(
                    height: 5.h,
                  ),

                  //TODO:  Address 1
                  CustomTextField(
                    controller: _address1,
                    hintText: "",
                    borderColor: AppColor.primaryAmwaj,
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.red,
                      ),
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
                    labelText: AppStrings.address.tr(),
                    height: 35.h,
                    radius: 30.r,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  // //TODO: Country

                  CustomTextField(
                    readOnly: true,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => CustomSearchAlertDialog(
                                country: _country,
                              ));

                      print(
                          "--------------------------- country ${_country!.text}");
                    },
                    controller: _country,
                    hintText: "",
                    onChanged: (value) {
                      print("value -------------------------- $value");
                    },
                    borderColor: AppColor.primaryAmwaj,
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.red,
                      ),
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
                    labelText: AppStrings.country.tr(),
                    height: 35.h,
                    radius: 30.r,
                  ),
                  // Container(
                  //   height: 35.h,
                  //   width: 250.w,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10.r),
                  //   ),
                  //   child: InkWell(
                  //     child:Text(_myCountry.toString()),
                  //     onTap: (){
                  //       showDialog(context: context, builder: (context)=>CustomSearchAlertDialog(
                  //         text: _myCountry,
                  //       ));
                  //     },
                  //   ),
                  // ),

                  // CustomTextField(
                  //   hintText: "",
                  //   borderColor: AppColor.primaryAmwaj,
                  //   controller: _country,
                  //   errorBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10.r),
                  //       borderSide: BorderSide(
                  //         color: AppColor.red,
                  //       )),
                  //   enabled: true,
                  //   filled: true,
                  //   focusedBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10.r),
                  //   ),
                  //   disabledBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10.r),
                  //   ),
                  //   enabledBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10.r),
                  //   ),
                  //   border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10.r),
                  //   ),
                  //   labelText: AppStrings.country.tr(),
                  //   onTap: () {
                  //     showDialog(
                  //         context: context,
                  //         builder: (context) => BlocProvider(
                  //             create: (context) => CountryCubit(
                  //                 countryRepository:
                  //                     instance<CountryRepository>())
                  //               ..getCountryCubit,
                  //             child: CustomSearchAlertDialog(
                  //               text: _country!.text,
                  //             )));
                  //   },
                  //   height: 35.h,
                  //   radius: 30.r,
                  // ),

                  //TODO: :-----------------------------------------------------------------------

                  // BlocProvider(
                  //   create: (context) =>
                  //       CountryCubit(countryRepository: instance<CountryRepository>())
                  //         ..getCountryCubit(),
                  //   child: BlocBuilder<CountryCubit, CountryStates>(
                  //       builder: (context, state) {
                  //     if (state is SuccessCountryState) {
                  //       list = state.countryModel.countryDataModel!;
                  //       List<CountryDataModel> resultSearch = list.where((search) => search.name == query).toList();
                  //       print("------------------------------------- :  : $resultSearch");
                  //     } else if (state is LoadingCountryState) {
                  //       Center(
                  //         child:
                  //             CircularProgressIndicator(color: AppColor.primaryAmwaj),
                  //       );
                  //     }
                  //     return Stack(
                  //         children: [
                  //       DropdownButtonFormField<String>(
                  //         validator: (value) {
                  //           if (value!.isEmpty) {
                  //             return AppStrings.required.tr();
                  //           }
                  //           return null;
                  //         },
                  //         decoration: InputDecoration(
                  //             errorBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(30.r),
                  //             ),
                  //             enabled: true,
                  //             // filled: true,
                  //             focusedBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(30.r),
                  //             ),
                  //             disabledBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(30.r),
                  //             ),
                  //             enabledBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(30.r),
                  //             ),
                  //             border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(30.r),
                  //             ),
                  //             labelText:  AppStrings.country.tr()),
                  //         value: _myCountry,
                  //         onChanged: (newValue) {
                  //           setState(() {
                  //             _myCountry = newValue;
                  //             print(_myCountry);
                  //             _country!.text = newValue!;
                  //             print(" -------${_country!.text}");
                  //           });
                  //         },
                  //         items: list.map((item) {
                  //               _country!.text = item.countryId.toString();
                  //               return DropdownMenuItem(
                  //                 value: item.countryId.toString(),
                  //                 child: CustomPadding.symmetric(
                  //                     horizontal: 5.0, child: Text(item.name!)),
                  //               );
                  //             }).toList() ??
                  //             [],
                  //         isExpanded: true,
                  //         isDense: true,
                  //       ),
                  //       if (state is LoadingCountryState)
                  //         Center(
                  //             child: CircularProgressIndicator(
                  //           color: AppColor.primaryAmwaj,
                  //         )),
                  //     ]);
                  //   }),
                  // ),

                  SizedBox(
                    height: 5.h,
                  ),
                  // //TODO:  city

                  CustomTextField(
                    controller: _zone,
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
                    labelText: AppStrings.city.tr(),
                    height: 35.h,
                    radius: 20.r,
                  ),

                  SizedBox(
                    height: 5.h,
                  ),
                  // //TODO:  landmark nearby
                  CustomTextField(
                    controller: _landmarkNearby,
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
                    labelText: AppStrings.landmarkNearby.tr(),
                    height: 35.h,
                    radius: 20.r,
                  ),

                  SizedBox(
                    height: 5.h,
                  ),

                  // //TODO:  Address Details
                  // CustomTextField(
                  //   controller: _addressDetails,
                  //   hintText: "",
                  //   borderColor: AppColor.primaryAmwaj,
                  //   errorBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10.r),
                  //   ),
                  //   enabled: true,
                  //   filled: true,
                  //   focusedBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10.r),
                  //   ),
                  //   disabledBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10.r),
                  //   ),
                  //   enabledBorder: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10.r),
                  //   ),
                  //   border: OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(10.r),
                  //   ),
                  //   labelText: AppStrings.addressDetails.tr(),
                  //   height: 35.h,
                  //   radius: 20.r,
                  //   validator: (val) {
                  //     if (val!.isEmpty) {
                  //       return AppStrings.required.tr();
                  //     }
                  //     return null;
                  //   },
                  // ),
                  //TODO: Checkout Box
                  Row(
                    children: [
                      Checkbox(
                          // activeColor: AppColor.black,
                          // checkColor:  AppColor.primaryAmwaj,
                          value: value,
                          onChanged: (value) {
                            setState(() {
                              this.value = value!;
                            });
                          }),
                      Text(
                        AppStrings.Default.tr(),
                        style: mediumTextStyle(
                            fontSize: 15.0, color: AppColor.black),
                      ),
                    ],
                  ),

                  //TODO: ** Custom Button **

                  CustomButton(
                      radius: 10.r,
                      height: 30.h,
                      width: 100.w,
                      title: AppStrings.save.tr(),
                      elevation: 5.0,
                      color: AppColor.primaryAmwaj,
                      textStyle: textStyleCustom(
                        fontSize: 16.sp,
                        fontColor: Colors.white,
                      ),
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          print(
                              "**** ---------- ${SharedHelper.sharedPreferences.getString(AppStrings.sessionId)}");
                          context
                              .read<PaymentAddressCubit>()
                              .savePaymentAddressCubit({
                            "firstname": _name!.text,
                            "lastname": SharedHelper.sharedPreferences
                                .getString(AppStrings.lastName),
                            "country": _country!.text,
                            "city": _country!.text,
                            "address_1": _address1!.text,
                            "country_id": _landmarkNearby!.text,
                            "zone_id": _zone!.text,
                          });
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
