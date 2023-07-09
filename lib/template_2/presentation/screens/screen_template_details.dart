import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../business_logic/cart/cubit.dart';
import '../../../business_logic/cart/state.dart';
import '../../../business_logic/getCalculation/calculation_cubit.dart';
import '../../../business_logic/product/cubit.dart';
import '../../../business_logic/product/state.dart';
import '../../../business_logic/wishlist/cubit.dart';
import '../../../business_logic/wishlist/state.dart';
import '../../../core/constants/strings_app.dart';
import '../../../core/helpers/app_router.dart';
import '../../../core/helpers/shared_prefrencess.dart';
import '../../../core/helpers/textStyle_helper.dart';
import '../../../data/model/getCalculations/getCalculations.dart';
import '../../../data/repository/cart/cart.dart';
import '../../../data/repository/getCalculations/getCalculations.dart';
import '../../../data/repository/product/product.dart';
import '../../../data/repository/wishlist/wishlist.dart';
import '../../../di/di.dart';
import '../../../presentation/resources/color_manger.dart';
import '../../../presentation/widgets/custom_padding.dart';
import '../../../presentation/widgets/custom_toast.dart';
import '../../../presentation/widgets/dialog/custom_awesome_dialog.dart';
import '../../../presentation/widgets/product_item.dart';
import '../../../presentation/widgets/shimmer/shimmer_products/custom_product_details_shimmer.dart';
import '../../../presentation/widgets/shimmer/shimmer_products/custom_product_main_shimmer.dart';



class DetailsTemplateScreen extends StatelessWidget {
  int? id;

  DetailsTemplateScreen({required this.id});

