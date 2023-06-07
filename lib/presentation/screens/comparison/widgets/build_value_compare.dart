import 'package:resort_store/business_logic/cart/cubit.dart';
import 'package:resort_store/business_logic/cart/state.dart';
import 'package:resort_store/business_logic/change_theme/cubit.dart';
import 'package:resort_store/business_logic/product/cubit.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/core/helpers/textStyle_helper.dart';
import 'package:resort_store/data/repository/cart/cart.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/widgets/custom_button.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../data/model/product/product.dart';
import '../../../widgets/dialog/custom_awesome_dialog.dart';

class BuildValueCompare extends StatelessWidget {
  String? image, name,price,tax;
  int? rating, productId;

  QuantityOffers? quantityOffers;

  BuildValueCompare({
    required this.image,
    required this.name,
    required this.rating,
    required this.productId,
    required this.price,
    required this.tax,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPadding.symmetric(
      vertical: 3.0,
      child: Container(
        width: 150.w,
        height: 150.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: AppColor.white),
        child: Stack(
          children: [
            CustomPadding.symmetric(
              vertical: 8.h,
              horizontal: 12.w,
              child: InkWell(
                onTap: () {
                  print("--------------------------------");
                  var comparedItems =
                      SharedHelper.sharedPreferences.getString("ComparedItems");
                  comparedItems = (comparedItems ?? "")
                      .replaceAll(productId.toString() + ",", ",");
                  SharedHelper.sharedPreferences.setString("ComparedItems", comparedItems);
                  context.read<ProductCubit>().getCompareProductCubit();
                },
                child: Container(
                    height: 20.h,
                    width: 20.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        color: context.read<ThemeDataCubit>().recolor),
                    child:
                        Icon(Icons.close, color: AppColor.white, size: 15.sp)),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //TODO: IMAGE
                Image.network(
                  image!,
                  height: 80.h,
                  width: 80.w,
                ),
                //TODO: Name
                Container(
                  height: 35.h,
                  width: 100.w,
                  child: Text(name!,
                      style: textStyleCustom(
                        fontSize: 10.sp,
                        fontColor: Colors.black,
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                //TODO: Button
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
                          textStyle: textStyleCustom(
                            fontSize: 10.sp,
                            fontColor: AppColor.white
                          ),
                          height: 30.h,
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
                //TODO: Price
                SizedBox(
                  height: 14.h,
                ),
                Container(
                  height: 30.h,
                  width: 100.w,
                  child: Center(
                    child: Text("${price.toString()}",
                        style: textStyleCustom(
                          fontSize: 10.sp,
                          fontColor: AppColor.primaryAmwaj,
                        )),
                  ),
                ),
                //TODO: Tax
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  height: 30.h,
                  width: 100.w,
                  child: Center(
                    child: Text(tax.toString(),
                        style: textStyleCustom(
                          fontSize: 10.sp,
                          fontColor: AppColor.primaryAmwaj,
                        )),
                  ),
                ),
                //TODO: Quantity Offer
                SizedBox(
                  height: 15.h,
                ),
                tax == null
                    ? SizedBox(
                        height: 30.h,
                        width: 100.w,
                      )
                    : Container(
                        width: 100.w,
                        height: 30.h,
                        child: Icon(
                          Icons.check_circle,
                          color: context.read<ThemeDataCubit>().recolor,
                        ),
                      ),
                //TODO:  Offer
                SizedBox(
                  height: 15.h,
                ),
                tax == null
                    ? SizedBox(
                        height: 30.h,
                        width: 100.w,
                      )
                    : Container(
                        width: 100.w,
                        height: 30.h,
                        child: Icon(
                          Icons.check_circle,
                          color: context.read<ThemeDataCubit>().recolor,
                        ),
                      ),
                //TODO:  Review
                SizedBox(
                  height: 15.h,
                ),
                Center(
                  child: Container(
                    width: 100.w,
                    height: 30.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        Text(rating.toString())
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
