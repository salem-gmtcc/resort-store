import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'business_logic/change_theme/cubit.dart';
import 'business_logic/currencies/currencies_cubit.dart';
import 'core/helpers/app_function.dart';
import 'core/helpers/shared_prefrencess.dart';
import 'data/repository/currencies/currencies.dart';
import 'di/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Injection.init();
  await SharedHelper.init();
  await AppFunction.handleLocationPermission();
  runApp(EasyLocalization(
      supportedLocales: const [Locale("ar", "SA"), Locale("en", "US")],
      path: 'assets/translation',
      saveLocale: true,
      fallbackLocale: const Locale('en', 'US'),
      child: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) =>
                CurrenciesCubit(currenciesRepo: instance<CurrenciesRepo>())
                  ..getCurrenciesCubit()),
        BlocProvider<ThemeDataCubit>(create: (context) => ThemeDataCubit()),
      ], child: MyApp())));
}


