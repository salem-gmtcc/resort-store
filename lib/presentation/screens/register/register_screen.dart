import 'package:resort_store/business_logic/login/cubit.dart';
import 'package:resort_store/business_logic/register/cubit.dart';
import 'package:resort_store/business_logic/register/state.dart';
import 'package:resort_store/business_logic/session/cubit.dart';
import 'package:resort_store/presentation/screens/register/widgets/formRegister.dart';
import 'package:resort_store/presentation/widgets/background.dart';
import 'package:resort_store/presentation/widgets/custom_loading.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../business_logic/change_theme/cubit.dart';
import '../../../core/constants/route_constant.dart';
import '../../../core/constants/strings_app.dart';
import '../../../core/helpers/app_router.dart';
import '../../../core/helpers/shared_prefrencess.dart';
import '../../resources/color_manger.dart';
import '../../../../core/helpers/saved_theme.dart';

import '../../resources/textStyle_manger.dart';
import '../../widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final FocusNode _firstNameNode;
  late final FocusNode _lastNameNode;
  late final FocusNode _passwordNode;
  late final FocusNode _confirmPasswordNode;
  late final FocusNode _phoneNode;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _firstNameNode = FocusNode();
    _lastNameNode = FocusNode();
    _passwordNode = FocusNode();
    _confirmPasswordNode = FocusNode();
    _phoneNode = FocusNode();
  }

  @override
  void dispose() {
    _firstNameNode.dispose();
    _lastNameNode.dispose();
    _passwordNode.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _confirmPasswordNode.dispose();
    _phoneNode.dispose();
    super.dispose();
  }

  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGround(
        widget: BlocBuilder<RegisterCubit, RegisterStates>(
          builder: (context, state) {
            if (state is RegisterErrorState) {
              print("error: ${state.e.toString()}");
              showToast(text: state.e.toString(), color: ToastColors.ERROR);
            } else if (state is RegisterSuccessState) {
              SharedHelper.sharedPreferences.setString(AppStrings.email, state.registerModel.registerModelData!.email.toString());
              SharedHelper.sharedPreferences.setString(AppStrings.firstName, state.registerModel.registerModelData!.firstName.toString());
              SharedHelper.sharedPreferences.setString(AppStrings.lastName, state.registerModel.registerModelData!.lastName.toString());
              showToast(text: AppStrings.successfullAcountCreate.tr(), color: ToastColors.SUCCESS).then((value) {
                // context.read<LoginCubit>().login({
                //   "email": _emailController.text,
                //   "password": _passwordController.text
                // });
                AppRouter.offNamed(context, RouteConstants.main);
              });
            }
            return Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50.h,
                          ),
                          Image.asset(
                            "assets/images/name.png",
                            width: 200.w,
                            height: 120.h,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          //TODO: FORM register
                          Form(
                            child: RegisterForm(
                              formKey: formKey,
                              passwordController: _passwordController,
                              firstNameController: _firstNameController,
                              lastNameController: _lastNameController,
                              confirmPasswordController: _confirmPasswordController,
                              phoneController: _phoneController,
                              firstNameNode: _firstNameNode,
                              lastNameNode: _lastNameNode,
                              passwordNode: _passwordNode,
                              confirmPasswordNode: _confirmPasswordNode,
                              phoneNode: _phoneNode,
                              emailController: _emailController,
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          CustomPadding.only(
                            right: 35.w,
                            left: 35.w,
                            child: Row(
                              children: [
                                Checkbox(
                                  checkColor: AppColor.white,
                                  side: BorderSide(color: AppColor.white),
                                  value: this.value,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      this.value = value!;
                                      print(" /// $value");
                                    });
                                  },
                                ),
                                Text(
                                  AppStrings.iAgreeToTheTermsAndConditions.tr(),
                                  style: mediumTextStyle(
                                      fontSize: 12.sp,
                                      color: AppColor.primaryLight),
                                )
                              ],
                            ),
                          ),
                          //TODO: Button Register
                          SizedBox(
                            height: 30.h,
                          ),
                          CustomButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<RegisterCubit>().registerCubit({
                                  "firstname": _firstNameController.text,
                                  "lastname": _lastNameController.text,
                                  "email": _emailController.text,
                                  "password": _passwordController.text,
                                  "confirm": _confirmPasswordController.text,
                                  "telephone": _phoneController.text,
                                  "agree": 1
                                });
                              }
                            },
                            color: AppColor.white,
                            elevation: 5.0,
                            width: 250.w,
                            height: 30.h,
                            radius: 40.0,
                            title: AppStrings.signup.tr(),
                            textStyle: boldTextStyle(
                              color: AppColor.black,
                              fontSize: 15.0,
                            ),
                            horizontalMargin: 22,
                            verticalPadding: 8,
                          )
                        ],
                      ),
                    ),
                    if (state is RegisterLoadingState)
                      Center(child: CircularProgressIndicator(color: AppColor.white,)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
