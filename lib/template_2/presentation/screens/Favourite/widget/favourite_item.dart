import 'package:resort_store/core/constants/strings_app.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../business_logic/cart/cubit.dart';
import '../../../../../business_logic/cart/state.dart';
import '../../../../../business_logic/change_theme/cubit.dart';
import '../../../../../core/helpers/textStyle_helper.dart';
import '../../../../../data/repository/cart/cart.dart';
import '../../../../../di/di.dart';
import '../../../../../presentation/resources/color_manger.dart';
import '../../../../../presentation/resources/textStyle_manger.dart';
import '../../../../../presentation/widgets/custom_button.dart';
import '../../../../../presentation/widgets/dialog/custom_awesome_dialog.dart';


class FavouriteItem extends StatelessWidget {
  String?  productId ,name, image,price;

  Function()? onClick;

  FavouriteItem({required this.name, required this.image, required this.price ,required this.productId ,required this.onClick});



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColor.white,
      ),
      width: 220.w,
      child: Padding(
        padding: EdgeInsets.only(right: 5.sp, left: 5.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //TODO : Image and Name And price
            Row(
              children: [
                //TODO: Image
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.white1,
                      shape: BoxShape.rectangle,
                      border: Border.all(
                          color: AppColor.backgroundColor.withOpacity(0.2)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          opacity: 0.8,
                          image: NetworkImage(
                            image!,
                          )),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    height: 100.h,
                    width: 80.w,
/*                  child: Image.asset("assets/images/img_3.png",
                  height: 60,
                    width: 50.w,
                  )*/
                  ),
                ),
                //TODO: NAME AND PRICE
                Container(
                  height: 95.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        height: 5.h,
                      ),

                      Container(
                        height: 25.h,
                        width: 150.w,
                        child: Text(name!,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 15.sp,
                              color: AppColor.black,)),
                      ),

                      Text("${AppStrings.price.tr()} ${price!}",
                          style: mediumTextStyle(
                            fontSize: 10.sp,
                            color: AppColor.spareTKTemplate,
                          )),

                      SizedBox(
                        height: 5.h,
                      ),

                      BlocProvider(
                        create: (context) =>
                            CartCubit(cartRepository: instance<CartRepository>()),
                        child: BlocBuilder<CartCubit, CartStates>(
                            builder: (context, state) {
                              if (state is SuccessAddCartState) {
                                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                  customAwesomeDialog(
                                      context,
                                      AppStrings.addSuccessfully.tr(),
                                      DialogType.success);
                                });
                              }
                              else if (state is ErrorCartState) {
                                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                  customAwesomeDialog(
                                      context, state.error.toString(), DialogType.error);
                                });
                              }
                              return Stack(
                                children: [
                                  CustomButton(
                                    onPressed: () {
                                      context.read<CartCubit>().postCartCubit({
                                        "product_id": productId.toString(),
                                        "quantity": "1"
                                      });
                                    },
                                    textStyle: mediumTextStyle(
                                        fontSize: 9.sp,
                                        color: AppColor.white
                                    ),
                                    height: 25.h,
                                    width: 80.w,
                                    title: AppStrings.addToCart.tr(),
                                    color: context.read<ThemeDataCubit>().recolor ??
                                        AppColor.primaryAmwaj,
                                    radius: 6.r,
                                  ),
                                  if (state is LoadingCartState)
                                    Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                ],
                              );
                            }),
                      ),

                    ],
                  ),
                ),
              ],
            ),
            //TODO: Price And Tax Price
            Padding(
              padding: EdgeInsets.only(right: 5.sp, left: 5.sp),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  RatingBar.builder(
                    itemSize: 15.0.sp,
                    initialRating: 2.5,
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
                  SizedBox(height: 15.h),
                  IconButton(
                      onPressed: onClick,
                      icon: Icon(
                        Icons.delete_outline,
                        size: 25.sp,
                        color: AppColor.spareTKTemplate,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
