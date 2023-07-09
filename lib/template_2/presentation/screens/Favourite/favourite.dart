import 'package:resort_store/business_logic/main_template/main_template_cubit.dart';
import 'package:resort_store/core/constants/route_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/template_2/presentation/screens/Favourite/widget/favourite_item.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import '../../../../business_logic/wishlist/cubit.dart';
import '../../../../business_logic/wishlist/state.dart';
import '../../../../core/helpers/textStyle_helper.dart';
import '../../../../data/repository/wishlist/wishlist.dart';
import '../../../../di/di.dart';
import '../../../../presentation/resources/color_manger.dart';
import '../../../../presentation/resources/textStyle_manger.dart';
import '../../../../presentation/screens/favourite/widget/fav_item.dart';
import '../../../../presentation/widgets/custom_button.dart';
import '../../../../presentation/widgets/custom_padding.dart';
import '../../../../presentation/widgets/dialog/custom_awesome_dialog.dart';
import '../../../../presentation/widgets/shimmer/shimmer_products/custom_product_shimmer.dart';

class FavouriteTemplateScreen extends StatelessWidget {
  FavouriteTemplateScreen({Key? key}) : super(key: key);

  int count = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white1,
        appBar: AppBar(
          elevation: 8.0,
          backgroundColor: AppColor.white,

          title: Text(AppStrings.favourite.tr(),
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
        body: BlocProvider<WishListCubit>(
          create: (context) =>
              WishListCubit(wishListRepository: instance<WishListRepository>())
                ..getWishListCubit(),
          child: BlocBuilder<WishListCubit, WishListStates>(
            builder: (context, state) {
              if (state is SuccessWishListState) {
                if (state.wishListModel.data!.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/fav-empty.svg",
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
                          width: 280.w,
                          child: Text(AppStrings.favouriteListEmpty.tr(),
                              textAlign: TextAlign.center,
                              style: mediumTextStyle(
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
                          // context.read<MainTemplateCubit>().changeBottomNavigator(
                          //     context.read<MainTemplateCubit>().selectedItem
                          // );
                        },
                        child: Container(
                          height: 35.h,
                          width: 180.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: AppColor.primaryAmwaj,
                          ),
                          child: Center(
                            child: Text(AppStrings.chooseProduct.tr(),
                                style: TextStyle(
                                    color: AppColor.white, fontSize: 15.sp)),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox(
                    height: 650.h,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: 3.0.sp,
                              left: 8.0.sp,
                              right: 8.0.sp,
                              top: 3.0.sp,
                            ),
                            child: FavouriteItem(
                              productId: state
                                  .wishListModel.data![index].productId
                                  .toString(),
                              name: state.wishListModel.data![index].name,
                              image: state.wishListModel.data![index].thumb,
                              price: state.wishListModel.data![index].price,
                              onClick: () {
                                print("****************");
                                context
                                    .read<WishListCubit>()
                                    .deleteWishListCubit(state
                                        .wishListModel.data![index].productId
                                        .toString());
                              },
                            ),
                          );
                        },
                        itemCount: state.wishListModel.data!.length),
                  );
                }
              } else if (state is LoadingWishListState) {
                const CustomProductShimmer();
              } else if (state is SuccessWishListDeleteState) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  customAwesomeDialog(context,
                      AppStrings.deleteSuccessfully.tr(), DialogType.success);
                });
                context.read<WishListCubit>().getWishListCubit();
              } else if (state is ErrorWishListState) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  customAwesomeDialog(
                      context, state.error.toString(), DialogType.error);
                });
              }
              return const CustomProductShimmer();
            },
          ),
        ));
  }
}
