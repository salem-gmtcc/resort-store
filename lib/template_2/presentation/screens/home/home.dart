import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/template_2/presentation/widgets/build_category.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../business_logic/categories/cubit.dart';
import '../../../../business_logic/categories/state.dart';
import '../../../../business_logic/product/cubit.dart';
import '../../../../business_logic/product/state.dart';
import '../../../../core/constants/route_constant.dart';
import '../../../../core/constants/strings_app.dart';
import '../../../../core/helpers/app_router.dart';
import '../../../../data/repository/categories/categories.dart';
import '../../../../data/repository/product/product.dart';
import '../../../../di/di.dart';
import '../../../../presentation/screens/categories/sub_categories_screen.dart';
import '../../../../presentation/screens/home/Widgets/branch_title.dart';
import '../../../../presentation/screens/home/Widgets/carsoual_slider.dart';
import '../../../../presentation/widgets/custom_toast.dart';
import '../../../../presentation/widgets/search/custom_search_item.dart';
import '../../../../presentation/widgets/shimmer/shimmer_categories/custom_categories_main_shimmer.dart';
import '../../../../presentation/widgets/shimmer/shimmer_products/custom_product_main_shimmer.dart';
import '../../widgets/build_item_product.dart';

class HomeTemplateScreen extends StatelessWidget{

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryAmwaj,
      drawer: Container(
        width: 200.w,
        color: AppColor.white,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(

          children: [
            //TODO : TOP SCREEN
            SizedBox(
              height: 50.h,
            ),

            //TODO : Logo SpareTK
            Center(
              child: Container(
                  width: 150.w,
                  height: 60.h,
                  child: Image.asset("assets/images/name.png",height: 50.h,width: 100.w,)),
            ),
            //TODO: Search Container
            BlocProvider(
                create: (context) => ProductCubit(
                    productRepository: instance<ProductRepository>()),
                child: CustomSearchItem(180.0.h)),
            SizedBox(
              height: 10.h,
            ),
            //TODO: build Categories
            BlocProvider(
              create: (context) => CategoriesCubit(
                  categoriesRepository: instance<CategoriesRepository>())
                ..getMainCategories(),
              child: BlocBuilder<CategoriesCubit, CategoriesStates>(
                builder: (context, state) {
                  if (state is MainCategoriesSuccessState) {
                    return Container(
                      height: 80.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.mainCategories.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {

                              print("***************** enter  home ${state.mainCategories[i].subCategories}");

                              print("/****");

                              AppRouter.to(
                                  context, RouteConstants.subCategory,
                                  arguments: SubCategoryScreen(
                                    id: state.mainCategories[i].categoryId.toString(),
                                    name: state.mainCategories[i].name,
                                  ));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 8.sp, left: 8.sp),
                              child: CustomBuildCategory(
                                image: state.mainCategories[i].image.toString(),
                                title: state.mainCategories[i].name.toString(),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  else if (state is CategoriesLoadingState) {
                    const CustomCategoriesMainShimmer();
                  }
                  return const CustomCategoriesMainShimmer();
                },
              ),
            ),
            // TODO: ****************************************** BOTTOM SCREEN *********************************
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                color: AppColor.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TODO : Slider Carousel
                    CarouselSliderWidget(id: "9"),
                    SizedBox(
                      height: 5.h,
                    ),
                    //TODO : Feature Product
                    SizedBox(
                      height: 5.h,
                    ),
                    BranchTitle(
                        title: AppStrings.featuredProduct.tr(),
                        color: HexColor("#000000")),

                    BlocProvider<ProductCubit>(
                      create: (context) => ProductCubit(
                          productRepository: instance<ProductRepository>())
                        ..getFeaturedProductCubit(),
                      child: BlocBuilder<ProductCubit, ProductStates>(
                        builder: (context, state) {
                          if (state is ProductLoadingState) {
                            const CustomMainProductShimmer();
                          } else if (state is ProductCompareLoadingState) {
                            Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryAmwaj),
                            );
                          } else if (state is SuccessProductFeaturedState) {
                            return Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 5.0.sp),
                              child: SizedBox(
                                height: 160.h,
                                child: ListView.builder(

                                    scrollDirection: Axis.horizontal,

                                    itemCount: state.products.length,

                                    physics: const BouncingScrollPhysics(),

                                    itemBuilder: (context, index) {
                                      return BuildItemProduct(
                                        specail:state.products[index].special,
                                        id: state.products[index].productId,
                                        image: state.products[index].thumb.toString(),
                                        name: state.products[index].name.toString(),
                                        price: state.products[index].priceFormat.toString(),
                                        quantityOffers: state.products[index].quantityOffers,
                                        priceTax: state.products[index].priceExcludingTax.toString(),
                                      );
                                    }),
                              ),
                            );
                          } else if (state is ProductErrorState) {
                            print("******************************************************* error ||  ${state.e}");
                            showToast(text: state.e.toString(), color: ToastColors.ERROR);
                          }
                          return const CustomMainProductShimmer();
                        },
                      ),
                    ),
                    //TODO : IMAGE
                    CarouselSliderWidget(id: "7"),
                    SizedBox(
                      height: 5.h,
                    ),

                    //TODO :Latest Product

                    BranchTitle(
                        title: AppStrings.latestProduct.tr(),
                        color: HexColor("#000000")),

                    BlocProvider<ProductCubit>(
                      create: (context) => ProductCubit(
                          productRepository: instance<ProductRepository>())
                        ..getLatestProductCubit(),
                      child: BlocBuilder<ProductCubit, ProductStates>(
                        builder: (context, state) {
                          if (state is ProductLoadingState) {
                            const CustomMainProductShimmer();
                            context.read<ProductCubit>().getLatestProductCubit();
                          } else if (state is SuccessLatestProductState) {
                            return Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 5.0.sp),
                              child: SizedBox(
                                height: 160.h,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount:
                                    state.productModel.productDataModel!.length,
                                    itemBuilder: (context, index) {

                                      return BuildItemProduct(
                                        specail:state.productModel.productDataModel![index].special,
                                        id: state.productModel.productDataModel![index].productId,
                                        image: state.productModel.productDataModel![index].thumb.toString(),
                                        name: state.productModel.productDataModel![index].name.toString(),
                                        price: state.productModel.productDataModel![index].priceFormat.toString(),
                                        quantityOffers: state.productModel.productDataModel![index].quantityOffers,
                                        priceTax: state.productModel.productDataModel![index].priceExcludingTax.toString(),
                                      );
                                    }),
                              ),
                            );
                          } else if (state is ProductErrorState) {
                            showToast(
                                text: state.e.toString(), color: ToastColors.ERROR);
                          }
                          return const CustomMainProductShimmer() /*SizedBox.shrink()*/;
                        },
                      ),
                    ),
                    //TODO : IMAGE
                    CarouselSliderWidget(id: "8"),
                    // TODO : Best Seller
                    SizedBox(
                      height: 5.h,
                    ),

                    BranchTitle(
                        title: AppStrings.bestSeller.tr(),
                        color: HexColor("#000000")),
                    BlocProvider<ProductCubit>(
                      create: (context) => ProductCubit(
                          productRepository: instance<ProductRepository>())
                        ..getBestSellerProductCubit(),
                      child: BlocBuilder<ProductCubit, ProductStates>(
                        builder: (context, state) {
                          if (state is ProductLoadingState) {
                            const CustomMainProductShimmer();
                          } else if (state is SuccessBestSellerProductState) {
                            print("**${state.productModel.productDataModel!.length}");
                            return Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 5.0.sp),
                              child: SizedBox(
                                height: 160.h,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: state.productModel.productDataModel!.length,
                                    itemBuilder: (context, index) {
                                      return BuildItemProduct(
                                        specail:state.productModel.productDataModel![index].special,
                                        id: state.productModel.productDataModel![index].productId,
                                        image: state.productModel.productDataModel![index].thumb.toString(),
                                        name: state.productModel.productDataModel![index].name.toString(),
                                        price: state.productModel.productDataModel![index].priceFormat.toString(),
                                        quantityOffers: state.productModel.productDataModel![index].quantityOffers,
                                        priceTax: state.productModel.productDataModel![index].priceExcludingTax.toString(),
                                      );
                                    }),
                              ),
                            );
                          } else if (state is ProductErrorState) {
                            print("ERROR : ${state.e.toString()}");
                            showToast(text: state.e.toString(), color: ToastColors.ERROR);
                          }
                          return const CustomMainProductShimmer();
                        },
                      ),
                    ),
                    SizedBox(height: 15.sp,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

