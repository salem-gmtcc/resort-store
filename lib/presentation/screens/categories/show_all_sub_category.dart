import 'package:resort_store/business_logic/cart/state.dart';
import 'package:resort_store/business_logic/categories/cubit.dart';
import 'package:resort_store/business_logic/main/cubit.dart';
import 'package:resort_store/business_logic/main/state.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/data/model/category/category.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/screens/categories/widgets/custom_sub_categories.dart';
import 'package:resort_store/presentation/widgets/background.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/categories/state.dart';
import '../../../business_logic/change_theme/cubit.dart';
import '../../../core/constants/route_constant.dart';
import '../../../core/helpers/app_router.dart';
import '../../resources/color_manger.dart';
import '../../widgets/shimmer/shimmer_categories/custom_categories_branch_shimmer.dart';
import '../../widgets/shimmer/shimmer_products/custom_product_branch_shimmer.dart';

class ShowAllSubCategories extends StatefulWidget {
  @override
  State<ShowAllSubCategories> createState() => _ShowAllSubCategoriesState();
}

class _ShowAllSubCategoriesState extends State<ShowAllSubCategories> {
  final ScrollController _scrollController = ScrollController();
  List<Categories> list = [];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.maxScrollExtent ==
  //         _scrollController.position.pixels) {
  //       print(
  //           "************************************************************************** arrived here !");
  //       BlocProvider.of<CategoriesCubit>(context).isLoading = false;
  //       print("-------------------------------1");
  //       BlocProvider.of<CategoriesCubit>(context).page++;
  //       print("-------------------------------1");
  //       BlocProvider.of<CategoriesCubit>(context).getAllCategories();
  //       print("-------------------------------1");
  //     }
  //   });
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.read<ThemeDataCubit>().recolor,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            AppRouter.back(context);
          },
          child: Icon(
            size: 17.0,
            Icons.arrow_back,
            color: AppColor.white,
          ),
        ),
        title: Text(AppStrings.categories.tr(),
            style: mediumTextStyle(fontSize: 15.0, color: AppColor.white)),
      ),
      body: BackGround(
        widget: BlocBuilder<CategoriesCubit, CategoriesStates>(
          builder: (context, state) {
            if (state is AllCategoriesSuccessState) {
              list = state.categories;
              return GridView.builder(
                  controller: _scrollController,
                  itemCount: list.length,
                  physics: const BouncingScrollPhysics(),
                  padding:  EdgeInsets.only(right: 3.w, left: 3.w, top: 3.h),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                  ),
                  itemBuilder: (context, i) {
                    print("i   $i");
                    return CustomSubCategories(
                      id: list[i].id.toString(),
                      name: list[i].name,
                      image: list[i].image,
                    );
                  });
            } else if (state is CategoriesLoadingDataState) {
              const Center(child: CircularProgressIndicator());
            } else if (state is CategoriesErrorState) {
              print(state.e.toString());
              showToast(text: state.e.toString(), color: ToastColors.ERROR);
            }
            return const CustomCategoriesBranchShimmer();
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5.0,
        color: AppColor.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Container(height: 50.h, child: const SizedBox.shrink()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppRouter.offNamed(context, RouteConstants.main);
          context.read<MainCubit>().changeBottomNavBar(2);
        },
        child: Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
                border: Border.all(color: AppColor.white, width: 0.5),
                color: context.read<ThemeDataCubit>().recolor ??
                    AppColor.primaryAmwaj,
                borderRadius: BorderRadius.circular(50.r)),
            child: Center(
              child: Icon(Icons.home, color: AppColor.white, size: 35.sp),
            )),
      ),
    );
  }
}
