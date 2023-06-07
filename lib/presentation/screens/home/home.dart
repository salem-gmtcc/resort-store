import 'package:resort_store/business_logic/categories/cubit.dart';
import 'package:resort_store/business_logic/categories/state.dart';
import 'package:resort_store/business_logic/currencies/currencies_cubit.dart';
import 'package:resort_store/business_logic/product/cubit.dart';
import 'package:resort_store/business_logic/product/state.dart';
import 'package:resort_store/core/constants/route_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/data/repository/categories/categories.dart';
import 'package:resort_store/data/repository/currencies/currencies.dart';
import 'package:resort_store/data/repository/product/product.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/screens/categories/sub_categories_screen.dart';
import 'package:resort_store/presentation/widgets/custom_button.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../business_logic/change_theme/cubit.dart';
import '../../resources/color_manger.dart';
import '../../widgets/search/custom_search_item.dart';
import '../../widgets/product_item.dart';
import '../../widgets/shimmer/shimmer_categories/custom_categories_main_shimmer.dart';
import '../../widgets/shimmer/shimmer_products/custom_product_main_shimmer.dart';
import 'Widgets/branch_title.dart';
import 'Widgets/carsoual_slider.dart';
import 'Widgets/itemCardHeader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
              AppColor.primaryAmwaj.withOpacity(0.5)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO : Search item
              BlocProvider(
                  create: (context) => ProductCubit(
                      productRepository: instance<ProductRepository>()),
                  child: CustomSearchItem()),
              SizedBox(
                height: 5.h,
              ),
              //TODO: // TODO: ITEM CARD
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 5),
                child: Row(
                  children: [
                    SizedBox(
                        width: 50.w,
                        height: 30.h,
                        child: InkWell(
                            onTap: () {
                              AppRouter.to(context, RouteConstants.allCategory);
                            },
                            child: ItemCardHeader(
                                color: AppColor.primaryLight,
                                title: AppStrings.all.tr()))),
                    SizedBox(width: 10.w,),
                    BlocProvider(
                      create: (context) => CategoriesCubit(
                          categoriesRepository:
                              instance<CategoriesRepository>())
                        ..getMainCategories(),
                      child: BlocBuilder<CategoriesCubit, CategoriesStates>(
                        builder: (context, state) {
                          if (state is MainCategoriesSuccessState) {
                            return SizedBox(
                               height: 50.h,
                              width: 260.w,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.mainCategories.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, i) {
                                  return InkWell(
                                    onTap: () {
                                      print(
                                          "***************** enter  home ${state.mainCategories[i].subCategories}");
                                      print("/****");
                                      AppRouter.to(
                                          context, RouteConstants.subCategory,
                                          arguments: SubCategoryScreen(
                                            id: state
                                                .mainCategories[i].categoryId
                                                .toString(),
                                            name: state.mainCategories[i].name,
                                          ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: ItemCardHeader(
                                        color: AppColor.primaryLight
                                            .withOpacity(0.5),
                                        title: state.mainCategories[i].name,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (state is CategoriesLoadingState) {
                            const CustomCategoriesMainShimmer();
                          }
                          return const CustomCategoriesMainShimmer();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //TODO: Carsoul Slider
              CarouselSliderWidget(id: "7"),
              //TODO : Featured Product
              BranchTitle(title: AppStrings.featuredProduct.tr()),

               MultiBlocProvider(providers: [
    BlocProvider<ProductCubit>(
    create: (context) => ProductCubit(
    productRepository: instance<ProductRepository>())
    ..getFeaturedProductCubit()),
                 BlocProvider(create: (context)=>CurrenciesCubit(currenciesRepo: instance<CurrenciesRepo>())..getCurrenciesCubit())
               ],
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
                      return SizedBox(
                        height: 250.h,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 1.8,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.products.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ProductItem(
                                  /*    iconCompare: const SizedBox.expand(),
                              cartButton: const SizedBox.expand(),*/
                                  image: state.products[index].thumb,
                                  name: state.products[index].name,
                                  rating: state.products[index].rating,
                                  id: state.products[index].productId,
                                  priceExcludingTax: state.products[index].priceExcludingTax,
                                  priceFormat:
                                      state.products[index].priceFormat,
                                  quantityOffers:
                                      state.products[index].quantityOffers);
                            }),
                      );
                    } else if (state is ProductErrorState) {
                      print(
                          "******************************************************* error ${state.e}");
                      showToast(
                          text: state.e.toString(), color: ToastColors.ERROR);
                    }
                    return const CustomMainProductShimmer();
                  },
                ),
              ),

              //TODO :Latest Product
              BranchTitle(title: AppStrings.latestProduct.tr()),

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
                      return SizedBox(
                        height: 250.h,
                        child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                state.productModel.productDataModel!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1, childAspectRatio: 1.8),
                            itemBuilder: (context, index) {
                              return ProductItem(
                                  id: state.productModel
                                      .productDataModel![index].productId,
                                  image: state.productModel
                                      .productDataModel![index].thumb,
                                  name: state.productModel
                                      .productDataModel![index].name,
                                  rating: state.productModel
                                      .productDataModel![index].rating!,
                                  priceExcludingTax: state.productModel
                                      .productDataModel![index].priceExcludingTax,
                                  priceFormat: state.productModel
                                      .productDataModel![index].priceFormat
                                      .toString(),
                                  quantityOffers: state.productModel
                                      .productDataModel![index].quantityOffers);
                            }),
                      );
                    } else if (state is ProductErrorState) {
                      showToast(
                          text: state.e.toString(), color: ToastColors.ERROR);
                    }
                    return const CustomMainProductShimmer() /*SizedBox.shrink()*/;
                  },
                ),
              ),

              //TODO: Carsoul Slider
              CarouselSliderWidget(id: "8"),
              // TODO : Best Seller
              BranchTitle(title: AppStrings.bestSeller.tr()),
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
                      return SizedBox(
                        height: 250.h,
                        child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                state.productModel.productDataModel!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1, childAspectRatio: 1.8),
                            itemBuilder: (context, index) {
                              print(
                                  "name : ${state.productModel.productDataModel![index].name}");
                              return ProductItem(
                                id: state.productModel.productDataModel![index]
                                    .productId,
                                image: state
                                    .productModel.productDataModel![index].thumb
                                    .toString(),
                                name: state
                                    .productModel.productDataModel![index].name
                                    .toString(),
                                rating: state.productModel
                                    .productDataModel![index].rating!,
                                priceExcludingTax: state.productModel
                                    .productDataModel![index].priceExcludingTax,
                                priceFormat: state.productModel
                                    .productDataModel![index].priceFormat,
                                quantityOffers: state.productModel
                                    .productDataModel![index].quantityOffers,
                              );
                            }),
                      );
                    } else if (state is ProductErrorState) {
                      print("Error : ${state.e.toString()}");
                      showToast(text: state.e.toString(), color: ToastColors.ERROR);
                    }
                    return const CustomMainProductShimmer();
                  },
                ),
              ),
              // // TODO : All Products
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BranchTitle(title: AppStrings.products.tr()),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CustomButton(
                      onPressed: () {
                        AppRouter.to(context, RouteConstants.productScreen);
                      },
                      width: 50.w,
                      height: 20.h,
                      elevation: 5.0,
                      radius: 3.r,
                      title: AppStrings.showAll.tr(),
                      textStyle:
                          mediumTextStyle(fontSize: 10, color: AppColor.white),
                      color: AppColor.primaryLight,
                    ),
                  )
                ],
              ),
              BlocProvider<ProductCubit>(
                create: (context) => ProductCubit(
                    productRepository: instance<ProductRepository>())
                  ..getAllProductCubit(),
                child: BlocBuilder<ProductCubit, ProductStates>(
                  builder: (context, state) {
                    if (state is ProductLoadingState) {
                      const CustomMainProductShimmer();
                    } else if (state is SuccessAllProductState) {
                      return SizedBox(
                        height: 250.h,
                        child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: 6,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1, childAspectRatio: 1.8),
                            itemBuilder: (context, index) {
                              return ProductItem(
                                id: state.productModel.productDataModel![index].productId,
                                image: state
                                    .productModel.productDataModel![index].image
                                    .toString(),
                                name: state
                                    .productModel.productDataModel![index].name
                                    .toString(),
                                rating: state.productModel
                                    .productDataModel![index].rating!,
                                priceExcludingTax: state.productModel
                                    .productDataModel![index].priceExcludingTax,
                                priceFormat: state.productModel
                                    .productDataModel![index].priceFormat,
                                quantityOffers: state.productModel
                                    .productDataModel![index].quantityOffers,
                              );
                            }),
                      );
                    } else if (state is ProductErrorState) {
                      print("Error : ${state.e.toString()}");
                      showToast(
                          text: state.e.toString(), color: ToastColors.ERROR);
                    }
                    return const CustomMainProductShimmer();
                  },
                ),
              ),
              SizedBox(
                height: 50.h,
              )
            ],
          ),
        ));
  }
}
