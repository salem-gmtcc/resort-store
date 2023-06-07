import 'dart:io';

import 'package:resort_store/business_logic/getLocationDetails/get_location_details_cubit.dart';
import 'package:resort_store/core/helpers/app_function.dart';
import 'package:resort_store/data/repository/getLocationDetails.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

import '../../core/constants/strings_app.dart';
import '../../core/helpers/shared_prefrencess.dart';

class CustomGoogleMap extends StatefulWidget {
  TextEditingController? address;
  TextEditingController? zone;
  TextEditingController? country;

  CustomGoogleMap({this.address, this.zone,this.country});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  double lat = SharedHelper.sharedPreferences.getDouble(AppStrings.lat) ?? 26.4084363;
  double lon = SharedHelper.sharedPreferences.getDouble(AppStrings.lon) ?? 50.0470046;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetLocationDetailsCubit, GetLocationDetailsState>(
      builder: (context, state) {
        if (state is GetLocationDetailsSuccess) {
         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
           widget.address!.text = "${state.data["road"]?? ""}" "${state.data["state"]?? ""}".replaceAll("{\$t: ", "").replaceAll("}{\$t:", "").replaceAll("}","");
           widget.zone!.text= "${state.data["city"] ?? ""}".replaceAll("{\$t: ", "").replaceAll("}{\$t:", "").replaceAll("}","");
           widget.country!.text = "${state.data["country"] ?? ""}".replaceAll("{\$t: ", "").replaceAll("}", "");
         });
          print("---------------------------------------------------------- city ** ${state.data["city"]}".replaceAll("{\$t:", "").replaceAll("}", ""));
          print("---------------------------------------------------------- country ** ${state.data["country"]}".replaceAll("{\$t:", "").replaceAll("}", ""));
         print("---------------------------------------- ****** ${widget.address!.text}".replaceAll("{\$t: ", "").replaceAll("}{\$t:", "").replaceAll("}", ""));
        }
        return Center(
          child: Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  onTap: (_, latLong) async {
                    print("********${latLong.latitude} ******${latLong.longitude}");

                    setState(() {
                      lat = latLong.latitude;
                      lon = latLong.longitude;
                      SharedHelper.sharedPreferences
                          .setDouble(AppStrings.latMap, latLong.latitude);
                      SharedHelper.sharedPreferences
                          .setDouble(AppStrings.lonMap, latLong.longitude);
                    });
                    context
                        .read<GetLocationDetailsCubit>()
                        .getLocationDataCubit(lat, lon);
                  },
                  center: LatLng(lat, lon),
                  zoom: 14.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    // userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                          point: LatLng(lat, lon),
                          width: 50.w,
                          height: 50.h,
                          rotate: true,
                          builder: (context) => Icon(
                                Icons.pin_drop,
                                color: Colors.red,
                                size: 40.sp,
                              ))
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(color: AppColor.primaryLight),
                        child: Icon(
                          Icons.search,
                          size: 30.sp,
                          color: AppColor.black,
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    child: Container(
                        height: 30.h,
                        width: 32.w,
                        decoration: BoxDecoration(color: AppColor.primaryLight),
                        child: Icon(
                          Icons.my_location_outlined,
                          size: 30.sp,
                          color: AppColor.black,
                        )),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
    // return  FlutterMap(
    //   options: MapOptions(center: LatLng(23.000000.0 ,90.00000), zoom: 14.0,),
    //   children: [],
    //
    // );
  }
}
