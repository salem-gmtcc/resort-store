import 'package:resort_store/core/constants/route_constant.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../business_logic/cart/cubit.dart';
import '../../../business_logic/cart/state.dart';
import '../../../business_logic/change_theme/cubit.dart';
import '../../../business_logic/counter/cubit.dart';
import '../../../business_logic/product/cubit.dart';
import '../../../business_logic/product/state.dart';
import '../../../business_logic/wishlist/cubit.dart';
import '../../../business_logic/wishlist/state.dart';
import '../../../core/constants/strings_app.dart';
import '../../../core/helpers/app_router.dart';
import '../../../core/helpers/shared_prefrencess.dart';
import '../../../data/model/product/product.dart';
import '../../../data/repository/cart/cart.dart';
import '../../../data/repository/product/product.dart';
import '../../../data/repository/wishlist/wishlist.dart';
import '../../../di/di.dart';
import '../../../presentation/widgets/custom_button.dart';
import '../../../presentation/widgets/custom_padding.dart';
import '../../../presentation/widgets/dialog/custom_alert_dailog.dart';
import '../../../presentation/widgets/dialog/custom_awesome_dialog.dart';

class BuildItemProduct extends StatelessWidget {
  String? image, name,price,priceTax;
  int? id,specail;
  QuantityOffers? quantityOffers;
  int x =0 ;
  BuildItemProduct({
    required this.image,
    required this.name,
    required this.id,
    required this.priceTax,
    required this.price,
    required this.specail,
    required this.quantityOffers
  });

  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        AppRouter.to(context, RouteConstants.detailsTemplateScreen,
            arguments: id);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w),
        child: Container(
          height: 200.h,
          width: 150.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                width: 0.8.w,
                color: AppColor.grey,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(5.sp),
                child: Container(
                  height: 100.h,
                  width: 140.w,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    )
                  ),
                  child: Stack(
                    children: [
                      //TODO : IMAGE
                      Center(
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
                      //TODO : FAV & COMPARE
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          quantityOffers == null ? const SizedBox.shrink() :
                          Container(
                            width: 40.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                                color: AppColor.colorRedDark,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.r),

                                )),
                            child: Center(
                              child: Text(AppStrings.offer.tr(),
                                  style: boldTextStyle(
                                      fontSize: 10.sp, color: AppColor.white)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 3.w, left: 3.w),
                            child: Container(
                              width: 60.w,
                              height: 25.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                            InkWell(
                                              onTap: () {
                                                var comparedItems = SharedHelper
                                                    .sharedPreferences
                                                    .getString("ComparedItems");
                                                comparedItems =
                                                    (comparedItems ?? "") +
                                                        id.toString() +
                                                        ",";
                                                SharedHelper.sharedPreferences
                                                    .setString("ComparedItems",
                                                    comparedItems);
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback(
                                                        (timeStamp) {
                                                      customAwesomeDialog(
                                                          context,
                                                          "Compare Successfully",
                                                          DialogType.success);
                                                    });
                                              },
                                              child: Container(
                                                child: SvgPicture.asset(
                                                    "assets/icons/Mask Group -1.svg",
                                                    color: AppColor.grey.withOpacity(0.8),
                                                height: 15.h,
                                                  width: 20.w,
                                                ),

                                                decoration: BoxDecoration(
                                                  color: AppColor.white1,
                                                  shape: BoxShape.circle
                                                ),
                                                height: 20.h,
                                                width: 25.w,
                                              ),
                                            ),
                                            // if (state
                                            //     is ProductCompareLoadingState)
                                            //   const Center(
                                            //     child:
                                            //         CircularProgressIndicator(),
                                            //   )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 0.w,
                                  ),
                                  //TODO : Favourite
                                  BlocProvider(
                                    create: (context) => WishListCubit(
                                        wishListRepository:
                                        instance<WishListRepository>()),
                                    child: BlocBuilder<WishListCubit,
                                        WishListStates>(
                                      builder: (context, state) {
                                        if (state is SuccessWishListState) {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((timeStamp) {
                                            customAwesomeDialog(
                                                context,
                                                AppStrings
                                                    .addToWishListSuccessfully
                                                    .tr(),
                                                DialogType.success);
                                          });
                                        } else if (state is ErrorWishListState) {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((timeStamp) {
                                            customAwesomeDialog(
                                                context,
                                                state.error.toString(),
                                                DialogType.error);
                                          });
                                        }
                                        return Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                context
                                                    .read<WishListCubit>()
                                                    .sendWishListCubit(
                                                    id.toString());
                                              },
                                              child: Container(
                                                child: SvgPicture.asset(
                                                  "assets/icons/Mask Group 8.svg",
                                                  color: AppColor.grey
                                                      .withOpacity(0.8),
                                                  height: 15.h,
                                                  width: 20.w,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: AppColor.white1,
                                                    shape: BoxShape.circle
                                                ),
                                                height: 20.h,
                                                width: 25.w,
                                              ),
                                            ),
                                            // if (state is LoadingWishListState)
                                            //   Center(
                                            //       child:
                                            //           CircularProgressIndicator(
                                            //     color: AppColor.white,
                                            //   ))
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Text(
                  name!,
                  overflow: TextOverflow.ellipsis,
                  style: mediumTextStyle(fontSize: 10.sp, color: AppColor.lightBlack3),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(right: 5.w, left: 5.w),
                child: Container(
                  height: 32.h,
                  width: 130.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //TODO: price with Tax
                      Text(price.toString(), style: boldTextStyle(fontSize: 10.sp, color: AppColor.lightBlack4)),
                      SizedBox(width:2.w,),
                       //TODO: price
                      // Text(
                      // price.toString(),
                      //   style: TextStyle(
                      //     fontSize: 10.sp,
                      //       fontWeight: FontWeight.w400,
                      //       decoration: TextDecoration.lineThrough,
                      //       color: AppColor.lightBlack3),
                      // ),
                      SizedBox(width: 2.5.w,),
                      // TODO : Add To Cart
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
                                          image: "shopping-basket-Bold.svg",
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
                                                      color:
                                                          AppColor.primaryAmwaj,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
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
                                                          icon:
                                                              const Icon(Icons.add),
                                                          iconSize: 25.0,
                                                          color: AppColor
                                                              .coloGreenLight,
                                                        ),
                                                        BlocBuilder<CartCubit,
                                                            CartStates>(
                                                          builder:
                                                              (context, state) {
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
                                                          icon: const Icon(
                                                              Icons.remove),
                                                          color: AppColor
                                                              .coloGreenLight,
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
                                                          "product_id":
                                                              id.toString(),
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
                                                      title:
                                                          AppStrings.addToCart.tr(),
                                                      elevation: 5.0,
                                                      radius: 10.0,
                                                      height: 40.h,
                                                      width: 100.w,
                                                      color: context
                                                              .read<
                                                                  ThemeDataCubit>()
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
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: AppColor
                                                                .primaryAmwaj),
                                                  )
                                              ],
                                            ),
                                            title: AppStrings.quantity.tr());
                                      },
                                    ),
                                  ));
                        },
                        child: Container(
                          width: 25.w,
                          height: 25.h,
                          child:SvgPicture.asset(
                            "assets/icons/Group 2205.svg",
                            height: 15.h,
                            width: 15.w,
                            color: AppColor.spareTKTemplate,
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
