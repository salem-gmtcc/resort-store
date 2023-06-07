import 'package:resort_store/business_logic/change_theme/cubit.dart';
import 'package:resort_store/business_logic/main/cubit.dart';
import 'package:resort_store/business_logic/product/cubit.dart';
import 'package:resort_store/core/constants/route_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/screens/comparison/widgets/build_text_compare.dart';
import 'package:resort_store/presentation/screens/comparison/widgets/build_value_compare.dart';
import 'package:resort_store/presentation/widgets/background.dart';
import 'package:resort_store/presentation/widgets/custom_button.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:resort_store/presentation/widgets/shimmer/shimmer_products/custom_product_shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../business_logic/product/state.dart';
import '../../../core/helpers/textStyle_helper.dart';
import '../../../data/repository/product/product.dart';
import '../../../di/di.dart';
import '../../widgets/shimmer/shimmer_products/custom_compare_product_shimmer.dart';

class ComparisonScreen extends StatefulWidget {
  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductCubit(productRepository: instance<ProductRepository>())
            ..getCompareProductCubit(),
      child: BlocBuilder<ProductCubit, ProductStates>(builder: (context, state) {
        if (state is SuccessCompareProductState) {
          if (state.compareProductModel.productDataModel!.isNotEmpty) {
            return Scaffold(
              backgroundColor: context.read<ThemeDataCubit>().recolor ??
                  AppColor.primaryAmwaj,
              body: BackGround(
                widget: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: double.infinity,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 190.h,
                              color: Colors.white,
                            ),
                            Text(
                              AppStrings.productDetails.tr(),
                              style: textStyleCustom(
                                fontSize: 15.sp,
                                fontColor: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            // TODO: PRICE
                            BuildTextCompare(
                              text: AppStrings.price.tr(),
                            ),
                            // TODO: Tax
                            BuildTextCompare(
                              text: AppStrings.tax.tr(),
                            ),
                            // TODO: Quantity Offer
                            BuildTextCompare(
                              text: AppStrings.quantityOffer.tr(),
                            ),
                            // TODO: Offer
                            BuildTextCompare(
                              text: AppStrings.offer.tr(),
                            ),
                            // TODO: Review
                            BuildTextCompare(
                              text: AppStrings.review.tr(),
                            )
                          ],
                        ),
                        Container(
                          height: 500.h,
                          width: 500.w,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state
                                  .compareProductModel.productDataModel!.length,
                              itemBuilder: (context, index) {
                                print("||||| ${state.compareProductModel.productDataModel![index].price}");
                                return CustomPadding.symmetric(
                                  horizontal: 5.w,
                                  child: BuildValueCompare(
                                    image: state.compareProductModel
                                        .productDataModel![index].thumb,
                                    name: state.compareProductModel
                                        .productDataModel![index].name,
                                    rating: state.compareProductModel
                                        .productDataModel![index].rating,
                                    productId: state.compareProductModel
                                        .productDataModel![index].productId,
                                    price: state.compareProductModel.productDataModel![index].priceFormat,
                                    tax: state.compareProductModel.productDataModel![index].taxAmount,
                                    // priceTax: state.compareProductModel.productDataModel![index].priceExcludingTax,
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return CustomPadding.symmetric(
              horizontal: 5.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/comparisonIcon.png",
                      color: AppColor.white,
                      fit: BoxFit.cover,
                      height: 50.h,
                      width: 50.w),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: Text(AppStrings.compareListEmpty.tr(),
                        textAlign: TextAlign.center,
                        style: mediumTextStyle(
                            fontSize: 15.sp, color: AppColor.white)),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomButton(
                      onPressed: () {
                        AppRouter.offNamed(context, RouteConstants.main);
                        context.read<MainCubit>().changeBottomNavBar(2);
                      },
                      title: AppStrings.goToCompare.tr(),
                      width: 160.w,
                      height: 30.h,
                      radius: 10.r,
                      color: AppColor.primaryLight,
                      textStyle: mediumTextStyle(
                          fontSize: 13.0, color: AppColor.primaryAmwaj))
                ],
              ),
            );
          }
        } else if (state is ProductErrorState) {
          showToast(text: state.e.toString(), color: ToastColors.ERROR);
        } else if (state is ProductLoadingState) {
          const CustomProductShimmer();
        }
        return const CustomCompareProductShimmer();
      }),
    );
  }
}
