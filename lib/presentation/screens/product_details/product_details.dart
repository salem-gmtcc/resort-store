import 'package:resort_store/business_logic/cart/cubit.dart';
import 'package:resort_store/business_logic/cart/state.dart';
import 'package:resort_store/business_logic/change_theme/cubit.dart';
import 'package:resort_store/business_logic/getCalculation/calculation_cubit.dart';
import 'package:resort_store/business_logic/product/cubit.dart';
import 'package:resort_store/business_logic/product/state.dart';
import 'package:resort_store/business_logic/wishlist/cubit.dart';
import 'package:resort_store/business_logic/wishlist/state.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/textStyle_helper.dart';
import 'package:resort_store/data/model/getCalculations/getCalculations.dart';
import 'package:resort_store/data/repository/product/product.dart';
import 'package:resort_store/data/repository/wishlist/wishlist.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:resort_store/presentation/widgets/product_item.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../core/helpers/app_router.dart';
import '../../../core/helpers/shared_prefrencess.dart';
import '../../../data/repository/cart/cart.dart';
import '../../../data/repository/getCalculations/getCalculations.dart';
import '../../widgets/custom_chechbox_tree.dart';
import '../../widgets/dialog/custom_awesome_dialog.dart';
import '../../widgets/shimmer/shimmer_products/custom_product_details_shimmer.dart';
import '../../widgets/shimmer/shimmer_products/custom_product_main_shimmer.dart';

class ProductDetails extends StatefulWidget {
  int? id;

