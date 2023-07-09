import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/template_2/presentation/screens/cart/widget/cart_item.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../business_logic/cart/cubit.dart';
import '../../../../business_logic/cart/state.dart';
import '../../../../business_logic/change_theme/cubit.dart';
import '../../../../business_logic/coupon/coupon_cubit.dart';
import '../../../../business_logic/order/cubit.dart';
import '../../../../core/constants/route_constant.dart';
import '../../../../core/helpers/app_router.dart';
import '../../../../core/helpers/shared_prefrencess.dart';
import '../../../../data/repository/cart/cart.dart';
import '../../../../data/repository/order/order.dart';
import '../../../../di/di.dart';
import '../../../../presentation/screens/my_pag/widget/custom_checkout_button.dart';
import '../../../../presentation/widgets/custom_button.dart';
import '../../../../presentation/widgets/custom_toast.dart';
import '../../../../presentation/widgets/dialog/custom_alert_dailog.dart';
import '../../../../presentation/widgets/dialog/custom_awesome_dialog.dart';
import '../../../../presentation/widgets/shimmer/shimmer_products/custom_product_shimmer.dart';


class CartTemplateScreen extends StatelessWidget {
  CartTemplateScreen({Key? key}) : super(key: key);
  final TextEditingController _coupon = TextEditingController();
  String? email = SharedHelper.sharedPreferences.getString(AppStrings.email);

