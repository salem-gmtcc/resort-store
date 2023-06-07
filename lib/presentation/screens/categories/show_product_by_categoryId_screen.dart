import 'package:resort_store/business_logic/product/cubit.dart';
import 'package:resort_store/business_logic/product/state.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/background.dart';
import 'package:resort_store/presentation/widgets/custom_loading.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:resort_store/presentation/widgets/product_item.dart';
import 'package:resort_store/presentation/widgets/shimmer/shimmer_products/custom_product_branch_shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/change_theme/cubit.dart';
import '../../../core/constants/strings_app.dart';
import '../../../core/helpers/saved_theme.dart';
import '../../../core/helpers/textStyle_helper.dart';

class ShowProductByCategoryId extends StatelessWidget {
  String? name, id;

  ShowProductByCategoryId({required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: AppColor.primaryAmwaj,
        appBar: AppBar(
          backgroundColor:
              context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
          title: Text(name!,
              style: textStyleCustom(
                fontSize: 15.sp,
                fontColor:Colors.white,
              )
          ),
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              AppRouter.back(context);
            },
            icon: Icon(Icons.arrow_back, color: AppColor.white, size: 15.sp),
          ),
        ),
        body: BackGround(
          widget: BlocBuilder<ProductCubit, ProductStates>(
            builder: (context, state) {
              if (state is SuccessAllProductState) {
                if (state.productModel.productDataModel!.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Image.asset("assets/images/empty_box.png",color: Colors.white,
                            width: 150.0.w, height: 100.h),
                        Text(
                          AppStrings.listEmpty.tr(),
                          style: textStyleCustom(
                            fontSize: 15.sp,
                            fontColor:Colors.white,
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return SizedBox(
                    height: double.infinity.h,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: state.productModel.productDataModel!.length,
                        itemBuilder: (context, index) {
                          return ProductItem(
                              image: state
                                  .productModel.productDataModel![index].image,
                              name: state
                                  .productModel.productDataModel![index].name,
                              rating: state
                                  .productModel.productDataModel![index].rating,
                              id: state
                                  .productModel.productDataModel![index].id,
                              priceExcludingTax: state
                                  .productModel.productDataModel![index].priceExcludingTax.toString(),
                              priceFormat: state.productModel
                                  .productDataModel![index].priceFormat,
                           quantityOffers:state.productModel.productDataModel![index].quantityOffers,

                          );
                        }),
                  );
                }
              } else if (state is ProductErrorState) {
                showToast(text: state.e.toString(), color: ToastColors.ERROR);
              } else if (state is ProductLoadingState) {
                return const CustomBranchProductShimmer();
              }
              return const CustomBranchProductShimmer();
            },
          ),
        ),


    );
  }
}