  ProductDetails({required this.id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;
  String price = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0.0,
        primary: true,
        leading: InkWell(
            onTap: () {
              AppRouter.back(context);
            },
            child: Icon(Icons.arrow_back, color: AppColor.black, size: 22.sp)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Icon(Icons.notifications, size: 20.sp, color: AppColor.black),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocBuilder<ProductCubit, ProductStates>(
                builder: (context, state) {
          if (state is SuccessProductDetailsState) {
            if (state.productDetailsModel.productDataModel!.quantityOffers ==
                null) {
              print(" --------------- value is null");
            } else {
              print(
                  " --------------- value is ${state.productDetailsModel.productDataModel!.quantityOffers!.quantityOffersInit![0].high}");
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //TODO : IMAGE
                Hero(
                  tag: "image",
                  child: Container(
                      height: 150.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.r),
                              bottomRight: Radius.circular(30.r))),
                      child: Stack(
                        children: [
                          state.productDetailsModel.productDataModel!
                                      .quantityOffers ==
                                  null
                              ? const SizedBox.shrink()
                              : Positioned(
                                  bottom: 0.0,
                                  left: 0.0,
                                  child: Container(
                                    child: Center(
                                      child: Text("Quantity Offer",
                                          style: mediumTextStyle(
                                              fontSize: 12.sp,
                                              color: AppColor.white)),
                                    ),
                                    height: 35.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                        color: AppColor.red,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20.r),
                                          bottomLeft: Radius.circular(30.r),
                                        )),
                                  ),
                                ),
                          Center(
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/images/img.png",
                              image: state
                                  .productDetailsModel.productDataModel!.image
                                  .toString(),
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 5.h,
                ),
                //TODO: NAME
                CustomPadding.symmetric(
                  vertical: 5,
                  horizontal: 10,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                            state.productDetailsModel.productDataModel!.name
                                .toString(),
                            style: mediumTextStyle(
                                fontSize: 13.sp, color: AppColor.white)),
                      ),
                      BlocProvider(
                        create: (context) => WishListCubit(
                            wishListRepository: instance<WishListRepository>()),
                        child: BlocBuilder<WishListCubit, WishListStates>(
                          builder: (context, state) {
                            if (state is SuccessWishListState) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                customAwesomeDialog(
                                    context,
                                    AppStrings.addToWishListSuccessfully.tr(),
                                    DialogType.success);
                              });
                            } else if (state is ErrorWishListState) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                customAwesomeDialog(context,
                                    state.error.toString(), DialogType.error);
                              });
                            }
                            return Stack(
                              children: [
                                CustomPadding.symmetric(
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context
                                              .read<WishListCubit>()
                                              .sendWishListCubit(
                                                  widget.id.toString());
                                        },
                                        child: Icon(
                                          Icons.star,
                                          color: AppColor.lightWhite2,
                                          size: 25.sp,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          var comparedItems = SharedHelper
                                              .sharedPreferences
                                              .getString("ComparedItems");
                                          comparedItems =
                                              (comparedItems ?? "") +
                                                  widget.id.toString() +
                                                  ",";
                                          SharedHelper.sharedPreferences
                                              .setString("ComparedItems",
                                                  comparedItems);
                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                                  (timeStamp) {
                                            customAwesomeDialog(
                                                context,
                                                AppStrings.compareSuccessfully
                                                    .tr(),
                                                DialogType.success);
                                          });
                                        },
                                        child: Icon(
                                          Icons.compare,
                                          color: AppColor.lightWhite2,
                                          size: 25.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  horizontal: 15.w,
                                ),
                                if (state is LoadingWishListState)
                                  Center(
                                      child: CircularProgressIndicator(
                                    color: AppColor.white,
                                  ))
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                //TODO : price
                CustomPadding.symmetric(
                  horizontal: 8.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //TODO: Tax
                      Container(
                        width: 100.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: AppColor.red,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                        child: Center(
                          child: Text(
                              "${state.productDetailsModel.productDataModel!.priceTax.toString().tr()} ${AppStrings.tax.tr()}",
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: AppColor.white,
                              )),
                        ),
                      ),
                      //TODO : price
                      Container(
                        width: 80.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                          color: AppColor.colorButton1,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                                state.productDetailsModel.productDataModel!
                                    .priceFormat
                                    .toString(),
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.white,
                                )),
                            Text(
                                state.productDetailsModel.productDataModel!
                                    .priceFormat
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  height: 0.0,
                                  color: AppColor.white,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: 10.h,
                ),
                //TODO: Product Details
                CustomPadding.symmetric(
                  horizontal: 4.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        AppStrings.productDetails.tr(),
                        style: boldTextStyle(
                            color: AppColor.white, fontSize: 13.sp),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      // Text(
                      //   state.productDetailsModel.productDataModel!.description
                      //       .toString(),
                      //   style: mediumTextStyle(
                      //       color: AppColor.white, fontSize: 10.sp),
                      // ),
                      HtmlWidget(
                        state.productDetailsModel.productDataModel!.description
                            .toString(),
                        textStyle: mediumTextStyle(
                            color: AppColor.white, fontSize: 10.sp),
                      )
                    ],
                  ),
                ),
                //TODO: Specification
                CustomPadding.symmetric(
                  vertical: 5.h,
                  horizontal: 5.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.specification.tr(),
                        style: boldTextStyle(
                            color: AppColor.white, fontSize: 13.sp),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColor.white1,
                        size: 15.sp,
                      )
                    ],
                  ),
                ),
                //TODO: TO FROM : ***  QUANTITY Offers
                state.productDetailsModel.productDataModel!.quantityOffers ==
                        null
                    ? const SizedBox.shrink()
                    : Center(
                        child: Container(
                        width: 320.w,
                        height: 120.h,
                        child: DataTable(
                          dataRowHeight: 25.h,
                          dividerThickness: 10.0,
                          border: TableBorder.all(
                            borderRadius: BorderRadius.circular(15.r),
                            color: AppColor.white,
                          ),
                          columns: [
                            DataColumn(
                                label: Center(
                                    child: Text(
                              AppStrings.from.tr(),
                              style: textStyleCustom(
                                  fontSize: 15.sp, fontColor: AppColor.white),
                            ))),
                            DataColumn(
                                label: Center(
                                    child: Text(AppStrings.to.tr(),
                                        style: textStyleCustom(
                                            fontSize: 15.sp,
                                            fontColor: AppColor.white)))),
                            DataColumn(
                                label: Center(
                                    child: Text(AppStrings.price.tr(),
                                        style: textStyleCustom(
                                            fontSize: 15.sp,
                                            fontColor: AppColor.white)))),
                          ],
                          rows: List.generate(
                            state.productDetailsModel.productDataModel!
                                .quantityOffers!.quantityOffersInit!.length,
                            (index) => DataRow(cells: [
                              DataCell(Text(
                                state
                                    .productDetailsModel
                                    .productDataModel!
                                    .quantityOffers!
                                    .quantityOffersInit![index]
                                    .low
                                    .toString(),
                                style: mediumTextStyle(
                                    fontSize: 10.sp, color: AppColor.white),
                              )),
                              DataCell(Text(
                                  state
                                      .productDetailsModel
                                      .productDataModel!
                                      .quantityOffers!
                                      .quantityOffersInit![index]
                                      .high
                                      .toString(),
                                  style: mediumTextStyle(
                                      fontSize: 10.sp, color: AppColor.white))),
                              DataCell(Text(
                                  state
                                      .productDetailsModel
                                      .productDataModel!
                                      .quantityOffers!
                                      .quantityOffersInit![index]
                                      .price
                                      .toString(),
                                  style: mediumTextStyle(
                                      fontSize: 10.sp, color: AppColor.white))),
                            ]),
                          ),
                        ),
                      )),
                //TODO  Build Tree ***********
                SizedBox(
                  height: 10.h,
                ),
                // CustomCheckBoxTree(),
                // TODO: Review
                CustomPadding.symmetric(
                  vertical: 5.h,
                  horizontal: 5.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.review.tr(),
                          style: boldTextStyle(
                              fontSize: 13.sp, color: AppColor.white)),
                      RatingBar.builder(
                        itemSize: 15.0.sp,
                        initialRating: 0.0,
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
                SizedBox(
                  height: 10.h,
                ),
                //TODO: Button
                Center(
                  child: Container(
                    width: 250.w,
                    height: 50.h,
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
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              customAwesomeDialog(context,
                                  state.error.toString(), DialogType.error);
                            });
                          }
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  print(
                                      "************************ id ${widget.id}");
                                  context.read<CartCubit>().postCartCubit({
                                    "product_id": widget.id.toString(),
                                    "quantity": qty
                                  });

                                  //TODO : Calculation Price

                                  CalculationBody ca =
                                      CalculationBody(qty: 2, price: "156");
                                  print("------------___  price ${ca.price}");
                                  print("------------___  qty ${ca.qty}");
                                  print(
                                      "------------___  id ${widget.id.toString()}");
                                  context
                                      .read<CalculationCubit>()
                                      .getCalculationData(
                                          widget.id.toString(),
                                          CalculationBody(
                                              qty: 2, price: "150"));
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 250.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColor.white,
                                  ),
                                  child: CustomPadding.symmetric(
                                    horizontal: 3.w,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 25.h,
                                          width: 25.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              color: AppColor.primaryLight
                                                  .withOpacity(0.2)),
                                          child: Center(
                                              child: Icon(Icons.shopping_bag,
                                                  color:
                                                      AppColor.primaryAmwaj)),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          AppStrings.addToCart.tr(),
                                          style: mediumTextStyle(
                                              fontSize: 12.sp,
                                              color: AppColor.primaryAmwaj),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text("|",
                                            style: mediumTextStyle(
                                                fontSize: 12.sp,
                                                color:
                                                    AppColor.primaryAmwaj)),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        //TODO: COUNTER
                                        Container(
                                          width: 95.w,
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                            color: AppColor.primaryLight,
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                          ),
                                          child: CustomPadding.symmetric(
                                            horizontal: 5.sp,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    height: 20.h,
                                                    width: 25.w,
                                                    decoration: BoxDecoration(
                                                        color: AppColor
                                                            .primaryAmwaj,
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
                                                                .white))),
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
                                                        color: AppColor
                                                            .primaryAmwaj,
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
                                                                .white))),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                    ),
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
                  height: 20.h,
                ),
                //TODO: Product Related Text
                CustomPadding.symmetric(
                  horizontal: 5.0,
                  child: Text(AppStrings.productRelated.tr(),
                      style: boldTextStyle(
                          fontSize: 13.sp, color: AppColor.white)),
                ),
                //TODO: Product Related
                MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) => ProductCubit(
                            productRepository: instance<ProductRepository>())
                          ..getRelatedProductCubit(widget.id.toString())),
                    BlocProvider(
                        create: (context) => CartCubit(
                            cartRepository: instance<CartRepository>())),
                  ],
                  child: BlocBuilder<ProductCubit, ProductStates>(
                    builder: (context, state) {
                      if (state is SuccessProductRelatedState) {
                        print(
                            "*/**/* :${state.productModel.productDataModel!.length}");
                        if (state.productModel.productDataModel!.isNotEmpty) {
                          return CustomPadding.symmetric(
                            horizontal: 5.w,
                            child: SizedBox(
                              height:
                                  state.productModel.productDataModel!.isEmpty
                                      ? 10.h
                                      : 220.h,
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          childAspectRatio: 1.5),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state
                                      .productModel.productDataModel!.length,
                                  itemBuilder: (context, index) {
                                    print("**************************** idddddd ${state.productModel.productDataModel![index].productId}");
                                    return ProductItem(
                                      image: state.productModel
                                          .productDataModel![index].thumb,
                                      name: state.productModel
                                          .productDataModel![index].name,
                                      rating: state.productModel
                                          .productDataModel![index].rating,
                                      id: state.productModel
                                          .productDataModel![index].productId,
                                      priceExcludingTax:state.productModel
                                          .productDataModel![index].priceExcludingTax ,
                                      priceFormat: state.productModel
                                          .productDataModel![index].priceFormat,
                                      quantityOffers: state
                                          .productModel
                                          .productDataModel![index]
                                          .quantityOffers,
                                    );
                                  }),
                            ),
                          );
                        } else {
                          return Center(
                              child: Column(
                            children: [
                              Image.asset("assets/images/empty_box.png",
                                  color: AppColor.white,
                                  width: 120.w,
                                  height: 100.h),
                              Text(AppStrings.noProductRelated.tr(),
                                  style: textStyleCustom(
                                      fontColor: AppColor.white,
                                      fontSize: 13.sp)),
                            ],
                          ));
                        }
                      } else if (state is ProductLoadingState) {
                        const Center(child: CustomMainProductShimmer());
                      } else if (state is ProductErrorState) {
                        showToast(
                            text: state.e.toString(), color: ToastColors.ERROR);
                      }
                      return const CustomMainProductShimmer();
                    },
                  ),
                )
              ],
            );
          } else if (state is ProductLoadingState) {
            const CustomProductDetailsShimmer();
          } else if (state is ProductErrorState) {
            showToast(text: state.e.toString(), color: ToastColors.ERROR);
          }
          return const CustomProductDetailsShimmer();
        }),
      ),
    );
  }
}
