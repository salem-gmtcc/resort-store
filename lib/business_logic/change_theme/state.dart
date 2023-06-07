import 'package:flutter/material.dart';

abstract class ChangeThemeStates {}

class InitChangeThemeState extends ChangeThemeStates {}

class ChangeThemeState extends ChangeThemeStates {
  final Color color;

  ChangeThemeState({required this.color});
}

class ChangeSecondColorState extends ChangeThemeStates {
  final Color color;

  ChangeSecondColorState({required this.color});
}
