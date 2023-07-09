import 'package:resort_store/core/constants/strings_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../business_logic/main_template/main_template_cubit.dart';
import '../../../../../business_logic/product/cubit.dart';
import '../../../../../business_logic/product/state.dart';
import '../../../../../core/constants/route_constant.dart';
import '../../../../../core/helpers/app_router.dart';
import '../../../../../data/repository/product/product.dart';
import '../../../../../di/di.dart';
import '../../../../../presentation/resources/color_manger.dart';
import '../../../../../presentation/resources/textStyle_manger.dart';
import '../../../../../presentation/widgets/custom_padding.dart';
import '../../../../../presentation/widgets/custom_toast.dart';
import '../../../../../presentation/widgets/shimmer/shimmer_products/custom_compare_product_shimmer.dart';
import '../../../../../presentation/widgets/shimmer/shimmer_products/custom_product_shimmer.dart';
import 'build_compare_widget.dart';

class CompareTemplateScreen extends StatelessWidget {
  const CompareTemplateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        backgroundColor: AppColor.white,
        // leading: InkWell(
        //   onTap: (){
        //     // AppRouter.back(context);
        //   },
        //   child: Icon(
        //     Icons.arrow_back,
        //     color: AppColor.black,
        //     size: 20.0.sp,
        //   ),
        // ),
        title: Text(AppStrings.comparison.tr(),
            style: mediumTextStyle(fontSize: 15.sp, color: AppColor.black)),
        centerTitle: true,
        actions: [
          Padding(
              padding: EdgeInsets.only(left: 8.sp, right: 8.sp),
              child: SvgPicture.asset(
                "assets/icons/bell-Bold.svg",
                height: 15.h,
                color: AppColor.black,
              ))
        ],
      ),
      body: BlocProvider(
        create: (context) => ProductCubit(productRepository: instance<ProductRepository>())..getCompareProductCubit(),
        child: BlocBuilder<ProductCubit, ProductStates>(builder: (context, state) {
          if (state is SuccessCompareProductState) {
            if (state.compareProductModel.productDataModel!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    child: BuildCompareWidget(
                      products: state.compareProductModel.productDataModel,
                    ),
                  ),
                ),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/EmptyState-1.svg",
                    height: 120.h,
                    width: 120.w,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Center(
                    child: Container(
                      height: 70.h,
                      width: 280.w,
                      child: Text(AppStrings.favouriteListEmpty.tr(),
                          textAlign: TextAlign.center,
                          style: mediumTextStyle(
                              fontSize: 17.sp,
                              color: AppColor.grey.withOpacity(0.7))),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  InkWell(
                    onTap: (){
                      AppRouter.offNamed(context, RouteConstants.mainNewTemplate);
                      // context.read<MainTemplateCubit>().changeBottomNavigator(
                      //     context.read<MainTemplateCubit>().selectedItem
                      // );
                    },
                    child: Container(
                      height: 35.h,
                      width: 180.w,
                      decoration:   BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: AppColor.primaryAmwaj,
                      ),
                      child: Center(
                        child: Text(AppStrings.chooseProduct.tr(),style: TextStyle(
                            color: AppColor.white,
                            fontSize: 15.sp
                        )),
                      ),
                    ),
                  ),
                ],
              );
            }
          } else if (state is ProductErrorState) {
            showToast(text: state.e.toString(), color: ToastColors.ERROR);
          } else if (state is ProductLoadingState) {
            const CustomProductShimmer();
          }
          return const CustomCompareProductShimmer();
        }),
      ),
    );
  }
}
