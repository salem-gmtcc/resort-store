import 'package:resort_store/business_logic/change_theme/cubit.dart';
import 'package:resort_store/business_logic/counter/cubit.dart';
import 'package:resort_store/business_logic/product/cubit.dart';
import 'package:resort_store/business_logic/product/state.dart';
import 'package:resort_store/core/constants/route_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/data/model/product/product.dart';
import 'package:resort_store/data/repository/cart/cart.dart';
import 'package:resort_store/data/repository/product/product.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/dialog/custom_awesome_dialog.dart';
import 'package:resort_store/presentation/widgets/custom_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../business_logic/cart/cubit.dart';
import '../../business_logic/cart/state.dart';
import '../../business_logic/wishlist/cubit.dart';
import '../../business_logic/wishlist/state.dart';
import '../../core/helpers/textStyle_helper.dart';
import '../../data/repository/wishlist/wishlist.dart';
import '../resources/color_manger.dart';
import 'dialog/custom_alert_dailog.dart';

class ProductItem extends StatelessWidget {
  String? image, name, priceFormat, priceExcludingTax;
  int? id, rating;
  QuantityOffers? quantityOffers;

  // Widget? iconCompare;
  //
  // Widget? cartButton;

  ProductItem(
      {required this.image,
      required this.name,
      required this.rating,
      required this.id,
      required this.priceFormat,
      required this.priceExcludingTax,
      required this.quantityOffers
      /*this.iconCompare,
      this.cartButton*/
      });

