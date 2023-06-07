import 'package:resort_store/business_logic/cart/cubit.dart';
import 'package:resort_store/business_logic/cart/state.dart';
import 'package:resort_store/business_logic/main/cubit.dart';
import 'package:resort_store/business_logic/order/cubit.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/screens/my_pag/widget/custom_checkout_button.dart';
import 'package:resort_store/presentation/screens/my_pag/widget/custom_couponCode_item.dart';
import 'package:resort_store/presentation/screens/my_pag/widget/pag_item.dart';
import 'package:resort_store/presentation/widgets/dialog/custom_alert_dailog.dart';
import 'package:resort_store/presentation/widgets/custom_button.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/route_constant.dart';
import '../../../core/helpers/app_router.dart';
import '../../../data/repository/cart/cart.dart';
import '../../../data/repository/order/order.dart';
import '../../../di/di.dart';
import '../../resources/color_manger.dart';
import '../../widgets/dialog/custom_awesome_dialog.dart';
import '../../widgets/shimmer/shimmer_products/custom_product_shimmer.dart';

class MyPagScreen extends StatelessWidget {
  String? email = SharedHelper.sharedPreferences.getString(AppStrings.email);

  @override
  Widget build(BuildContext context) {
    return   BlocProvider(
        create: (context) =>
        CartCubit(cartRepository: instance<CartRepository>())
          ..getCartCubit(),
      child: BlocBuilder<CartCubit, CartStates>(
        builder: (context, state) {
          print("state $state");
          if (state is SuccessDeleteItemFromCartState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              customAwesomeDialog(context, AppStrings.deleteSuccessfully.tr(),
                  DialogType.success);
            });
            context.read<CartCubit>().getCartCubit();
          }
          else if (state is SuccessEmptyCartState) {
            return CustomPadding.symmetric(
              horizontal: 5.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/myPagIcon.png",
                      color: AppColor.white,
                      fit: BoxFit.cover,
                      height: 50.h,
                      width: 50.w),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: Text(AppStrings.myPagListEmpty.tr(),
                        textAlign: TextAlign.center,
                        style: mediumTextStyle(
                            fontSize: 15.sp, color: AppColor.white)),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomButton(
                    onPressed: () {
                      print("|||");
                      AppRouter.offNamed(context, RouteConstants.main);
                      context.read<MainCubit>().changeBottomNavBar(2);
                    },
                    title: AppStrings.chooseProduct.tr(),
                    width: 140.w,
                    height: 30.h,
                    radius: 10.r,
                    color: AppColor.primaryLight,
                    textStyle: mediumTextStyle(
                        fontSize: 13.0, color: AppColor.primaryAmwaj),
                  )
                ],
              ),
            );
          } else if (state is SuccessGetCartState) {
            return Stack(
              children: [
                ListView(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    //TODO: COUPON CODE & GIFT
                    CustomCouponCodeItem(),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 440.h,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, i) {
                            return CustomPadding.symmetric(
                                vertical: 3.h,
                                horizontal: 1.0,

                                // TODO : - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

                                child: PagItem(
                                  productKey: state.cartModel.cartDataModel!
                                      .cartListProduct![i].key,
                                  title: state.cartModel.cartDataModel!
                                      .cartListProduct![i].name
                                      .toString(),
                                  image: state.cartModel.cartDataModel!
                                      .cartListProduct![i].thumb
                                      .toString(),
                                  price: state.cartModel.cartDataModel!
                                      .cartListProduct![i].price
                                      .toString(),
                                  quantity: state.cartModel.cartDataModel!
                                      .cartListProduct![i].quantity
                                      .toString(),
                                  taxAmount:state.cartModel.cartDataModel!
                                      .cartListProduct![i].taxAmountFormated
                                      .toString() ,
                                  totalRaw:state.cartModel.cartDataModel!
                                      .cartListProduct![i].totalRaw,
                                ));
                          },
                          separatorBuilder: (context, i) {
                            return Divider(color: AppColor.primaryLight);
                          },
                          itemCount: state.cartModel.cartDataModel!
                              .cartListProduct!.length),
                    ),
                    //TODO: CHECK OUT BUTTON
                    InkWell(
                      onTap: () {
                        print("--------------------$email");
                        if (email == null) {
                          AppRouter.to(context, RouteConstants.login);
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => BlocProvider(
                                    create: (context) => OrderCubit(
                                        confirmOrderRepository:
                                            instance<ConfirmOrderRepository>()),
                                    child: CustomAlertDialog(
                                        image: "shopping-basket-Filled.svg",
                                        title: AppStrings.confirm.tr(),
                                        widget: CustomCheckOutButton(
                                          totalPrice: state
                                            .cartModel.cartDataModel!.total
                                            .toString().substring(1) ,
                                          price: state
                                              .cartModel.cartDataModel!.total
                                              .toString()
                                              .replaceAll("item(s) - ", "").substring(1),
                                        )),
                                  ));
                        }
                      },
                      child: Center(
                        child: Container(
                          height: 40.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: AppColor.primaryLight,
                          ),
                          child: Center(
                            child: Text(
                              AppStrings.goToCheckOut.tr(),
                              style: mediumTextStyle(
                                  fontSize: 15.sp, color: AppColor.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (state is LoadingCartState)
                  const Center(
                    child: CustomProductShimmer(),
                  )
              ],
            );
          } else if (state is ErrorCartState) {
            print("eeee eee ${state.error.toString()}");
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              customAwesomeDialog(
                  context, state.error.toString(), DialogType.error);
            });
          }
          return const CustomProductShimmer();
        },
      ),
    );
  }
}
