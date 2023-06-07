import 'package:resort_store/business_logic/change_theme/cubit.dart';
import 'package:resort_store/business_logic/product/cubit.dart';
import 'package:resort_store/business_logic/product/state.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:resort_store/presentation/widgets/product_item.dart';
import 'package:resort_store/presentation/widgets/shimmer/shimmer_products/custom_product_branch_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/search/custom_search_item.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            //TODO : Search item
            CustomSearchItem(),
            const SizedBox(height: 5.0),
            // TODO: //All Products
            BlocBuilder<ProductCubit, ProductStates>(
              builder: (context, state) {
                if (state is ProductLoadingState) {
                  const CustomBranchProductShimmer();
                } else if (state is ProductErrorState) {
                  showToast(text: state.e.toString(), color: ToastColors.ERROR);
                } else if (state is SuccessAllProductState) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:2,
                                  childAspectRatio: 0.7,
                              ),
                          scrollDirection: Axis.vertical,
                          itemCount:
                              state.productModel.productDataModel!.length,
                          itemBuilder: (context, index) {
                            return ProductItem(
                                image: state.productModel
                                    .productDataModel![index].image,
                                name: state
                                    .productModel.productDataModel![index].name,
                                rating: state.productModel
                                    .productDataModel![index].rating,
                                id: state
                                    .productModel.productDataModel![index].id,
                                priceExcludingTax: state.productModel
                                    .productDataModel![index].priceExcludingTax,
                                priceFormat: state.productModel
                                    .productDataModel![index].priceFormat,
                             quantityOffers:state.productModel
                                 .productDataModel![index].quantityOffers,
                            );

                          }),
                    ),
                  );
                }
                return const CustomBranchProductShimmer();
              },
            ),
          ],
        ),
      ),
    );
  }
}
