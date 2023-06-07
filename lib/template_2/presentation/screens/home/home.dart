import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/template_2/presentation/widgets/build_category.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class HomeTemplateScreen extends StatefulWidget {
  const HomeTemplateScreen({Key? key}) : super(key: key);

  @override
  State<HomeTemplateScreen> createState() => _HomeTemplateScreenState();
}

class _HomeTemplateScreenState extends State<HomeTemplateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColor.white1,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO : TOP SCREEN
              Container(
                width: double.infinity,
                height: 200.h,
                decoration: BoxDecoration(color: AppColor.spareTKTemplate),
                child: Column(
                  children: [
                    SizedBox(
                      height: 35.h,
                    ),
                    //TODO: logo AND Bell
                    Padding(
                      padding: EdgeInsets.only(left: 25.sp, right: 25.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset("assets/icons/bell-Bold.svg"),
                          SvgPicture.asset("assets/icons/bell-Bold.svg")
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    //TODO: Search Container
                    BlocProvider(
                        create: (context) => ProductCubit(
                            productRepository: instance<ProductRepository>()),
                        child: CustomSearchItem()),
                    SizedBox(
                      height: 20.h,
                    ),
                    //TODO: build Categories
                    BlocProvider(
                      create: (context) => CategoriesCubit(
                          categoriesRepository:
                              instance<CategoriesRepository>())
                        ..getMainCategories(),
                      child: BlocBuilder<CategoriesCubit, CategoriesStates>(
                        builder: (context, state) {
                          if (state is MainCategoriesSuccessState) {
                            return Container(
                              height: 70.h,
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
                                      padding: EdgeInsets.only(
                                          right: 8.sp, left: 8.sp),
                                      child: CustomBuildCategory(
                                        image: state.mainCategories[i].image
                                            .toString(),
                                        title: state.mainCategories[i].name
                                            .toString(),
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
              //TODO: ****************************************** BOTTOM SCREEN *********************************
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
                      return SizedBox(
                      height: 170.h,
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
              //TODO : CarouselSliderWidget
              CarouselSliderWidget(id: "8"),

              //TODO :Latest Product
              SizedBox(
                height: 5.h,
              ),
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
                      return SizedBox(
                          height: 170.h,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("https://estore.almotkamel.com/image/catalog/Banners/slideshow/services-and-products/ara/almotkamel-store-slideshow_ar_01_gps.jpg")
                      )
                  ),
                  height: 130.h,
                  width: 450.w,
                  // child: CachedNetworkImage(
                  //   imageUrl: "https://sparetk.com/image/catalog/1.jpg",
                  //   placeholder: (context, url) => Image.asset(
                  //       "assets/images/place_holder2.png",
                  //       width: do.w),
                  //   errorWidget: (context, url, error) => Icon(Icons.error),
                  //   height: 150.h,
                  //   width: 200.w,
                  // ),
                ),
              ),
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
                      return SizedBox(
                        height: 170.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.productModel.productDataModel!.length,
                            itemBuilder: (context, index) {
                              print("name : ${state.productModel.productDataModel![index].name}");
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
                      );
                    } else if (state is ProductErrorState) {
                      print("Error : ${state.e.toString()}");
                      showToast(text: state.e.toString(), color: ToastColors.ERROR);
                    }
                    return const CustomMainProductShimmer();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
