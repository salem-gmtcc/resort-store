import 'package:resort_store/business_logic/cart/cubit.dart';
import 'package:resort_store/business_logic/change_text_color/change_text_color_cubit.dart';
import 'package:resort_store/business_logic/counter/cubit.dart';
import 'package:resort_store/business_logic/languages/cubit.dart';
import 'package:resort_store/business_logic/main/cubit.dart';
import 'package:resort_store/data/repository/cart/cart.dart';
import 'package:resort_store/data/repository/languages/languages.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/route_manger.dart';
import 'package:resort_store/presentation/resources/theme_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'business_logic/change_theme/cubit.dart';
import 'business_logic/change_theme/state.dart';
import 'core/helpers/saved_theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        // print("------------------------------------------------- ${context.read<ThemeDataCubit>().recolor}");
        // print("------------------------------------------------- ${context.read<ThemeDataCubit>().recolor2}");
        return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ThemeDataCubit()),
              BlocProvider(create: (context) => MainCubit()),
              BlocProvider(
                create: (context) =>
                    CartCubit(cartRepository: instance<CartRepository>()),
              ),
              BlocProvider(
                create: (context) => LanguagesCubit(
                    languagesRepository: instance<LanguagesRepository>())
                  ..getAllLanguagesCubit(),
              ),
              BlocProvider(create: (context) => CounterCubit()),
              BlocProvider(create: (context) => ChangeTextColorCubit()),
            ],
            child: BlocBuilder<ThemeDataCubit, ChangeThemeStates>(
              builder: (context, state) {
                return MaterialApp(
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  debugShowCheckedModeBanner: false,
                  title: 'Al Motakamel Store',
                  // theme: lightTheme(context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj),
                  onGenerateRoute: RouteManger.getRoute,
                );
              },
            ));
      },
    );
  }
}
