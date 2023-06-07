import 'package:resort_store/business_logic/counter/cubit.dart';
import 'package:resort_store/business_logic/main/state.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/presentation/screens/comparison/comparison.dart';
import 'package:resort_store/presentation/screens/favourite/favourite.dart';
import 'package:resort_store/presentation/screens/home/home.dart';
import 'package:resort_store/presentation/screens/my_pag/my_pag.dart';
import 'package:resort_store/presentation/screens/settings/settings.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(ChangeBottomNavigationBarInitState());

  static MainCubit get(context) => BlocProvider.of(context);

/*  List<String> appBarTitle =[
   AppStrings.comparison.tr(),
    AppStrings.favourite.tr(),
    AppStrings.home.tr(),
    AppStrings.myPag.tr(),
    AppStrings.setting.tr(),
  ];*/

  List<Widget> screens = [
    ComparisonScreen(),
    FavouriteScreen(),
    HomeScreen(),
    MyPagScreen(),
    SettingScreen()
  ];

  int selectedIndex = 2;

  bool isSecure = false;

  void changeBottomNavBar(int index) {
    selectedIndex = index;
    emit(ChangeBottomNavigationBarState());
  }
}