  int qty = 1;
  String price = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 10.0,
        primary: true,
        leading: InkWell(
            onTap: () {
              AppRouter.back(context);
            },
            child: Icon(Icons.arrow_back,
                color: AppColor.lightBlack4, size: 20.sp)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset("assets/icons/bell-Bold.svg",
                color: AppColor.lightBlack4),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<ProductCubit, ProductStates>(
          builder: (context, state) {
            if (state is SuccessProductDetailsState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //TODO : Image
                  Container(
                    height: 150.h,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Center(
                            child: Image.network(
                          state.productDetailsModel.productDataModel!.image
                              .toString(),
                          fit: BoxFit.cover,
                          width: 180.w,
                        )),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 20.w, left: 20.w, top: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              state.productDetailsModel.productDataModel!
                                          .quantityOffers ==
                                      null
                                  ? SizedBox.shrink()
                                  : Container(
                                      width: 50.w,
                                      height: 25.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(3.r),
                                        color: AppColor.primaryAmwaj,
                                      ),
                                      child: Center(
                                          child: Text("10%",
                                              style: boldTextStyle(
                                                  fontSize: 12.sp,
                                                  color: AppColor.white))),
                                    ),
                              Container(
                                width: 100.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BlocProvider(
                                      create: (context) => WishListCubit(
                                          wishListRepository:
                                              instance<WishListRepository>()),
                                      child: BlocBuilder<WishListCubit,
                                          WishListStates>(
                                        builder: (context, state) {
                                          if (state is SuccessWishListState) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback(
                                                    (timeStamp) {
                                              customAwesomeDialog(
                                                  context,
                                                  AppStrings
                                                      .addToWishListSuccessfully
                                                      .tr(),
                                                  DialogType.success);
                                            });
                                          } else if (state
                                              is ErrorWishListState) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback(
                                                    (timeStamp) {
                                              customAwesomeDialog(
                                                  context,
                                                  state.error.toString(),
                                                  DialogType.error);
                                            });
                                          }
                                          return Stack(
                                            children: [
                                              CustomPadding.symmetric(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        var comparedItems =
                                                            SharedHelper
                                                                .sharedPreferences
                                                                .getString(
                                                                    "ComparedItems");
                                                        comparedItems =
                                                            (comparedItems ??
                                                                    "") +
                                                                id.toString() +
                                                                ",";
                                                        SharedHelper
                                                            .sharedPreferences
                                                            .setString(
                                                                "ComparedItems",
                                                                comparedItems);
                                                        WidgetsBinding.instance
                                                            .addPostFrameCallback(
                                                                (timeStamp) {
                                                          customAwesomeDialog(
                                                              context,
                                                              AppStrings
                                                                  .compareSuccessfully
                                                                  .tr(),
                                                              DialogType
                                                                  .success);
                                                        });
                                                      },
                                                      child: SvgPicture.asset(
                                                          "assets/icons/Mask Group -1.svg",
                                                          color: AppColor.grey
                                                              .withOpacity(0.6),
                                                          width: 20.w,
                                                          height: 20.h),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                WishListCubit>()
                                                            .sendWishListCubit(
                                                                id.toString());
                                                      },
                                                      child: SvgPicture.asset(
                                                          "assets/icons/Mask Group 8.svg",
                                                          width: 20.w,
                                                          height: 20.h),
                                                    ),
                                                  ],
                                                ),
                                                horizontal: 15.w,
                                              ),
                                              if (state is LoadingWishListState)
                                                Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  color: AppColor.white,
                                                ))
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  //TODO : Name And Rating
                  Container(
                    height: 300.h,
                    decoration: BoxDecoration(
                        color: HexColor("#ecedef"),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r),
                        )),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: 15.h, left: 5.w, right: 5.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //TODO: NAME AND RATING
                                Container(
                                  height: 70.h,
                                  width: 180.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.productDetailsModel
                                            .productDataModel!.name
                                            .toString(),
                                        style: TextStyle(
                                          color: AppColor.primaryAmwaj,
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                      RatingBar.builder(
                                        itemSize: 15.0.sp,
                                        initialRating: 2.5,
                                        minRating: 1,
                                        unratedColor: AppColor.white,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemBuilder: (context, _) => SizedBox(
                                          child: Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 5.sp,
                                          ),
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                //TODO : PRICE AND TAX PRICE
                                Container(
                                  height: 70.h,
                                  width: 130.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      //TODO: PRICE
                                      Container(
                                        child: Column(
                                          children: [
                                            Text(
                                                "${state.productDetailsModel.productDataModel!.priceExcludingTax}",
                                                style: boldTextStyle(
                                                    fontSize: 10.sp,
                                                    color: AppColor
                                                        .primaryAmwaj)),
                                            Text(
                                                "${AppStrings.tax.tr()}  ${state.productDetailsModel.productDataModel!.taxAmount}",
                                                style: mediumTextStyle(
                                                    fontSize: 8.sp,
                                                    color: AppColor
                                                        .primaryAmwaj)),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            /*    state
                                                .productDetailsModel
                                                .productDataModel!
                                                .special ==
                                                0
                                                ? SizedBox.shrink()
                                                :*/
                                            Text(
                                              "${AppStrings.totalPrice.tr()} ${state.productDetailsModel.productDataModel!.priceFormat.toString()} ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: AppColor.grey,
                                                  fontSize: 10.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Divider(
                            height: 1.h,
                            color: AppColor.lightBlack4,
                          ),
                          //TODO : PRODUCTS DEATAILS
                          Padding(
                            padding: EdgeInsets.only(right: 10.w, left: 10.w),
                            child: Text(
                              "${AppStrings.productDetails.tr()} :",
                              style: mediumTextStyle(
                                  fontSize: 12.sp,
                                  color: AppColor.primaryAmwaj),
                            ),
                          ),
                          //TODO : Text PRODUCTS DEATAILS
                          Padding(
                            padding: EdgeInsets.only(right: 10.w, left: 10.w),
                            child: HtmlWidget(
                              state.productDetailsModel.productDataModel!
                                  .description
                                  .toString()
                                  .trim(),
                              textStyle: mediumTextStyle(
                                  fontSize: 12.sp, color: AppColor.grey),
                            ),
                          ),
                          // //TODO : Specifications
                          // SizedBox(
                          //   height: 10.h,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(right: 10.w, left: 10.w),
                          //   child: Text(
                          //     "${AppStrings.specification.tr()} :",
                          //     style: mediumTextStyle(
                          //         fontSize: 12.sp,
                          //         color: AppColor.primaryAmwaj),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  // TODO: Products Related
                  // MultiBlocProvider(
                  //   providers: [
                  //     BlocProvider(
                  //         create: (context) => ProductCubit(
                  //             productRepository: instance<ProductRepository>())
                  //           ..getRelatedProductCubit(id.toString())),
                  //     BlocProvider(
                  //         create: (context) => CartCubit(
                  //             cartRepository: instance<CartRepository>())),
                  //   ],
                  //   child: BlocBuilder<ProductCubit, ProductStates>(
                  //     builder: (context, state) {
                  //       if (state is SuccessProductRelatedState) {
                  //         print(
                  //             "*/**/* :${state.productModel.productDataModel!.length}");
                  //         if (state.productModel.productDataModel!.isNotEmpty) {
                  //           return CustomPadding.symmetric(
                  //             horizontal: 5.w,
                  //             child: SizedBox(
                  //               height: 180.h,
                  //               child: ListView.builder(
                  //                   scrollDirection: Axis.horizontal,
                  //                   itemCount: state
                  //                       .productModel.productDataModel!.length,
                  //                   itemBuilder: (context, index) {
                  //                     print(
                  //                         "**************************** idddddd ${state.productModel.productDataModel![index].productId}");
                  //                     return BuildItemProduct(
                  //                       id: state.productModel
                  //                           .productDataModel![index].productId,
                  //                       image: state.productModel
                  //                           .productDataModel![index].thumb,
                  //                       name: state.productModel
                  //                           .productDataModel![index].name,
                  //                       specail:state.productModel
                  //                           .productDataModel![index].special,
                  //                       price: state
                  //                           .productModel
                  //                           .productDataModel![index]
                  //                           .priceFormat
                  //                           .toString(),
                  //                       priceTax: state
                  //                           .productModel
                  //                           .productDataModel![index]
                  //                           .priceExcludingTax
                  //                           .toString(),
                  //                       quantityOffers: state.productModel.productDataModel![index].quantityOffers,
                  //                     );
                  //                   }),
                  //             ),
                  //           );
                  //         } else {
                  //           return Center(
                  //               child: Column(
                  //             children: [
                  //               Image.asset("assets/images/empty_box.png",
                  //                   color: AppColor.black,
                  //                   width: 120.w,
                  //                   height: 100.h),
                  //               Text(AppStrings.noProductRelated.tr(),
                  //                   style: textStyleCustom(
                  //                       fontColor: AppColor.black,
                  //                       fontSize: 10.sp)),
                  //             ],
                  //           ));
                  //         }
                  //       } else if (state is ProductLoadingState) {
                  //         const Center(child: CustomMainProductShimmer());
                  //       } else if (state is ProductErrorState) {
                  //         showToast(
                  //             text: state.e.toString(),
                  //             color: ToastColors.ERROR);
                  //       }
                  //       return const CustomMainProductShimmer();
                  //     },
                  //   ),
                  // ),
                  //TODO: Button
                  Center(
                    child: Container(
                      width: 300.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35.r),
                          color: AppColor.primaryAmwaj),
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => CartCubit(
                                cartRepository: instance<CartRepository>()),
                          ),
                          BlocProvider(
                            create: (context) => CalculationCubit(
                                getCalculationRepo:
                                    instance<GetCalculationRepo>()),
                          ),
                        ],
                        child: BlocBuilder<CartCubit, CartStates>(
                          builder: (context, state) {
                            if (state is SuccessAddCartState) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                customAwesomeDialog(
                                    context,
                                    AppStrings.addSuccessfully.tr(),
                                    DialogType.success);
                              });
                            } else if (state is ErrorCartState) {
                              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                customAwesomeDialog(context,
                                    state.error.toString(), DialogType.error);
                              });
                            }
                            return Stack(
                              children: [
                                Container(
                                  height: 40.h,
                                  width: 400.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: AppColor.primaryAmwaj),
                                  child: CustomPadding.symmetric(
                                    horizontal: 3.w,
                                    child: Row(
                                      children: [
                                        //TODO: COUNTER
                                        Container(
                                          width: 95.w,
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                            color: AppColor.primaryAmwaj,
                                            borderRadius: BorderRadius.circular(5.r),
                                          ),
                                          child: CustomPadding.symmetric(
                                            horizontal: 5.sp,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    height: 20.h,
                                                    width: 25.w,
                                                    decoration: BoxDecoration(
                                                        color: AppColor.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r)),
                                                    child: InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<CartCubit>()
                                                              .increment();
                                                        },
                                                        child: Icon(Icons.add,
                                                            size: 15.sp,
                                                            color: AppColor
                                                                .primaryAmwaj))),
                                                BlocBuilder<CartCubit,
                                                        CartStates>(
                                                    builder: (context, state) {
                                                  if (state
                                                      is ChangeQuantityItemState) {
                                                    qty = state.qty;
                                                  }
                                                  return Text(qty.toString(),
                                                      style: mediumTextStyle(
                                                          height: 1.5.h,
                                                          fontSize: 20.0,
                                                          color:
                                                              AppColor.white));
                                                }),
                                                Container(
                                                    height: 20.h,
                                                    width: 25.w,
                                                    decoration: BoxDecoration(
                                                        color: AppColor.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r)),
                                                    child: InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<CartCubit>()
                                                              .decrement();
                                                        },
                                                        child: Icon(
                                                            Icons.remove,
                                                            size: 15.sp,
                                                            color: AppColor
                                                                .primaryAmwaj))),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(
                                                "************************ id ${id}");
                                            context
                                                .read<CartCubit>()
                                                .postCartCubit({
                                              "product_id": id.toString(),
                                              "quantity": qty
                                            });

                                            //TODO : Calculation Price

                                            CalculationBody ca =
                                                CalculationBody(
                                                    qty: 2, price: "156");
                                            print(
                                                "------------___  price ${ca.price}");
                                            print(
                                                "------------___  qty ${ca.qty}");
                                            print(
                                                "------------___  id ${id.toString()}");
                                            context
                                                .read<CalculationCubit>()
                                                .getCalculationData(
                                                    id.toString(),
                                                    CalculationBody(
                                                        qty: 2, price: "150"));
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.shopping_cart_outlined,
                                                  color: Colors.white),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                AppStrings.addToCart.tr(),
                                                style: mediumTextStyle(
                                                    fontSize: 12.sp,
                                                    color: AppColor.white),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                    ),
                                  ),
                                ),
                                if (state is LoadingCartState)
                                  Center(
                                    child: CircularProgressIndicator(
                                        color: AppColor.primaryAmwaj),
                                  )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  //TODO : PRODUCTS Related
                  Padding(
                    padding: EdgeInsets.only(right: 10.w, left: 10.w),
                    child: Text(
                      AppStrings.productRelated.tr(),
                      style: boldTextStyle(
                          fontSize: 15.sp, color: HexColor("#432a2a")),
                    ),
                  ),
                  MultiBlocProvider(
                    providers: [
                      BlocProvider(
                          create: (context) => ProductCubit(
                              productRepository: instance<ProductRepository>())
                            ..getRelatedProductCubit(id.toString())),
                      BlocProvider(
                          create: (context) => CartCubit(
                              cartRepository: instance<CartRepository>())),
                    ],
                    child: BlocBuilder<ProductCubit, ProductStates>(
                      builder: (context, state) {
                        if (state is SuccessProductRelatedState) {
                          print(
                              "*/**/* :${state.productModel.productDataModel!.length}");
                          if (state.productModel.productDataModel!.length !=
                              0) {
                            print("--------------------- //");
                            return Container(
                              height: 300.h,
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state
                                      .productModel.productDataModel!.length,
                                  itemBuilder: (context, index) {
                                    print(
                                        "**************************** idddddd ${state.productModel.productDataModel![index].productId}");
                                    return ProductItem(
                                      image: state.productModel
                                          .productDataModel![index].thumb,
                                      name: state.productModel
                                          .productDataModel![index].name,
                                      rating: state.productModel
                                          .productDataModel![index].rating,
                                      id: state.productModel
                                          .productDataModel![index].productId,
                                      priceExcludingTax: state
                                          .productModel
                                          .productDataModel![index]
                                          .priceExcludingTax.toString(),
                                      priceFormat: state.productModel
                                          .productDataModel![index].priceFormat.toString(),
                                      quantityOffers: state
                                          .productModel
                                          .productDataModel![index]
                                          .quantityOffers,
                                    );
                                  }),
                            );
                          } else {
                            print("/////////////////////////// 0");
                            return Center(
                                child: Container(
                                  width: 250.w,
                                  height: 120.h,
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/empty_box.png",
                                          color: AppColor.primaryAmwaj,
                                          width: 120.w,
                                          height: 100.h),
                                      Text(AppStrings.noProductRelated.tr(),
                                          style: textStyleCustom(
                                              fontColor: AppColor.primaryAmwaj,
                                              fontSize: 13.sp)),
                                    ],
                                  ),
                                ));
                          }
                        } else if (state is ProductLoadingState) {
                          const Center(child: CustomMainProductShimmer());
                        } else if (state is ProductErrorState) {
                          showToast(
                              text: state.e.toString(),
                              color: ToastColors.ERROR);
                        }
                        return const CustomMainProductShimmer();
                      },
                    ),
                  ),

                  SizedBox(
                    height: 25.h,
                  ),
                ],
              );
            } else if (state is ProductLoadingState) {
              const CustomProductDetailsShimmer();
            } else if (state is ProductErrorState) {
              showToast(text: state.e.toString(), color: ToastColors.ERROR);
            }
            return const CustomProductDetailsShimmer();
          },
        ),
      ),
    );
  }
}
