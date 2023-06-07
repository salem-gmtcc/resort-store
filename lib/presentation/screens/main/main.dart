import 'package:resort_store/business_logic/cart/cubit.dart';
import 'package:resort_store/business_logic/cart/state.dart';
import 'package:resort_store/business_logic/counter/cubit.dart';
import 'package:resort_store/business_logic/main/cubit.dart';
import 'package:resort_store/business_logic/main/state.dart';
import 'package:resort_store/data/repository/cart/cart.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/background.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../business_logic/change_theme/cubit.dart';
import '../../../business_logic/counter/state.dart';
import '../../../core/constants/strings_app.dart';
import '../../resources/color_manger.dart';
import '../../widgets/custom_app_bar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  List<String> appBarTitle = [
    AppStrings.comparison.tr(),
    AppStrings.favourite.tr(),
    AppStrings.home.tr(),
    AppStrings.myPag.tr(),
    AppStrings.setting.tr(),
  ];

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainStates>(
      builder: (context, state) {
        var mainCubit = MainCubit.get(context);
        print("${mainCubit.selectedIndex}");
        return Scaffold(
            // backgroundColor: AppColor.primaryAmwaj,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: CustomAppBar(
                iconColor: AppColor.white,
                title: appBarTitle[mainCubit.selectedIndex],
              ),
            ),
            body: BackGround(
              widget: mainCubit.screens[mainCubit.selectedIndex],
            ),
            extendBody: true,
            bottomNavigationBar: CurvedNavigationBar(
              onTap: (index) => mainCubit.changeBottomNavBar(index),
              height: 45.h,
              animationCurve: Curves.easeOut,
              backgroundColor: AppColor.transparent,
              buttonBackgroundColor: context.read<ThemeDataCubit>().recolor ??
                  AppColor.primaryAmwaj,
              color: AppColor.white,
              index: 2,
              items: [
                //     //TODO: Comparison
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.r),
                  ),
                  child: Image.asset(
                    "assets/icons/comparisonIcon.png",
                    width: 35.w,
                    height: 35.h,
                  ),
                ),
                //     //TODO: Fav
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.r),
                  ),
                  child: Image.asset(
                    "assets/icons/favIcon.png",
                    width: 35.w,
                    height: 35.h,
                  ),
                ),
                //     //TODO: HOME
                Container(
                  width: 25.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.r),
                  ),
                  child: Image.asset(
                    "assets/icons/homeIcon.png",
                    width: 35.w,
                    height: 35.h,
                  ),
                ),
                //TODO: My Pag
                BlocBuilder<CounterCubit, CounterStates>(
                    builder: (context, state) {
                  print(
                      "*****************************************************");
                  print("----------------------------- [state]  $state");
                  if (state is ChangeCounterState) {
                    print("------------------------------*/*/* $count");
                    count = state.count;
                  }
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35.r),
                        ),
                        child: Image.asset(
                          "assets/icons/myPagIcon.png",
                          width: 35.w,
                          height: 35.h,
                        ),
                      ),
                      count  <= 0
                          ? const SizedBox.shrink()
                          : Container(
                              height: 15.h,
                              width: 15.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                  color: AppColor.red),
                              child: Center(
                                child: Text(count.toString(),
                                    style: boldTextStyle(
                                        fontSize: 10, color: AppColor.white)),
                              ),
                            )
                    ],
                  );
                }),
                //     //TODO : Settings
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.r),
                  ),
                  child: Image.asset(
                    "assets/icons/settingIcon.png",
                    width: 35.w,
                    height: 35.h,
                  ),
                ),
              ],
            )
            //other param
            );
      },
    );
  }
}
