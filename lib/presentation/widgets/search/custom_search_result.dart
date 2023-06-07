import 'package:resort_store/business_logic/product/cubit.dart';
import 'package:resort_store/business_logic/product/state.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/route_constant.dart';

class CustomSearchResult extends StatelessWidget {
  const CustomSearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductStates>(
      builder: (context, state) {
        if (state is SuccessProductSearchState) {
          return Container(
            height: 180.h,
            width: 340.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(5.0.r),
                bottomLeft: Radius.circular(5.0.r)
              ),
              color: AppColor.white1
            ),
            child: Scrollbar(
              thickness: 6.0,
              child: state.products.isEmpty ? Center(
                child: Text(AppStrings.noProductFound.tr(),style: boldTextStyle(fontSize: 18.0, color: AppColor.primaryAmwaj)),
              ) : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: (){
                        AppRouter.to(context, RouteConstants.detailsTemplateScreen,arguments:state.products[index].id);
                      },
                      title: Text(state.products[index].name.toString()),
                      leading: Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          color: AppColor.white
                        ),
                        child: CircleAvatar(
                          child: Image.network(state.products[index].image.toString()),
                        ),
                      ),
                    );
                  }),
            ),
          );
        } else if (state is ProductErrorState) {
          showToast(text: state.e.toString(), color: ToastColors.ERROR);
        } else if (state is ProductLoadingState) {
           Center(
            child: CircularProgressIndicator(color: AppColor.primaryAmwaj),
          );
        }
        return const Center(
          child: SizedBox.shrink(),
        );
      },
    );
  }
}
