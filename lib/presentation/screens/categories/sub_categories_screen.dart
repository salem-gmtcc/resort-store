import 'package:resort_store/business_logic/categories/cubit.dart';
import 'package:resort_store/business_logic/categories/state.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/screens/categories/widgets/custom_sub_categories.dart';
import 'package:resort_store/presentation/widgets/background.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/change_theme/cubit.dart';
import '../../../business_logic/main/cubit.dart';
import '../../../core/constants/route_constant.dart';
import '../../../core/helpers/saved_theme.dart';
import '../../../core/helpers/textStyle_helper.dart';
import '../../../data/model/category/category.dart';
import '../../widgets/shimmer/shimmer_categories/custom_categories_branch_shimmer.dart';

class SubCategoryScreen extends StatefulWidget {
  String? id, name;

  SubCategoryScreen({required this.id, required this.name});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen>
    with TickerProviderStateMixin {
  List<SubCategories> subCategories = [];

  int? template = SharedHelper.sharedPreferences.getInt(AppStrings.template);

  @override
  void initState() {
    // TODO: implement initState
    // _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.primaryAmwaj,
      appBar: AppBar(
        backgroundColor:
            context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            AppRouter.back(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColor.white,
            size: 16.sp,
          ),
        ),
        title: Text(widget.name!,
            style: textStyleCustom(
              fontSize: 15.sp,
              fontColor:Colors.white,
            )
        ),
      ),
      body: BackGround(
        widget: BlocBuilder<CategoriesCubit, CategoriesStates>(
          builder: (context, state) {
            if (state is SubCategoriesSuccessState) {
              subCategories = state.categoryModel.data!.subCategories!;
              return GridView.builder(
                  itemCount: subCategories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                  ),
                  itemBuilder: (context, index) {
                    return CustomSubCategories(
                        id: subCategories[index].categoryId.toString(),
                        name: subCategories[index].name,
                        image: subCategories[index].image);
                  });
            } else if (state is CategoriesLoadingState) {
              const CustomCategoriesBranchShimmer();
            } else if (state is CategoriesErrorState) {
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
        backgroundColor:context.read<ThemeDataCubit>().recolor ??
            AppColor.primaryAmwaj,
        onPressed: () {
          if(template == 1){
            AppRouter.offNamed(context, RouteConstants.main);
            context.read<MainCubit>().changeBottomNavBar(2);
          }else {
            AppRouter.offNamed(context, RouteConstants.mainNewTemplate);
          }
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
