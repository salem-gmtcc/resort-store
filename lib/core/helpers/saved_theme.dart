import 'dart:ui';

import 'package:resort_store/core/helpers/shared_prefrencess.dart';

import '../../presentation/resources/color_manger.dart';
import '../constants/strings_app.dart';

class SavedTheme {
  static Color mySavedColor = Color(SharedHelper.sharedPreferences.getInt(AppStrings.saveTheme) ?? AppColor.primaryAmwaj.value);
  static Color mySecondColor = Color(SharedHelper.sharedPreferences.getInt(AppStrings.saveSecondColor) ?? AppColor.primaryAmwaj.value);

}