  int count = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white1,
      appBar: AppBar(
        elevation: 8.0,
        backgroundColor: AppColor.white,
        leading: InkWell(
          onTap: (){
            // AppRouter.back(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColor.black,
            size: 20.0.sp,
          ),
        ),
        title: Text(AppStrings.myPag.tr(),
            style: mediumTextStyle(fontSize: 15.sp, color: AppColor.black)),
        centerTitle: true,
        actions: [
          Padding(
              padding: EdgeInsets.only(left: 8.sp, right: 8.sp),
              child: SvgPicture.asset(
                "assets/icons/bell-Bold.svg",
                height: 15.h,
                color: AppColor.black,
              ))
        ],
      ),
      body:
      BlocProvider(
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
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/EmptyState-1.svg",
                        height: 120.h,
                        width: 120.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Center(
                        child: Container(
                          height: 70.h,
                          width: 300.w,
                          child: Text(AppStrings.myPagListEmpty.tr(),
                              textAlign: TextAlign.center
                              , style: mediumTextStyle(
                                  fontSize: 17.sp,
                                  color: AppColor.grey.withOpacity(0.7))),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: (){
                          AppRouter.offNamed(context, RouteConstants.mainNewTemplate);
                        },
                        child: Container(
                          height: 35.h,
                          width: 180.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: AppColor.spareTKTemplate,
                          ),
                          child: Center(
                            child: Text(AppStrings.chooseProduct.tr(),
                                style: TextStyle(
                                    color: AppColor.white, fontSize: 15.sp)),
                          ),
                        ),
                      ),
                    ],
                  ));
            }

            else if(state is SuccessUpdateItemCart){
              context.read<CartCubit>().getCartCubit();
            }

            else if (state is SuccessGetCartState) {
              return Center(
                child:  SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        height: 450.h,
                        width: 350.w,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: state.cartModel.cartDataModel!.cartListProduct!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 3.h, left: 3.w, top: 3.h, right: 3.w),
                                  child: NewTemplateCartItem(
                                    productKey: state.cartModel.cartDataModel!
                                        .cartListProduct![index].key,
                                    title: state.cartModel.cartDataModel!
                                        .cartListProduct![index].name
                                        .toString(),
                                    image: state.cartModel.cartDataModel!
                                        .cartListProduct![index].thumb
                                        .toString(),
                                    price: state.cartModel.cartDataModel!
                                        .cartListProduct![index].price
                                        .toString(),
                                    quantity: state.cartModel.cartDataModel!
                                        .cartListProduct![index].quantity
                                        .toString(),
                                    taxAmount:state.cartModel.cartDataModel!
                                        .cartListProduct![index].taxAmountFormated
                                        .toString() ,
                                    totalRaw:state.cartModel.cartDataModel!
                                        .cartListProduct![index].totalRaw,
                                  ));
                            }),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 70.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //TODO : Check Out Button
                            InkWell(
                              onTap:(){
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
                                            image: "shopping-basket-Bold.svg",
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
                              child: Container(
                                height: 40.h,
                                width: 150.w,
                                decoration: BoxDecoration(
                                    color: AppColor.primaryAmwaj,
                                    borderRadius: BorderRadius.circular(20.r)),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: 5.sp
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/shopping-basket-Bold.svg",
                                        height: 20.h,
                                        width: 20.w,
                                        color: AppColor.white,
                                      ),
                                      Text(
                                        AppStrings.goToCheckOut.tr(),
                                        style: mediumTextStyle(
                                            height: 0.0.h,
                                            fontSize: 10.sp, color: AppColor.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //TODO: ADD COUPON
                            InkWell(
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (context) => BlocProvider(
                                      create: (context) => CouponCubit(
                                          cartRepository: instance<CartRepository>()),
                                      child: BlocBuilder<CouponCubit,   CouponState>(
                                        builder: (context, state) {
                                          if (state is CouponSuccessState) {
                                            showToast(
                                                text: "Add Coupon Code Successfully",
                                                color: ToastColors.SUCCESS)
                                                .then((value) {
                                              AppRouter.back(context);
                                            });
                                          } else if (state is CouponErrorState) {
                                            print("*********************-------________----- ${state.error.toString()}");
                                            showToast(
                                                text: state.error.toString(),
                                                color: ToastColors.ERROR);
                                          }
                                          return SizedBox(
                                            height: 100.h,
                                            width: 200.w,
                                            child:   CustomAlertDialog(
                                              image: "coupon-Bold.svg",
                                              title: AppStrings.useCouponCode.tr(),
                                              widget:  Column(
                                                children: [
                                                  SizedBox(
                                                    child: TextFormField(
                                                      decoration: InputDecoration(
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                AppColor.spareTKTemplate)),
                                                        border: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                AppColor.primaryAmwaj)),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                AppColor.primaryAmwaj)),
                                                        disabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color:
                                                                AppColor.primaryAmwaj)),
                                                      ),
                                                      controller: _coupon,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return AppStrings.required.tr();
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    width: 180.w,
                                                    height: 30.h,
                                                  ),
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  CustomButton(
                                                    textStyle: mediumTextStyle(
                                                        fontSize: 10,
                                                        color: AppColor.white),
                                                    color: context
                                                        .read<ThemeDataCubit>()
                                                        .recolor ??
                                                        AppColor.primaryAmwaj,
                                                    radius: 10.r,
                                                    title: AppStrings.send.tr(),
                                                    onPressed: () {
                                                      context
                                                          .read<CouponCubit>()
                                                          .getCoupon(_coupon.text);
                                                    },
                                                    height: 30.h,
                                                    width: 80.w,
                                                  ),
                                                  if(state is CouponLoadingState)
                                                    CircularProgressIndicator(color: AppColor.primaryAmwaj,)
                                                ],
                                              ),),
                                          );
                                        },
                                      ),
                                    ));
                              },
                              child: Container(
                                height: 40.h,
                                width: 150.w,
                                decoration: BoxDecoration(
                                    color: AppColor.primaryAmwaj,
                                    borderRadius: BorderRadius.circular(20.r)),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: 5.sp
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/coupon-Bold.svg",
                                        height: 15.h,
                                        width: 15.w,
                                        color: AppColor.white,
                                      ),
                                      Text(
                                        AppStrings.useCouponCode.tr(),
                                        style: mediumTextStyle(
                                            height: 0.0.h,
                                            fontSize: 10.sp, color: AppColor.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
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
      )
      ,
    );
  }
}