  int qty = 0;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TODO : IMAGE CARD
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: InkWell(
                  onTap: () {
                    print("**************** 1");
                    AppRouter.to(context, RouteConstants.detailsTemplateScreen,
                        arguments: id);
                  },
                  child: Center(
                    child: Container(
                        height: 100.h,
                        width: 100.w,
                        child: image == null
                            ? Image.asset("assets/images/img.png")
                            : FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                placeholder: "assets/images/img.png",
                                image: image.toString())),
                  ),
                ),
              ),
              // TODO : TEXT
              Padding(
                padding: EdgeInsets.only(right: 6.w, left: 6.w),
                child: Container(
                  height: 25.h,
                  width: 120.w,
                  child: Text(
                    name.toString().tr(),
                    overflow: TextOverflow.ellipsis,
                    style: textStyleCustom(
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
              //TODO : Price
              Padding(
                padding: EdgeInsets.only(left: 3.w, right: 3.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${AppStrings.price.tr()} : ",
                        style: textStyleCustom(
                          fontSize: 9.sp,
                        )),
                    Text(
                      priceExcludingTax.toString(),
                      style: mediumTextStyle(
                        fontSize: 9.sp,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              //TODO : Price with Tax
              Padding(
                padding: EdgeInsets.only(left: 3.w, right: 3.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${AppStrings.priceWithTax.tr()}: ",
                        style: textStyleCustom(
                          fontSize: 9.sp,
                        )),
                    Text(
                      priceFormat!,
                      style: mediumTextStyle(fontSize: 9.h, color: Colors.red),
                    ),
                  ],
                ),
              ),
              //TODO : Review Star
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    RatingBar.builder(
                      itemSize: 15.0.sp,
                      initialRating: rating!.toDouble(),
                      minRating: 1,
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
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      rating.toString().tr(),
                      style: mediumTextStyle(
                          fontSize: 10.sp, color: AppColor.primaryAmwaj),
                    )
                  ],
                ),
              ),
              //TODO : cart button
              /* cartButton != null
                  ? const SizedBox.shrink()
                  :*/
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                  create: (context) => CartCubit(
                                      cartRepository:
                                          instance<CartRepository>())),
                              //BlocProvider(create: (context)=>CounterCubit())
                            ],
                            child: BlocBuilder<CartCubit, CartStates>(
                              builder: (context, state) {
                                print(":::: state $state");
                                if (state is SuccessAddCartState) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    customAwesomeDialog(
                                        context,
                                        AppStrings.addSuccessfully.tr(),
                                        DialogType.success);
                                  });
                                } else if (state is ErrorCartState) {
                                  print("*************** error");
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    customAwesomeDialog(
                                        context,
                                        state.error.toString(),
                                        DialogType.error);
                                  });
                                }
                                return CustomAlertDialog(
                                    image: "",
                                    widget: Stack(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Divider(
                                              height: 1.0,
                                              color: AppColor.primaryAmwaj,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    qty++;

                                                    context
                                                        .read<CartCubit>()
                                                        .increment();

                                                    print(
                                                        "************************************************************ bbbbb");
                                                  },
                                                  icon: const Icon(Icons.add),
                                                  iconSize: 25.0,
                                                  color:
                                                      AppColor.coloGreenLight,
                                                ),
                                                BlocBuilder<CartCubit,
                                                    CartStates>(
                                                  builder: (context, state) {
                                                    return Text(context
                                                        .read<CartCubit>()
                                                        .getQuantity()
                                                        .toString());
                                                  },
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<CartCubit>()
                                                        .decrement();
                                                  },
                                                  icon:
                                                      const Icon(Icons.remove),
                                                  color:
                                                      AppColor.coloGreenLight,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            CustomButton(
                                              onPressed: () {
                                                context
                                                    .read<CartCubit>()
                                                    .postCartCubit({
                                                  "product_id": id.toString(),
                                                  "quantity": context
                                                      .read<CartCubit>()
                                                      .getQuantity()
                                                      .toString()
                                                });

                                                context
                                                    .read<CounterCubit>()
                                                    .addItemCountCubit();

                                                // context.read<CounterCubit>().AddItemCountCubit();

                                                Future.delayed(
                                                  Duration(seconds: 3),
                                                  () {
                                                    AppRouter.back(context);
                                                  },
                                                );
                                              },
                                              title: AppStrings.addToCart.tr(),
                                              elevation: 5.0,
                                              radius: 10.0,
                                              height: 40.h,
                                              width: 100.w,
                                              color: context
                                                      .read<ThemeDataCubit>()
                                                      .recolor ??
                                                  AppColor.primaryAmwaj,
                                              textStyle: mediumTextStyle(
                                                  fontSize: 12.0,
                                                  color: AppColor.white),
                                            ),
                                          ],
                                        ),
                                        if (state is LoadingCartState)
                                          Center(
                                            child: CircularProgressIndicator(
                                                color: AppColor.primaryAmwaj),
                                          )
                                      ],
                                    ),
                                    title: AppStrings.quantity.tr());
                              },
                            ),
                          ));
                },
                child: Card(
                  elevation: 0.5,
                  child: Container(
                    height: 30.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: context.read<ThemeDataCubit>().recolor ??
                            AppColor.primaryAmwaj,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.shopping_cart_outlined,
                            color: AppColor.white, size: 15.sp),
                        Text(AppStrings.addToCart.tr(),
                            style: mediumTextStyle(
                                fontSize: 10.sp, color: AppColor.white)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),

          Positioned(
            right: 0,
            child: Container(
              height: 30.h,
              width: 70.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TODO : Compare
                  BlocProvider<ProductCubit>(
                    create: (context) => ProductCubit(
                        productRepository: instance<ProductRepository>()),
                    child: BlocBuilder<ProductCubit, ProductStates>(
                      builder: (context, state) {
                        return Stack(
                          children: [
                            //TODO : Compare Icon
                            Card(
                              elevation: 10.0,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.r),
                                  borderSide: BorderSide(
                                      color: AppColor.white, width: 0.1)),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.r),
                                      color: Colors.white),
                                  width: 25,
                                  height: 25,
                                  child: InkWell(
                                      onTap: () {
                                        var comparedItems = SharedHelper
                                            .sharedPreferences
                                            .getString("ComparedItems");
                                        comparedItems = (comparedItems ?? "") +
                                            id.toString() +
                                            ",";
                                        SharedHelper.sharedPreferences
                                            .setString(
                                                "ComparedItems", comparedItems);
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((timeStamp) {
                                          customAwesomeDialog(
                                              context,
                                              "Compare Successfully",
                                              DialogType.success);
                                        });
                                      },
                                      child: Center(
                                        child: SvgPicture.asset(
                                            width: 17.w,
                                            height: 17.h,
                                            color:
                                                AppColor.grey.withOpacity(0.6),
                                            "assets/icons/Mask Group -1.svg"),
                                      ))),
                            ),
                            if (state is ProductCompareLoadingState)
                              const Center(
                                child: CircularProgressIndicator(),
                              )
                          ],
                        );
                      },
                    ),
                  ),
                  //TODO : Favourite
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
                            customAwesomeDialog(context, state.error.toString(),
                                DialogType.error);
                          });
                        }
                        return Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                context
                                    .read<WishListCubit>()
                                    .sendWishListCubit(id.toString());
                              },
                              child: Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.r),
                                      color: Colors.white),
                                  width: 25,
                                  height: 25,
                                  child: SvgPicture.asset(
                                    "assets/icons/Mask Group 8.svg",
                                    color: AppColor.grey.withOpacity(0.5),
                                    width: 5.w,
                                  ),
                                ),
                                elevation: 10.0,
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.r),
                                    borderSide: BorderSide(
                                        color: AppColor.white, width: 0.1)),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // TODO: Quantity Offer
          quantityOffers == null
              ? const SizedBox.shrink()
              : Positioned(
                  left: 0.0,
                  child: Container(
                    height: 25.h,
                    width: 60.w,
                    child: Center(
                        child: Text(AppStrings.offer.tr(),
                            style: boldTextStyle(
                                fontSize: 12.sp, color: AppColor.white))),
                    decoration: BoxDecoration(
                        color: AppColor.red,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.r))),
                  ),
                ),
        ],
      ),
    );
  }
}
