import 'package:resort_store/business_logic/login/cubit.dart';
import 'package:resort_store/business_logic/login/state.dart';
import 'package:resort_store/business_logic/session/cubit.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/data/repository/session/session.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/screens/login/widgets/formLogin.dart';
import 'package:resort_store/presentation/widgets/background.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:resort_store/presentation/widgets/dialog/custom_awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../business_logic/change_theme/cubit.dart';
import '../../../core/constants/route_constant.dart';
import '../../../core/constants/strings_app.dart';
import '../../../core/helpers/app_router.dart';
import '../../../core/helpers/saved_theme.dart';
import '../../resources/color_manger.dart';
import '../../resources/textStyle_manger.dart';
import '../../widgets/dialog/custom_alert_dailog.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_reset_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _usernameNode;
  late final FocusNode _passwordNode;
  final formKey = GlobalKey<FormState>();

  int? template = SharedHelper.sharedPreferences.getInt(AppStrings.template);
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameNode = FocusNode();
    _passwordNode = FocusNode();
  }

  @override
  void dispose() {
    _usernameNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     Padding(
      //       padding:  EdgeInsets.only(right: 15.w,left: 15.w,top: 10.h,bottom: 10.h),
      //       child: Container(
      //         height: 12.h,
      //         width: 50.w,
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(8.r),
      //             color: Colors.white
      //         ),
      //         child: InkWell(
      //           onTap: () {
      //             //TODO : Check template
      //             if(template == 1){
      //              AppRouter.offNamed(context, RouteConstants.main);
      //             }else {
      //               AppRouter.offNamed(context, RouteConstants.mainNewTemplate);
      //             }
      //           },
      //           child: Center(child: Text(AppStrings.skip.tr(),style: mediumTextStyle(fontSize: 10.sp,
      //               color:  AppColor.black),)),
      //         ),
      //       ),
      //     )
      //   ],
      //   backgroundColor:
      //       context.read<ThemeDataCubit>().recolor ?? AppColor.primaryAmwaj,
      //   elevation: 0.0,
      // ),
      body: BlocBuilder<LoginCubit, LoginStates>(
        builder: (context, state) {
          if (state is ErrorLoginState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              customAwesomeDialog(
                  context, state.e.toString(), DialogType.error);
            });
          } else if (state is SuccessLoginState) {
            print("**********---------------*/********************");
            print(SharedHelper.sharedPreferences.getString(AppStrings.sessionId));
            SharedHelper.sharedPreferences.setString(AppStrings.email, state.loginModel.data!.email!);
            SharedHelper.sharedPreferences.setString(AppStrings.firstName, state.loginModel.data!.firstname!);
            SharedHelper.sharedPreferences.setString(AppStrings.lastName, state.loginModel.data!.lastname!);
            // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            //   customAwesomeDialog(context,"Login Successfully", DialogType.success);
            // });
            // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            //   AppRouter.offNamed(context, RouteConstants.main);
            // });
            showToast(
                text: AppStrings.loginSuccessfully.tr(),
                color: ToastColors.SUCCESS)
                .then((value) {
              AppRouter.offNamed(context, RouteConstants.main);
            });
            /*instance<SessionRepository>().getSessionRepo().then((a){

               print(a);
                 if(a.data!.session != null ) {

                 }
             }
             );*/
          }
          return BackGround(
              widget: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 50.h),
                            Center(
                              child: Image.asset(
                                "assets/images/name.png",
                                width: 200.w,
                                height: 120.h,
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Center(
                              child: Form(
                                child: LoginForm(
                                  formKey: formKey,
                                  passwordController: _passwordController,
                                  emailController: _emailController,
                                  emailNode: _usernameNode,
                                  passwordNode: _passwordNode,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 25.h,
                            ),
                            Center(
                              child: CustomButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<LoginCubit>().login({
                                      "email": _emailController.text,
                                      "password": _passwordController.text
                                    });
                                  }
                                },
                                color: AppColor.primaryAmwaj,
                                elevation: 5.0,
                                width: 300.w,
                                height: 40.h,
                                radius: 8.0,
                                title: AppStrings.login.tr(),
                                textStyle: boldTextStyle(
                                  color: AppColor.white,
                                  fontSize: 16.0,
                                ),
                                horizontalMargin: 22,
                                verticalPadding: 8,
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Center(
                              child: Text(
                                  "-------------------------- ${AppStrings.or.tr().toUpperCase()} ---------------------------",
                                  style: boldTextStyle(
                                      color: AppColor.primaryLight, fontSize: 12)),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Center(
                              child: CustomButton(
                                onPressed: () {
                                  AppRouter.to(context, RouteConstants.register);
                                },
                                color: AppColor.primaryAmwaj.withOpacity(0.6),
                                elevation: 5.0,
                                width: 300.w,
                                height: 40.h,
                                radius: 8.0,
                                title: AppStrings.signup.tr(),
                                textStyle: boldTextStyle(
                                  color: AppColor.white,
                                  fontSize: 16.0,
                                ),
                                horizontalMargin: 22,
                                verticalPadding: 8,
                              ),
                            ),
                            SizedBox(height: 25.h,),
                            Center(
                              child: CustomButton(
                                onPressed: () {
                                  //             //TODO : Check template
                                  if(template == 1){
                                    AppRouter.offNamed(context, RouteConstants.main);
                                  }else {
                                    AppRouter.offNamed(context, RouteConstants.mainNewTemplate);
                                  }
                                },
                                color: AppColor.white,
                                elevation: 5.0,
                                width: 120.w,

                                height: 35.h,
                                radius: 25.0,
                                title: AppStrings.skip.tr(),
                                horizontalMargin: 22,
                                textStyle: boldTextStyle(fontSize: 16.sp, color: AppColor.black,height: 0.0.h),
                                verticalPadding: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (state is LoadingLoginState)
                    Center(
                      child: CircularProgressIndicator(color: AppColor.white),
                    )
                ],
              ));
        },
      ),
    );
  }
}
