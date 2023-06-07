import 'package:resort_store/business_logic/session/cubit.dart';
import 'package:resort_store/business_logic/session/state.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/data/repository/session/session.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import '../../../business_logic/change_theme/cubit.dart';
import '../../../core/constants/route_constant.dart';
import '../../../core/helpers/app_function.dart';
import '../../../core/helpers/app_router.dart';
import '../../../core/helpers/shared_prefrencess.dart';
import '../../resources/color_manger.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animatedContainer = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat(reverse: true);

  late final Animation<double> _animation =
      CurvedAnimation(parent: _animatedContainer, curve: Curves.fastOutSlowIn);

  String? email = SharedHelper.sharedPreferences.getString(AppStrings.email);

  int? template = SharedHelper.sharedPreferences.getInt(AppStrings.template);

  String route = "";

  //TODO: Current Location

  Position? currentPosition;

  Future<void> _getCurrentPosition() async {
    final hasPermission = await AppFunction.handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      print("in splash Screen lat value IS:  : ${position.latitude}");
      print("in splash Screen lon value IS:  : ${position.longitude}");
      SharedHelper.sharedPreferences
          .setDouble(AppStrings.lat, position.latitude);
      SharedHelper.sharedPreferences
          .setDouble(AppStrings.lon, position.longitude);
      setState(() {
        currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  checkLogin() {
    if (email == null) {
      route = RouteConstants.login;
    } else {
      //TODO : Check template
      if(template == 1){
        route = RouteConstants.main;
      }else {
        route = RouteConstants.mainNewTemplate;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkLogin();
    _getCurrentPosition();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animatedContainer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("*********** enter -----------");
    return Scaffold(
        body: BlocProvider(
      create: (context) =>
          SessionCubit(sessionRepository: instance<SessionRepository>())
            ..getSession(),
      child: BlocListener<SessionCubit, SessionState>(
        listener: (context, state) {
          if (state is SessionSuccessState) {
            print(
                "session id after shared ${SharedHelper.sharedPreferences.get(AppStrings.sessionId)}");
            //   print("SUCCESS SPLASH : **************");
            //   print("TYPE : ${SharedHelper.sharedPreferences.getInt(AppStrings.loginType)}");
            // // TODO: Check Login and Login Guest
            //SharedHelper.sharedPreferences.setInt(AppStrings.type,0);
            if (SharedHelper.sharedPreferences.getInt(AppStrings.loginType) ==
                1) {
              print("///////// type = 1");
              AppRouter.offNamed(context, route);
            } else {
              print("///////// type = 0");
              SharedHelper.sharedPreferences.setString(AppStrings.sessionId, state.sessionModel.data!.session!);
              AppRouter.offNamed(context, route);
            }
          } else if (state is SessionErrorState) {
            print("************- Error : ${state.e.toString()}");
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
              AppColor.primaryAmwaj.withOpacity(0.5)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Center(
            child: ScaleTransition(
              scale: _animation,
              child: SizedBox(
                  width: 300.w,
                  child: Image.asset("assets/images/splash.png")),
            ),
          ),
        ),
      ),
    ));
  }
}
