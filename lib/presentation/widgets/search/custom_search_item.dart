import 'package:resort_store/business_logic/order/cubit.dart';
import 'package:resort_store/business_logic/product/cubit.dart';
import 'package:resort_store/data/repository/product/product.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/widgets/custom_textFeild.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/strings_app.dart';
import '../../resources/textStyle_manger.dart';
import '../custom_padding.dart';
import 'custom_search_result.dart';

class CustomSearchItem extends StatefulWidget {
  double? height;
  CustomSearchItem([this.height]);

  @override
  State<CustomSearchItem> createState() => _CustomSearchItemState();
}

class _CustomSearchItemState extends State<CustomSearchItem> {
  TextEditingController? _searchText;
  @override
  void initState() {
    // TODO: implement initState
    _searchText = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchText!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 35.h,
                width: 340.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColor.white,
                ),
                child: TextField(
                  cursorWidth: 1,
                  cursorHeight: 25,
                  onSubmitted: (value) {
                    context.read<ProductCubit>().getSearchProductCubit(
                        context.read<ProductCubit>().text!.text);
                    print("value $value");
                  },
                  onChanged: (value) {
                    context.read<ProductCubit>().getSearchProductCubit(
                        context.read<ProductCubit>().text!.text);
                  },
                  controller: context.read<ProductCubit>().text,
                  autocorrect: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintStyle: mediumTextStyle(
                      fontSize: 8.sp,
                      color: AppColor.black,
                    ),
                    hintText: AppStrings.searchForProducts.tr(),
                    isDense: true,
                    suffixIconConstraints: const BoxConstraints(
                      minWidth: 35,
                      minHeight: 35,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColor.spareTKTemplate,
                      size: 20.sp,
                    ),
                    // suffixIcon: CustomPadding.symmetric(
                    //   horizontal: 5.w,
                    //   vertical: 5.h,
                    //   child: Container(
                    //       height: 5.h,
                    //       width: 1.w,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(5.r),
                    //           color: AppColor.primaryAmwaj),
                    //       child: InkWell(
                    //           onTap: () => context
                    //               .read<ProductCubit>()
                    //               .clearSearchTextController(),
                    //           child: Icon(
                    //             Icons.close,
                    //             color: AppColor.white,
                    //             size: 12.sp,
                    //           ))
                    //   ),
                    // )
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomSearchResult(height: widget.height,)
            ],
          ),
        ));
  }
}
