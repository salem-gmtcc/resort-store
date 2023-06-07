import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../business_logic/change_theme/cubit.dart';
import '../../business_logic/change_theme/state.dart';
import '../resources/color_manger.dart';


class BackGround extends StatelessWidget {
  final Widget widget;

  BackGround({required this.widget});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeDataCubit, ChangeThemeStates>(
        builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
            AppColor.primaryAmwaj.withOpacity(0.5)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: widget,
      );
    });
  }
}
