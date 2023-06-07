import 'dart:ui';

import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'change_text_color_state.dart';

class ChangeTextColorCubit extends Cubit<Color> {

  ChangeTextColorCubit() : super(Colors.white);
   Color textColor = Color(SharedHelper.sharedPreferences.getInt(AppStrings.ChangeTextColor) ?? AppColor.white.value);
  changeColor(Color color){
    textColor = color;
    print("**************************** textColor in Cubit $textColor");
    emit(textColor);
  }

}
