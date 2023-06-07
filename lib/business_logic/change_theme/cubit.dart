import 'dart:ui';
import 'package:resort_store/business_logic/change_theme/state.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:bloc/bloc.dart';

class ThemeDataCubit extends Cubit<ChangeThemeStates> {

  ThemeDataCubit() : super(InitChangeThemeState());
  Color? recolor = Color(SharedHelper.sharedPreferences.getInt(AppStrings.saveTheme) ?? AppColor.primaryAmwaj.value);
  Color? recolor2 = Color(SharedHelper.sharedPreferences.getInt(AppStrings.saveSecondColor) ?? AppColor.primaryAmwaj.value);

  changeThemeDataCubit(Color color) {
    recolor = color;

    print("----------------------- 1  $color   ---------------------------------");

    print("----------------------- 1  $recolor  --------------------------------");

    emit(ChangeThemeState(color: color));
  }

  changeSecondColor(Color color) {

    recolor2 = color;

    print("----------------------- 2   $color     --------------------------------");

    print("----------------------- 2  $recolor2   --------------------------------");

    emit(ChangeSecondColorState(color: color));

  }
}
