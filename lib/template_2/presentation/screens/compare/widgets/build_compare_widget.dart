import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/data/model/product/product.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../business_logic/cart/cubit.dart';
import '../../../../../business_logic/cart/state.dart';
import '../../../../../business_logic/product/cubit.dart';
import '../../../../../core/helpers/shared_prefrencess.dart';
import '../../../../../core/helpers/textStyle_helper.dart';
import '../../../../../data/repository/cart/cart.dart';
import '../../../../../di/di.dart';
import '../../../../../presentation/widgets/custom_button.dart';
import '../../../../../presentation/widgets/dialog/custom_awesome_dialog.dart';

class BuildCompareWidget extends StatelessWidget {
  List<ProductDataModel>? products;

  BuildCompareWidget({required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Table(
        defaultColumnWidth: FixedColumnWidth(50.0.sp),
        border: TableBorder.all(color: AppColor.lightBlack2),
        textBaseline: TextBaseline.ideographic,
        children: [
          TableRow(
              decoration: BoxDecoration(
                color: AppColor.grey,
              ),
              children: [
                TableCell(
                    child: Center(
                  child: Text("#",
                      style: mediumTextStyle(
                          fontSize: 10.sp, color: AppColor.white)),
                )),
                TableCell(
                    child: Center(
                  child: Text(AppStrings.productImage.tr(),
                      style: mediumTextStyle(
                          fontSize: 10.sp, color: AppColor.white)),
                )),
                TableCell(
                    child: Center(
                  child: Text(AppStrings.name.tr(),
                      style: mediumTextStyle(
                          fontSize: 10.sp, color: AppColor.white)),
                )),
                TableCell(
                    child: Center(
                  child: Text(AppStrings.price.tr(),
                      style: mediumTextStyle(
                          fontSize: 10.sp, color: AppColor.white)),
                )),
                TableCell(
                    child: Center(
                  child: Text(AppStrings.priceWithTax.tr(),
                      style: mediumTextStyle(
                          fontSize: 10.sp, color: AppColor.white)),
                )),
                TableCell(
                    child: Center(
                  child: Text(AppStrings.review.tr(),
                      style: mediumTextStyle(
                          fontSize: 10.sp, color: AppColor.white)),
                )),
                TableCell(
                    child: Center(
                  child: Text("",
                      style: mediumTextStyle(
                          fontSize: 10.sp, color: AppColor.white)),
                )),
              ]),
          ...List.generate(
              products!.length,
              (index) => TableRow(children: [
                    TableCell(
                        child: Center(
                            child: Column(
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Text((index + 1).toString()),
                        SizedBox(
                          height: 5.h,
                        ),
                        InkWell(
                          onTap: () {
                            print("--------------------------------");
                            var comparedItems = SharedHelper.sharedPreferences
                                .getString("ComparedItems");
                            comparedItems = (comparedItems ?? "").replaceAll(
                                products![index].productId.toString() + ",",
                                ",");
                            SharedHelper.sharedPreferences
                                .setString("ComparedItems", comparedItems);
                            context
                                .read<ProductCubit>()
                                .getCompareProductCubit();
                          },
                          child: Container(
                            height: 15.h,
                            width: 15.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2.r),
                                color: AppColor.primaryAmwaj),
                            child: Icon(Icons.close,
                                color: AppColor.white, size: 13.sp),
                          ),
                        ),
                      ],
                    ))),
                    TableCell(
                        child:
                            Image.network(products![index].thumb.toString())),
                    TableCell(
                        child: Center(
                            child: Text(products![index].name.toString()))),
                    TableCell(
                        child: Center(
                            child: Text(products![index].priceExcludingTax.toString()))),
                    TableCell(child: Center(child: Text(products![index].priceFormat.toString()))),
                    TableCell(
                        child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 5.w,
                          ),
                          SvgPicture.asset("assets/icons/star-Filled.svg",
                              height: 10.h, width: 10.w),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(products![index].rating.toString(),
                              style: mediumTextStyle(
                                  fontSize: 10.sp, color: AppColor.black)),
                          SizedBox(
                            width: 5.w,
                          ),
                        ],
                      ),
                    )),
                    TableCell(
                      child: BlocProvider(
                        create: (context) => CartCubit(
                            cartRepository: instance<CartRepository>()),
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
                              Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: 10.h,),
                                    CustomButton(
                                      onPressed: () {
                                        context.read<CartCubit>().postCartCubit({
                                          "product_id": products![index].productId,
                                          "quantity": "1"
                                        });
                                      },
                                      textStyle: textStyleCustom(
                                          fontSize: 15.sp, fontColor: AppColor.white),
                                      height: 25.h,
                                      width: 25.w,
                                      title: "+",
                                      color: AppColor.primaryAmwaj,
                                      radius: 3.r,
                                    ),
                                  ],
                                ),
                              ),
                              if (state is LoadingCartState)
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ]))
        ],
      ),
    );
  }
}
