import 'package:resort_store/business_logic/banner/cubit.dart';
import 'package:resort_store/business_logic/banner/state.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:resort_store/presentation/widgets/shimmer/custom_carsoul_slider_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/repository/banners/banners.dart';
import '../../../../di/di.dart';

class CarouselSliderWidget extends StatelessWidget {
  final String? id;
  CarouselSliderWidget({required this.id});
  @override
  Widget build(BuildContext context) {
    return   BlocProvider(
      create: (context) => BannerCubit(
          bannerRepository: instance<BannerRepository>())
        ..getBannerCubit(id!),
      child: BlocBuilder<BannerCubit, BannerStates>(
        builder: (context, state) {
          if (state is BannerSuccessState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 130.h,
                width: 450.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.white),
                child: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      initialPage: 2,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayAnimationDuration:
                      const Duration(milliseconds: 300),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: state.bannerModel.bannerDataModel!.map((e) {
                      // return Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(20.r),
                      //           image: DecorationImage(
                      //             onError: (o, _) => Image.asset(
                      //                 "assets/images/place_holder2.png",
                      //                 width: 500.w),
                      //             fit: BoxFit.fitWidth,
                      //             image: NetworkImage(e.image!),
                      //           )),
                      //       height: 130.h,
                      //       width: 500.w,
                      //     ));
                      return Container(
                        height: 100.h,
                        width: 450.w,
                        decoration: BoxDecoration(
                          // color: AppColor.red,
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(image: NetworkImage(e.image!),fit: BoxFit.cover),
                        ),
                        // child: CachedNetworkImage(
                        //   imageUrl: e.image!,
                        //   placeholder: (context, url) => Image.asset(
                        //     "assets/images/place_holder2.png",
                        //   ),
                        //   errorWidget: (context, url, error) => Icon(Icons.error),
                        // ),
                      );
                    }).toList()),
              ),
            );
          } else if (state is BannerErrorState) {
            showToast(text: state.e.toString(), color: ToastColors.ERROR);
          } else if (state is BannerLoadingState) {
            const CustomCarouselSliderShimmer();
          }
          return const CustomCarouselSliderShimmer();
        },
      ),
    );
  }
}
