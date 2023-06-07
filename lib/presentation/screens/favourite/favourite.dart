import 'package:resort_store/business_logic/wishlist/cubit.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/data/repository/wishlist/wishlist.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/screens/favourite/widget/fav_item.dart';
import 'package:resort_store/presentation/widgets/dialog/custom_awesome_dialog.dart';
import 'package:resort_store/presentation/widgets/custom_loading.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../business_logic/main/cubit.dart';
import '../../../business_logic/wishlist/state.dart';
import '../../../core/constants/route_constant.dart';
import '../../../core/helpers/app_router.dart';
import '../../../core/helpers/textStyle_helper.dart';
import '../../resources/textStyle_manger.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_padding.dart';
import '../../widgets/search/custom_search_item.dart';
import '../../widgets/shimmer/shimmer_products/custom_product_shimmer.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WishListCubit>(
      create: (context) =>
      WishListCubit(wishListRepository: instance<WishListRepository>())
        ..getWishListCubit(),
      child: BlocBuilder<WishListCubit, WishListStates>(
        builder: (context, state) {
          if (state is SuccessWishListState) {
            if (state.wishListModel.data!.isEmpty) {
              return CustomPadding.symmetric(
                horizontal: 5.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/favIcon.png",
                        color: AppColor.white,
                        fit: BoxFit.cover,
                        height: 40.h,
                        width: 40.w),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Text(AppStrings.favouriteListEmpty.tr(),
                          textAlign: TextAlign.center,
                          style: mediumTextStyle(
                              fontSize: 15.sp, color: AppColor.white)),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomButton(
                      onPressed: () {
                        AppRouter.offNamed(context, RouteConstants.main);
                        context.read<MainCubit>().changeBottomNavBar(2);
                      },
                      title: AppStrings.chooseProduct.tr(),
                      width: 140.w,
                      height: 30.h,
                      radius: 10.r,
                      color: AppColor.primaryLight,
                      textStyle: textStyleCustom(
                        fontSize: 13.sp,
                        fontColor:AppColor.primaryAmwaj,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    //TODO : Search Container
                    // CustomSearchItem(),
                    //TODO:  Favourite Item
                    SizedBox(
                      height: 650.h,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return FavItemWidget(
                              name: state.wishListModel.data![index].name,
                              image: state.wishListModel.data![index].thumb,
                              onClick: () {
                                context
                                    .read<WishListCubit>()
                                    .deleteWishListCubit(state
                                    .wishListModel.data![index].productId
                                    .toString());
                              },
                            );
                          },
                          separatorBuilder: (context, i) {
                              return Divider(
                              color: AppColor.primaryLight,
                              height: 0.5.h,
                              endIndent: 5.0,
                            );
                          },
                          itemCount: state.wishListModel.data!.length),
                    )
                  ],
                ),
              );
            }
          } else if (state is LoadingWishListState) {
            const CustomProductShimmer();
          } else if (state is SuccessWishListDeleteState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              customAwesomeDialog(context, AppStrings.deleteSuccessfully.tr(),
                  DialogType.success);
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
    );
  }
}
