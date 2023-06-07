import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';



class SharedHelper {
  static  late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}