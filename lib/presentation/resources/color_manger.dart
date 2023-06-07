import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  const AppColor._();

  static Color colorPrimaryDark = hexToColor('#47a278');
  static Color colorAccent = hexToColor('#81de5b');
  static Color colorBlue = hexToColor('#42A5F5');
  static Color colorGray = hexToColor('#9A9A9A');

  static Color colorBluePrimary = hexToColor('#0277bd');
  static Color colorBlueDark = hexToColor('#004c8c');
  static Color colorBlueLight = hexToColor('#58a5f0');

  static Color colorRedPrimary = hexToColor('#b71c1c');
  static Color colorRedDark = hexToColor('#7f0000');
  static Color colorRedLight = hexToColor('#f05545');

  static Color colorGreenPrimary = hexToColor('#1b5e20');
  static Color colorGreenDark = hexToColor('#003300');
  static Color coloGreenLight = hexToColor('#4c8c4a');

  static Color colorAmberPrimary = hexToColor('#c67100');
  static Color colorAmberDark = hexToColor('#ffd149');
  static Color colorAmberLight = hexToColor('#ffd149');

  static Color colorBlackPrimary = hexToColor('#424242');
  static Color colorBlackDark = hexToColor('#1b1b1b');
  static Color colorBlackLight = hexToColor('#6d6d6d');

  static Color colorGreyPrimary = hexToColor('#9e9e9e');
  static Color colorGreyDark = hexToColor('#707070');
  static Color colorGreyLight = hexToColor('#cfcfcf');

  static Color colorWhitePrimary = hexToColor('#eceff1');
  static Color colorWhiteDark = hexToColor('#babdbe');
  static Color colorWhiteLight = hexToColor('#ffffff');

  static Color colorTransparent = hexToColor('#00FFFFFF');

  static Color colorTextFormFeild = hexToColor('#ffffff');
  static Color colorButton1 = hexToColor('#42D70D');

  static Color colorButton2 = hexToColor('#FFFFFF');

  static Color canvasColor = hexToColor('#EDEDED');
  static Color primaryAmwaj = hexToColor('#0E2F56');
  // static Color primarySparePart = hexToColor('#a41e1f');
  static Color primaryLight = hexToColor('#BEBCB5');
  static Color backgroundColor = hexToColor('#424242');
  static Color secondary = hexToColor('#29B6F6');
  static Color blue = hexToColor('#0055FF');
  static Color black = hexToColor('#222B45');
  static Color selectedColor = black.withOpacity(0.05);
  static Color border = hexToColor('#A3A9AD');
  static Color border1 = hexToColor('#D0D3D5');
  static Color hintColor = hexToColor('#81878A');
  static Color grey = hexToColor('#7A7F8F');
  static Color appBarColor = hexToColor('#EEEDE7');
  static Color red = hexToColor('#d6293c');
  static Color white = hexToColor('#FFFFFF');
  static Color white1 = hexToColor('#EEEEEE');
  static Color lightWhite = white.withOpacity(0.15);
  static Color lightWhite1 = white.withOpacity(0.5);
  static Color lightWhite2 = white.withOpacity(0.8);
  static Color toastColor = hexToColor('#8c916e');
  static Color yellow = hexToColor('#eed202');
  static Color warningColor = hexToColor('#eed202');
  static Color loadingBackground = hexToColor('#080004').withOpacity(0.4);
  static Color orange = Colors.orange;
  static Color green = Colors.green;
  static Color brown = Colors.brown;
  static Color transparent = Colors.transparent;
  static Color lightBlack = black.withOpacity(0.08);
  static Color lightBlack1 = black.withOpacity(0.2);
  static Color lightBlack2 = black.withOpacity(0.3);
  static Color lightBlack3 = black.withOpacity(0.45);
  static Color lightBlack4 = black.withOpacity(0.7);
  static Color lightBlack5 = black.withOpacity(0.85);
  static Color qrPrimaryColor = const Color(0xff128760);
  static Color qrSecondaryColor = const Color(0xff1a5441);

  //TODO : New Template Color
  static Color spareTKTemplate = hexToColor("#670707");


  //TODO: handle hex color
  static Color hexToColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
