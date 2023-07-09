import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/template_2/presentation/screens/settings/widget/build_text_icon.dart';
import 'package:resort_store/template_2/presentation/screens/settings/widget/build_tile.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../business_logic/change_text_color/change_text_color_cubit.dart';
import '../../../../business_logic/change_theme/cubit.dart';
import '../../../../business_logic/change_theme/state.dart';
import '../../../../business_logic/contact/cubit.dart';
import '../../../../business_logic/contact/state.dart';
import '../../../../business_logic/currencies/currencies_cubit.dart';
import '../../../../business_logic/edit_profile/cubit.dart';
import '../../../../business_logic/edit_profile/state.dart';
import '../../../../business_logic/information/cubit.dart';
import '../../../../business_logic/information/state.dart';
import '../../../../business_logic/languages/cubit.dart';
import '../../../../business_logic/languages/state.dart';
import '../../../../business_logic/logout/cubit.dart';
import '../../../../business_logic/payment_address/cubit.dart';
import '../../../../business_logic/payment_address/state.dart';
import '../../../../core/constants/route_constant.dart';
import '../../../../core/constants/strings_app.dart';
import '../../../../core/helpers/app_router.dart';
import '../../../../core/helpers/shared_prefrencess.dart';
import '../../../../core/helpers/textStyle_helper.dart';
import '../../../../data/repository/currencies/currencies.dart';
import '../../../../data/repository/edit_profile/edit_profile.dart';
import '../../../../data/repository/information/information.dart';
import '../../../../data/repository/languages/languages.dart';
import '../../../../data/repository/payment_address/payment_address.dart';
import '../../../../di/di.dart';
import '../../../../presentation/screens/address_payment/custom_payment_address.dart';
import '../../../../presentation/widgets/custom_button.dart';
import '../../../../presentation/widgets/custom_padding.dart';
import '../../../../presentation/widgets/custom_textFeild.dart';
import '../../../../presentation/widgets/custom_toast.dart';
import '../../../../presentation/widgets/dialog/custom_alert_dailog.dart';
import '../../../../presentation/widgets/dialog/custom_awesome_dialog.dart';
import '../../../../presentation/widgets/dialog/custom_general_dialog.dart';

class SettingTemplateScreen extends StatefulWidget {
  @override
  State<SettingTemplateScreen> createState() => _SettingTemplateScreenState();
}

class _SettingTemplateScreenState extends State<SettingTemplateScreen> {
  List<Color> colors = [
    AppColor.primaryAmwaj,
    AppColor.red,
    AppColor.yellow,
    AppColor.coloGreenLight,
    AppColor.brown,
    AppColor.blue.withOpacity(0.5),
  ];

  String? email =
      SharedHelper.sharedPreferences.getString(AppStrings.email) ?? "";

  String? firstName =
  SharedHelper.sharedPreferences.getString(AppStrings.firstName);

  String? lastName =
  SharedHelper.sharedPreferences.getString(AppStrings.lastName);

  int? templateCheck =
  SharedHelper.sharedPreferences.getInt(AppStrings.template);

  String code = '';

  //TODO:
  TextEditingController? _name;
  TextEditingController? _email;
  TextEditingController? _body;
  TextEditingController? _oldPassword;
  TextEditingController? _newPassword;
  TextEditingController? _confirmPassword;

  TextEditingController? _updateFirstName;

  TextEditingController? _updateLastName;

  TextEditingController? _updatePhone;

  TextEditingController? _updateEmail;

  // create some values
  Color pickerColor1 = Color(0xff443a49);
  Color pickerColor2 = Color(0xff443a49);
  Color currentColor = Color(0xffffff);
  Color pickFontColor = Color(0xffffff);

// ValueChanged<Color> callback
  void changeColor1(Color color) {
    setState(() => pickerColor1 = color);
    print("---------------------  :$color");
  }

  void changeColor2(Color color) {
    setState(() => pickerColor2 = color);
    print("---------------------  :$color");
  }

  void ChangeTextColor(Color color) {
    setState(() {
      pickFontColor = color;
    });
    print("***************** text color  $color");
  }

  @override
  void initState() {
    // TODO: implement initState
    _name = TextEditingController();
    _email = TextEditingController();
    _body = TextEditingController();
    _oldPassword = TextEditingController();
    _newPassword = TextEditingController();
    _confirmPassword = TextEditingController();
    _updateFirstName = TextEditingController();
    _updateLastName = TextEditingController();
    _updatePhone = TextEditingController();
    _updateEmail = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _name!.dispose();
    _email!.dispose();
    _body!.dispose();
    _oldPassword!.dispose();
    _newPassword!.dispose();
    _confirmPassword!.dispose();
    _updateFirstName!.dispose();
    _updateLastName!.dispose();
    _updatePhone!.dispose();
    _updateEmail!.dispose();
    super.dispose();
  }

  final _keyContact = GlobalKey<FormState>();
  final _keyChangePassword = GlobalKey<FormState>();
  final _keyUpdateProfile = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white1,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.r),
                    bottomLeft: Radius.circular(20.r),
                  ),
                  color: AppColor.primaryAmwaj),
              child: Column(
                children: [
                  SizedBox(
                    height: 35.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppStrings.setting.tr(),
                            style: mediumTextStyle(
                                fontSize: 15.sp, color: AppColor.white)),
                        SvgPicture.asset(
                          "assets/icons/bell-Bold.svg",
                          color: AppColor.white,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  //TODO : Profile Information
                  ListTile(
                    title: Text("${firstName ?? ""} ${lastName ?? ""}",
                        style: textStyleCustom(
                          context: context,
                          fontSize: 18.sp,
                        )),
                    subtitle: Text(
                      email.toString(),
                      style: textStyleCustom(
                        context: context,
                        fontSize: 12.sp,
                      ),
                    ),
                    leading: SizedBox(
                      height: 80.h,
                      width: 80.w,
                      child: CircleAvatar(
                        radius: 40.r,
                        backgroundImage: const NetworkImage(
                          "https://media.istockphoto.com/id/1209654046/vector/user-avatar-profile-icon-black-vector-illustration.jpg?s=612x612&w=0&k=20&c=EOYXACjtZmZQ5IsZ0UUp1iNmZ9q2xl1BD1VvN6tZ2UI=",
                        ),
                      ),
                    ),
                    trailing: InkWell(
                      onTap: () {
                        context.read<LogOutCubit>().getLogOut().then((value) {
                          SharedHelper.sharedPreferences
                              .remove(AppStrings.email);
                          SharedHelper.sharedPreferences
                              .remove(AppStrings.firstName);
                          SharedHelper.sharedPreferences
                              .remove(AppStrings.lastName);
                          AppRouter.offNamed(context, RouteConstants.login);
                        });
                      },
                      child: Container(
                        height: 25.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 15.h,
                              width: 15.w,
                              child: Icon(Icons.logout,
                                  size: 16.sp, color: AppColor.white),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(AppStrings.logout.tr(),
                                style: boldTextStyle(
                                    fontSize: 12.sp, color: AppColor.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //TODO : Account
            SizedBox(
              height: 10.h,
            ),
            BuildTextIcon(
              name: AppStrings.personalInformation.tr(),
              icon: "user-Bold-1.svg",
            ),
            Container(
              width: 350.w,
              height: 110.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: AppColor.white,
              ),
              child: Column(
                children: [
                  BuildTile(
                      name: AppStrings.editProfile.tr(),
                      onClick: () {
                        showDialog(
                            context: context,
                            builder: (context) => BlocProvider<EditProfileCubit>(
                              create: (context) => EditProfileCubit(
                                  editProfileRepository:
                                  instance<EditProfileRepository>()),
                              child: BlocBuilder<EditProfileCubit, EditProfileStates>(
                                builder: (context, state) {
                                  if (state is SuccessEditProfileState) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback(
                                            (timeStamp) {
                                          customAwesomeDialog(
                                              context,
                                              "Successfully Update Profile",
                                              DialogType.success);
                                        });
                                  } else if (state
                                  is ErrorEditProfileState) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback(
                                            (timeStamp) {
                                          customAwesomeDialog(
                                              context,
                                              state.e.toString(),
                                              DialogType.error);
                                        });
                                  }
                                  return CustomAlertDialog(
                                      image: "user-Bold-1.svg",
                                      widget: Stack(
                                        children: [
                                          Form(
                                            key: _keyUpdateProfile,
                                            child: Column(
                                              children: [
                                                CustomTextField(
                                                  width: 250.w,
                                                  radius: 8.r,
                                                  height: 50.h,
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 3.sp,
                                                  ),
                                                  textStyle: mediumTextStyle(fontSize: 12.sp, color: AppColor.black),
                                                  containerColor: AppColor.white,
                                                  hintText: AppStrings.firstName
                                                      .tr(),
                                                  controller: _updateFirstName,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return AppStrings
                                                          .required
                                                          .tr();
                                                    }
                                                    return null;
                                                  },
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  disabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  errorBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  borderColor: AppColor.primaryAmwaj,
                                                ),
                                                CustomTextField(
                                                  width: 250.w,
                                                  height: 50.h,
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 3.sp,
                                                  ),
                                                  textStyle: mediumTextStyle(fontSize: 12.sp, color: AppColor.black),
                                                  radius: 8.r,
                                                  containerColor:
                                                  AppColor.white,
                                                  hintText: AppStrings
                                                      .lastName
                                                      .tr(),
                                                  controller:
                                                  _updateLastName,
                                                  validator: (value) {
                                                    if (value!
                                                        .isEmpty) {
                                                      return AppStrings
                                                          .required
                                                          .tr();
                                                    }
                                                    return null;
                                                  },
                                                  focusedBorder:  OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  border:  OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  enabledBorder:  OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  disabledBorder:  OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  errorBorder:  OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  borderColor: AppColor
                                                      .primaryAmwaj,
                                                ),

                                                IntlPhoneField(
                                                  validator: (val) {
                                                    if (val!.number
                                                        .isEmpty) {
                                                      showToast(
                                                          text:
                                                          "please enter your phone Number",
                                                          color: ToastColors
                                                              .WARNING);
                                                    }
                                                    return;
                                                  },
                                                  controller:
                                                  _updatePhone,
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(
                                                      horizontal: 3.sp,
                                                    ),
                                                    border:  OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            8.r),
                                                        borderSide: BorderSide(
                                                            width: 0.8.h,
                                                            color: AppColor
                                                                .grey)),

                                                    enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            8.r),
                                                        borderSide: BorderSide(
                                                            width: 0.8.h,
                                                            color: AppColor
                                                                .grey)),
                                                    errorBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            8.r),
                                                        borderSide: BorderSide(
                                                            width: 0.8.h,
                                                            color: AppColor
                                                                .grey)),
                                                    disabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            8.r),
                                                        borderSide: BorderSide(
                                                            width: 0.8.h,
                                                            color: AppColor
                                                                .grey)),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            8.r),
                                                        borderSide: BorderSide(
                                                            width: 0.8.h,
                                                            color: AppColor
                                                                .grey)),
                                                  ),
                                                  onChanged: (phone) {
                                                    print(phone
                                                        .completeNumber);
                                                  },
                                                  initialCountryCode:
                                                  "SA",
                                                  onCountryChanged:
                                                      (country) {
                                                    print(
                                                        'Country changed to: ${country.name}');
                                                  },
                                                ),

                                                CustomTextField(
                                                  width: 250.w,
                                                  radius: 15.r,
                                                  height: 50.h,
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 8.sp,
                                                  ),
                                                  textStyle: mediumTextStyle(fontSize: 12.sp, color: AppColor.black),
                                                  hintText: AppStrings
                                                      .email
                                                      .tr(),
                                                  containerColor:
                                                  AppColor.white,
                                                  controller:
                                                  _updateEmail,
                                                  validator: (value) {
                                                    if (value!
                                                        .isEmpty) {
                                                      return AppStrings
                                                          .required
                                                          .tr();
                                                    }
                                                    return null;
                                                  },
                                                  focusedBorder:  OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  border:  OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  enabledBorder:  OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  disabledBorder:  OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  errorBorder:  OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  borderColor: AppColor
                                                      .primaryAmwaj,
                                                ),
                                                CustomButton(
                                                  onPressed: () {
                                                    if (_keyUpdateProfile
                                                        .currentState!
                                                        .validate()) {
                                                      context
                                                          .read<
                                                          EditProfileCubit>()
                                                          .editProfileCubit({
                                                        "firstname":
                                                        _updateFirstName!
                                                            .text,
                                                        "lastname":
                                                        _updateLastName!
                                                            .text,
                                                        "email": _email!
                                                            .text,
                                                        "telephone":
                                                        _updatePhone!
                                                            .text
                                                      });
                                                    }
                                                  },
                                                  height: 40.h,
                                                  width: 250.w,
                                                  radius: 25.r,
                                                  color: AppColor
                                                      .primaryAmwaj,
                                                  title: AppStrings.save
                                                      .tr(),
                                                )
                                              ],
                                            ),
                                          ),
                                          if (state
                                          is LoadingEditProfileState)
                                            Center(child: CircularProgressIndicator(
                                                color: AppColor
                                                    .primaryAmwaj),
                                            )
                                        ],
                                      ),
                                      title: AppStrings.editProfile.tr());
                                },
                              ),
                            ));
                      }),
                  SizedBox(
                    height: 4.h,
                  ),
                  BuildTile(
                      name: AppStrings.changePassword.tr(),
                      onClick: () {
                        showDialog(
                            context: context,
                            builder: (context) => BlocProvider(
                              create: (context) => EditProfileCubit(
                                  editProfileRepository:
                                  instance<EditProfileRepository>()),
                              child: BlocBuilder<EditProfileCubit,
                                  EditProfileStates>(
                                builder: (context, state) {
                                  if (state is SuccessEditProfileState) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback(
                                            (timeStamp) {
                                          customAwesomeDialog(
                                              context,
                                              AppStrings.changeSuccessfully
                                                  .tr(),
                                              DialogType.success);
                                        });
                                  } else if (state
                                  is ErrorEditProfileState) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback(
                                            (timeStamp) {
                                          customAwesomeDialog(
                                              context,
                                              state.e.toString(),
                                              DialogType.error);
                                        });
                                  }
                                  return CustomAlertDialog(
                                      image: "lock-Bold.svg",
                                      widget: Stack(
                                        children: [
                                          Form(
                                            key: _keyChangePassword,
                                            child: Column(
                                              children: [

                                                CustomTextField(
                                                  width: 250.w,
                                                  radius: 8.r,
                                                  height: 50.h,
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 3.sp,
                                                  ),
                                                  controller:
                                                  _oldPassword,
                                                  textStyle: mediumTextStyle(fontSize: 12.sp, color: AppColor.black),
                                                  containerColor: AppColor.white,
                                                  hintText: AppStrings.password
                                                      .tr(),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return AppStrings
                                                          .required
                                                          .tr();
                                                    }
                                                    return null;
                                                  },
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  disabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  errorBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  borderColor: AppColor.primaryAmwaj,
                                                ),
                                                CustomTextField(
                                                  width: 250.w,
                                                  radius: 8.r,
                                                  height: 50.h,
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 3.sp,
                                                  ),
                                                  controller:
                                                  _newPassword,
                                                  textStyle: mediumTextStyle(fontSize: 12.sp, color: AppColor.black),
                                                  containerColor: AppColor.white,
                                                  hintText: AppStrings.newPassword
                                                      .tr(),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return AppStrings
                                                          .required
                                                          .tr();
                                                    }
                                                    return null;
                                                  },
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  disabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  errorBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  borderColor: AppColor.primaryAmwaj,
                                                ),
                                                CustomTextField(
                                                  width: 250.w,
                                                  radius: 8.r,
                                                  height: 50.h,
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 3.sp,
                                                  ),
                                                  controller:
                                                  _confirmPassword,
                                                  textStyle: mediumTextStyle(fontSize: 12.sp, color: AppColor.black),
                                                  containerColor: AppColor.white,
                                                  hintText: AppStrings.confirmPassword
                                                      .tr(),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return AppStrings
                                                          .required
                                                          .tr();
                                                    }
                                                    return null;
                                                  },
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  disabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  errorBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  borderColor: AppColor.primaryAmwaj,
                                                ),
                                                CustomButton(
                                                  onPressed: () {
                                                    if (_keyChangePassword
                                                        .currentState!
                                                        .validate()) {
                                                      context
                                                          .read<
                                                          EditProfileCubit>()
                                                          .changePasswordCubit({
                                                        "password":
                                                        _newPassword!
                                                            .text,
                                                        "confirm":
                                                        _confirmPassword!
                                                            .text
                                                      });
                                                    }
                                                  },
                                                  height: 40.h,
                                                  width: 250.w,
                                                  radius: 25.r,
                                                  color: context.read<
                                                      ThemeDataCubit>()
                                                      .recolor ??
                                                      AppColor
                                                          .primaryAmwaj,
                                                  title: AppStrings.save
                                                      .tr(),
                                                  textStyle:
                                                  textStyleCustom(
                                                      fontSize:
                                                      15.sp,
                                                      context:
                                                      context),
                                                )
                                              ],
                                            ),
                                          ),
                                          if (state
                                          is LoadingEditProfileState)
                                            Center(
                                              child:
                                              CircularProgressIndicator(
                                                  color: AppColor
                                                      .primaryAmwaj),
                                            )
                                        ],
                                      ),
                                      title:
                                      AppStrings.changePassword.tr());
                                },
                              ),
                            ));
                      }),
                  SizedBox(
                    height: 4.h,
                  ),
                  BuildTile(
                      name: AppStrings.addNewAddress.tr(),
                      onClick: () {
                        showDialog(
                            context: context,
                            builder: (context) => CustomAlertDialog(
                                image: "map-marker-Bold.svg",
                                widget: BlocProvider(
                                  create: (context) => PaymentAddressCubit(
                                      paymentAddressRepository: instance<
                                          PaymentAddressRepository>())
                                    ..getAllPaymentAddressCubit(),
                                  child: Column(
                                    children: [
                                      BlocBuilder<PaymentAddressCubit,
                                          PaymentAddressStates>(
                                          builder: (context, state) {
                                            print("******state : $state");
                                            if (state
                                            is SuccessGetAllPaymentAddressState) {
                                              if (state
                                                  .paymentAddressModel!
                                                  .getPaymentAddressModel!
                                                  .paymentListAddressModel!
                                                  .isNotEmpty) {
                                                return SizedBox(
                                                  height: 200.h,
                                                  width: 200.w,
                                                  child: ListView.builder(
                                                      physics:
                                                      const BouncingScrollPhysics(),
                                                      itemCount: state
                                                          .paymentAddressModel!
                                                          .getPaymentAddressModel!
                                                          .paymentListAddressModel!
                                                          .length,
                                                      itemBuilder: (context, i) {
                                                        return InkWell(
                                                          onTap: () {
                                                            AppRouter.back(
                                                                context);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                            child: Container(
                                                              height: 60.h,
                                                              width: 120.w,
                                                              decoration:
                                                              BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10.r),
                                                                gradient: LinearGradient(
                                                                    colors: [
                                                                      context
                                                                          .read<
                                                                          ThemeDataCubit>()
                                                                          .recolor ??
                                                                          AppColor
                                                                              .primaryAmwaj,
                                                                      context
                                                                          .read<
                                                                          ThemeDataCubit>()
                                                                          .recolor!
                                                                          .withOpacity(
                                                                          0.7)
                                                                    ],
                                                                    begin: Alignment
                                                                        .topLeft,
                                                                    end: Alignment
                                                                        .bottomRight),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                      state
                                                                          .paymentAddressModel!
                                                                          .getPaymentAddressModel!
                                                                          .paymentListAddressModel![
                                                                      i]
                                                                          .firstname!,
                                                                      style:
                                                                      textStyleCustom(
                                                                        context:
                                                                        context,
                                                                        fontSize:
                                                                        10.0,
                                                                      )),
                                                                  Text(
                                                                      state
                                                                          .paymentAddressModel!
                                                                          .getPaymentAddressModel!
                                                                          .paymentListAddressModel![
                                                                      i]
                                                                          .country!,
                                                                      style:
                                                                      textStyleCustom(
                                                                        context:
                                                                        context,
                                                                        fontSize:
                                                                        10.0,
                                                                      )),
                                                                  Text(
                                                                      state
                                                                          .paymentAddressModel!
                                                                          .getPaymentAddressModel!
                                                                          .paymentListAddressModel![
                                                                      i]
                                                                          .city!,
                                                                      style:
                                                                      textStyleCustom(
                                                                        context:
                                                                        context,
                                                                        fontSize:
                                                                        10.0,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                );
                                              } else {
                                                return SizedBox(
                                                    height: 125.h,
                                                    width: 150.w,
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          SvgPicture.asset(
                                                              "assets/icons/EmptyState.svg",
                                                              width: 100.w,
                                                              height: 80.h),
                                                          Text(
                                                            AppStrings.listEmpty
                                                                .tr(),
                                                            style:
                                                            mediumTextStyle(
                                                              color: AppColor.black,
                                                              fontSize: 15.sp,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ));
                                              }
                                            } else if (state
                                            is SuccessSendExistingPaymentAddressState) {
                                              print(
                                                  "-----------------------------------------");
                                            } else if (state
                                            is LoadingPaymentAddressState) {
                                              Center(
                                                  child:
                                                  CircularProgressIndicator(
                                                    color: AppColor.primaryAmwaj,
                                                  ));
                                            } else if (state
                                            is ErrorPaymentAddressState) {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback(
                                                      (timeStamp) {
                                                    customAwesomeDialog(
                                                        context,
                                                        state.error.toString(),
                                                        DialogType.error);
                                                  });
                                            }
                                            return Center(
                                                child: CircularProgressIndicator(
                                                  color: AppColor.primaryAmwaj,
                                                ));
                                          }),
                                      Divider(
                                        height: 5.h,
                                        color: AppColor.primaryAmwaj,
                                      ),
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                      CustomButton(
                                        onPressed: () {
                                          customGeneralDialog(
                                              context,
                                              BlocProvider(
                                                create: (context) =>
                                                    PaymentAddressCubit(
                                                        paymentAddressRepository:
                                                        instance<
                                                            PaymentAddressRepository>()),
                                                child: BlocBuilder<
                                                    PaymentAddressCubit,
                                                    PaymentAddressStates>(
                                                  builder: (context, state) {
                                                    if (state
                                                    is SuccessSaveNewPaymentAddressState) {
                                                      showToast(
                                                          text: AppStrings
                                                              .addSuccessfully
                                                              .tr(),
                                                          color:
                                                          ToastColors
                                                              .SUCCESS)
                                                          .then((value) {
                                                        AppRouter.back(
                                                            context);
                                                      });
                                                    } else if (state
                                                    is ErrorPaymentAddressState) {
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (timeStamp) {
                                                            customAwesomeDialog(
                                                                context,
                                                                state.error
                                                                    .toString(),
                                                                DialogType.error);
                                                          });
                                                    }
                                                    return SingleChildScrollView(
                                                        child:
                                                        CustomPaymentAddress());
                                                  },
                                                ),
                                              ),
                                              AppStrings.addNewAddress.tr());
                                        },
                                        color: context
                                            .read<ThemeDataCubit>()
                                            .recolor ??
                                            AppColor.primaryAmwaj,
                                        height: 40.h,
                                        width: 250.w,
                                        radius: 25.r,
                                        textStyle: textStyleCustom(
                                          context: context,
                                          fontSize: 12.sp,
                                        ),
                                        title: AppStrings.addNewAddress.tr(),
                                      ),
                                    ],
                                  ),
                                ),
                                title: AppStrings.addNewAddress.tr()));
                      }),
                  SizedBox(
                    height: 4.h,
                  ),
                  BuildTile(
                      name: AppStrings.changeCurrency.tr(),
                      onClick: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                BlocBuilder<CurrenciesCubit, CurrenciesState>(
                                  builder: (context, state) {
                                    if (state is CurrenciesSuccessState) {
                                      return CustomAlertDialog(
                                        widget: Container(
                                            height: 100.h,
                                            width: 250.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(20.r),
                                              color: AppColor.white,
                                            ),
                                            child: ListView.builder(
                                                physics:
                                                const BouncingScrollPhysics(),
                                                itemCount: state
                                                    .currencies
                                                    .currenciesModel!
                                                    .currenciesDataModel!
                                                    .length,
                                                itemBuilder:
                                                    (context, index) {
                                                  print(state
                                                      .currencies
                                                      .currenciesModel!
                                                      .currenciesDataModel![
                                                  index]
                                                      .title);
                                                  return Padding(
                                                    padding:
                                                    EdgeInsets.all(5.sp),
                                                    child: CustomButton(
                                                      title: state
                                                          .currencies
                                                          .currenciesModel!
                                                          .currenciesDataModel![
                                                      index]
                                                          .title,
                                                      onPressed: () {
                                                        setState(() {
                                                          SharedHelper.sharedPreferences.setString(
                                                              AppStrings
                                                                  .currencyCode,
                                                              state
                                                                  .currencies
                                                                  .currenciesModel!
                                                                  .currenciesDataModel![
                                                              index]
                                                                  .code
                                                                  .toString());
                                                        });

                                                        showToast(
                                                            text: AppStrings
                                                                .changeSuccessfully
                                                                .tr(),
                                                            color: ToastColors
                                                                .SUCCESS);

                                                        AppRouter.back(
                                                            context);
                                                      },
                                                      height: 40.h,
                                                      width: 250.w,
                                                      radius: 25.r,
                                                      color: context
                                                          .read<
                                                          ThemeDataCubit>()
                                                          .recolor ??
                                                          AppColor
                                                              .primaryAmwaj,
                                                    ),
                                                  );
                                                })),
                                        title: AppStrings.changeCurrency.tr(),
                                        image: 'globe-Bold.svg',
                                      );
                                    } else if (state is ChangeCurrencyCode) {
                                      code = state.code.toString();
                                      print("*/**/*/*/*/*/*       $code");
                                    } else if (state
                                    is CurrenciesErrorState) {
                                      print(
                                          "-------------- * ${state.error}");
                                      showToast(
                                          text: state.error.toString(),
                                          color: ToastColors.ERROR);
                                    }

                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: AppColor.white,
                                      ),
                                    );
                                  },
                                ));
                      }),
                  SizedBox(
                    height: 4.h,
                  ),
                ],
              ),
            ),
            //TODO : Theme Settings
            SizedBox(
              height: 10.h,
            ),
            BuildTextIcon(
              name: AppStrings.themeSettings.tr(),
              icon: "settings-Bold-1.svg",
            ),
            Padding(
              padding:
              EdgeInsets.only(top: 5.h, bottom: 5.h, right: 5.w, left: 5.w),
              child: Container(
                width: 350.w,
                height: 90.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: AppColor.white,
                ),
                child: Column(
                  children: [

                    BuildTile(
                        name: AppStrings.changeTheme.tr(),
                        onClick: () {
                          showDialog(
                              context: context,
                              builder: (context) => CustomAlertDialog(
                                widget: BlocBuilder<ThemeDataCubit,
                                    ChangeThemeStates>(
                                  builder: (context, state) {
                                    if (state is ChangeThemeState) {
                                      pickerColor1 = state.color;
                                    } else if (state
                                    is ChangeSecondColorState) {
                                      pickerColor2 = state.color;
                                    }
                                    return Column(
                                      children: [
                                        SizedBox(
                                          child: GridView.builder(
                                            itemCount: colors.length,
                                            gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 3.0,
                                                mainAxisSpacing: 3.0),
                                            itemBuilder: (context, index) {
                                              return Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<
                                                        ThemeDataCubit>()
                                                        .changeThemeDataCubit(
                                                        colors[index]);
                                                    SharedHelper
                                                        .sharedPreferences
                                                        .setInt(
                                                        AppStrings
                                                            .saveTheme,
                                                        colors[index]
                                                            .value);
                                                    AppRouter.back(context);
                                                  },
                                                  child: Container(
                                                    height: 65.h,
                                                    width: 65.w,
                                                    decoration: BoxDecoration(
                                                        color:
                                                        colors[index],
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            50.r)),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          height: 150.h,
                                          width: 200.w,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        CustomButton(
                                          onPressed: () {
                                            AppRouter.back(context);
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  AlertDialog(
                                                    title: Text(
                                                        AppStrings.color1.tr()),
                                                    content:
                                                    SingleChildScrollView(
                                                      child: ColorPicker(
                                                        pickerColor:
                                                        pickerColor1,
                                                        onColorChanged:
                                                        changeColor1,
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      ElevatedButton(
                                                        child: Text(
                                                            AppStrings.ok.tr()),
                                                        onPressed: () {
                                                          // setState(() => currentColor = pickerColor1);
                                                          print(
                                                              "pick color one ! !");
                                                          context
                                                              .read<
                                                              ThemeDataCubit>()
                                                              .changeThemeDataCubit(
                                                              pickerColor1);
                                                          SharedHelper
                                                              .sharedPreferences
                                                              .setInt(
                                                              AppStrings
                                                                  .saveTheme,
                                                              pickerColor1
                                                                  .value);

                                                          AppRouter.back(
                                                              context);

                                                          // TODO : Pick Second Color ------------------------------------ !!!
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                AlertDialog(
                                                                  title: Text(
                                                                      AppStrings
                                                                          .color2
                                                                          .tr()),
                                                                  content:
                                                                  SingleChildScrollView(
                                                                    child:
                                                                    ColorPicker(
                                                                      pickerColor:
                                                                      pickerColor2,
                                                                      onColorChanged:
                                                                      changeColor2,
                                                                    ),
                                                                  ),
                                                                  actions: <Widget>[
                                                                    ElevatedButton(
                                                                      child: Text(
                                                                          AppStrings
                                                                              .ok
                                                                              .tr()),
                                                                      onPressed:
                                                                          () {
                                                                        // setState(() =>
                                                                        //     currentColor =
                                                                        //         pickerColor2);
                                                                        context
                                                                            .read<
                                                                            ThemeDataCubit>()
                                                                            .changeSecondColor(
                                                                            pickerColor2);
                                                                        SharedHelper
                                                                            .sharedPreferences
                                                                            .setInt(
                                                                            AppStrings.saveSecondColor,
                                                                            pickerColor2.value);
                                                                        AppRouter.back(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                            );
                                          },
                                          height: 35.h,
                                          width: 100.w,
                                          color: context
                                              .read<ThemeDataCubit>()
                                              .recolor,
                                          radius: 5.r,
                                          title: AppStrings.custom.tr(),
                                          textStyle: mediumTextStyle(
                                              fontSize: 15.sp,
                                              color: AppColor.white),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                title: AppStrings.changeTheme.tr(),
                                image: 'settings-Bold-1.svg',
                              ));
                        }),
                    SizedBox(
                      height: 4.h,
                    ),
                    BuildTile(
                        name: AppStrings.ChangeTextColor.tr(),
                        onClick: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                BlocBuilder<ChangeTextColorCubit, Color>(
                                  builder: (context, state) {
                                    pickFontColor = state;
                                    print(
                                        "************************ Color State  || $state");
                                    return AlertDialog(
                                      title: Text(AppStrings.ChangeTextColor.tr()),
                                      content: SingleChildScrollView(
                                        child: ColorPicker(
                                          pickerColor: state,
                                          onColorChanged: ChangeTextColor,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: Text(AppStrings.ok.tr()),
                                          onPressed: () {
                                            setState(
                                                    () => currentColor = pickFontColor);
                                            context
                                                .read<ChangeTextColorCubit>()
                                                .changeColor(pickFontColor);
                                            SharedHelper.sharedPreferences.setInt(
                                                AppStrings.ChangeTextColor,
                                                pickFontColor.value);
                                            AppRouter.back(context);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                          );
                        }),
                    SizedBox(
                      height: 4.h,
                    ),
                    BuildTile(
                        name: AppStrings.changeTemplate.tr(),
                        onClick: () {
                          showDialog(
                              context: context,
                              builder: (context) => CustomAlertDialog(
                                title: AppStrings.changeTemplate.tr(),
                                image: "settings-Bold-1.svg",
                                widget: Container(
                                  height: 100.h,
                                  width: 250.w,
                                  child: Column(
                                    children: [
                                      CustomButton(
                                          onPressed: () {
                                            SharedHelper.sharedPreferences
                                                .setInt(
                                                AppStrings.template, 1);
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                RouteConstants.splash,
                                                    (route) => false);
                                          },
                                          color: context
                                              .read<
                                              ThemeDataCubit>()
                                              .recolor ??
                                              AppColor
                                                  .primaryAmwaj,
                                          height: 40.h,
                                          width: 250.w,
                                          radius: 25.r,

                                          title: AppStrings.template1.tr()),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      CustomButton(
                                          onPressed: () {
                                            SharedHelper.sharedPreferences
                                                .setInt(
                                                AppStrings.template, 2);
                                            if (templateCheck == 2) {
                                              AppRouter.back(context);
                                            }
                                          },
                                          color: context
                                              .read<
                                              ThemeDataCubit>()
                                              .recolor ??
                                              AppColor
                                                  .primaryAmwaj,
                                          height: 40.h,
                                          width: 250.w,
                                          radius: 25.r,
                                          title: AppStrings.template2.tr()),
                                    ],
                                  ),
                                ),
                              ));
                        }),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
              ),
            ),

            //TODO : Return Order & My Order
            SizedBox(
              height: 10.h,
            ),
            BuildTextIcon(
              name: AppStrings.myOrder.tr(),
              icon: "shopping-basket-Bold.svg",
            ),
            Padding(
              padding:
              EdgeInsets.only(top: 5.h, bottom: 5.h, right: 5.w, left: 5.w),
              child: Container(
                width: 350.w,
                height: 65.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: AppColor.white,
                ),
                child: Column(
                  children: [

                    BuildTile(
                        name: AppStrings.myOrder.tr(),
                        onClick: () {
                          AppRouter.to(context, RouteConstants.myOrder);
                        }),
                    SizedBox(
                      height: 4.h,
                    ),
                    BuildTile(
                        name: AppStrings.returnOrder.tr(),
                        onClick: () {
                          AppRouter.to(context, RouteConstants.returnOrder);
                        }),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
              ),
            ),

            //TODO : Information & contact
            SizedBox(
              height: 10.h,
            ),
            BuildTextIcon(
              name: AppStrings.publicInformation.tr(),
              icon: "info-circle-Bold-1.svg",
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 3.sp),
              child: Container(
                width: 350.w,
                height: 95.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: AppColor.white,
                ),
                child: Column(
                  children: [

                    BuildTile(
                        name: AppStrings.languages.tr(),
                        onClick: () {
                          showDialog(
                              context: context,
                              builder: (context) => BlocProvider(
                                create: (context) => LanguagesCubit(
                                    languagesRepository:
                                    instance<LanguagesRepository>())
                                  ..getAllLanguagesCubit(),
                                child: BlocBuilder<LanguagesCubit,
                                    LanguageStates>(
                                  builder: (context, state) {
                                    if (state
                                    is GetAllLanguageSuccessState) {
                                      return Stack(
                                        children: [
                                          CustomAlertDialog(
                                            widget: Container(
                                                height: 100.h,
                                                width: 250.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20.r),
                                                  // color: AppColor.red,
                                                ),
                                                child: ListView.builder(
                                                    itemCount: state
                                                        .languagesModel
                                                        .languageDataModel!
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                        EdgeInsets.all(
                                                            5.sp),
                                                        child: CustomButton(
                                                          title:  state
                                                              .languagesModel
                                                              .languageDataModel![
                                                          index]
                                                              .name!,
                                                          onPressed: () {
                                                            if (state
                                                                .languagesModel
                                                                .languageDataModel![
                                                            index]
                                                                .code ==
                                                                "ar") {
                                                              setState(() {
                                                                context
                                                                    .setLocale(const Locale(
                                                                    'ar',
                                                                    'SA'))
                                                                    .then(
                                                                        (value) {
                                                                      AppRouter
                                                                          .back(
                                                                          context);
                                                                    });
                                                              });
                                                            } else {
                                                              setState(() {
                                                                context
                                                                    .setLocale(const Locale(
                                                                    'en',
                                                                    'US'))
                                                                    .then(
                                                                        (value) {
                                                                      AppRouter
                                                                          .back(
                                                                          context);
                                                                    });
                                                              });
                                                            }
                                                            print(
                                                                "---- ${state.languagesModel.languageDataModel![index].code}");

                                                            SharedHelper.sharedPreferences.setString(
                                                                AppStrings
                                                                    .languageCode,
                                                                state
                                                                    .languagesModel
                                                                    .languageDataModel![
                                                                index]
                                                                    .code
                                                                    .toString());

                                                            //TODO : Selected Color

                                                            // if (state.languagesModel.languageDataModel![index].code == "ar") {
                                                            //   _selectedLanguages = true;
                                                            // } else if (state.languagesModel.languageDataModel![index].code == "ar") {
                                                            //   _selectedLanguages =
                                                            //       true;
                                                            // } else {
                                                            //   _selectedLanguages =
                                                            //       false;
                                                            // }
                                                          },
                                                          width: 250.w,
                                                          height: 40.h,
                                                          color: context
                                                              .read<
                                                              ThemeDataCubit>()
                                                              .recolor ??
                                                              AppColor
                                                                  .primaryAmwaj,
                                                          radius: 25.r,
                                                          textStyle:
                                                          textStyleCustom(
                                                            context:
                                                            context,
                                                            fontSize: 15.sp,
                                                          ),
                                                        ),
                                                      );
                                                    })),
                                            title: AppStrings
                                                .selectLanguages
                                                .tr(),
                                            image: 'globe-Bold.svg',
                                          ),
                                          if (state is LanguageLoadingState)
                                            Center(
                                              child:
                                              CircularProgressIndicator(
                                                  color: AppColor
                                                      .primaryAmwaj),
                                            )
                                        ],
                                      );
                                    } else if (state
                                    is LanguageErrorState) {
                                      showToast(
                                          text: state.error.toString(),
                                          color: ToastColors.ERROR);
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                          color: AppColor.white),
                                    );
                                  },
                                ),
                              ));
                        }),
                    SizedBox(
                      height: 4.h,
                    ),
                    BuildTile(
                        name: AppStrings.publicInformation.tr(),
                        onClick: () {
                          showDialog(
                              context: context,
                              builder: (context) => BlocProvider(
                                create: (context) => InformationCubit(
                                    informationRepository:
                                    instance<InformationRepository>())
                                  ..getInformationCubit(),
                                child: BlocBuilder<InformationCubit,
                                    InformationStates>(
                                  builder: (context, state) {
                                    if (state is InformationSuccessStates) {
                                      return Stack(
                                        children: [
                                          CustomAlertDialog(
                                            widget: Container(
                                                height: 200.h,
                                                width: 250,
                                                child: ListView.builder(
                                                    physics:
                                                    const BouncingScrollPhysics(),
                                                    itemCount: state
                                                        .informationModel
                                                        .data!
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding: EdgeInsets.only(
                                                            top: 8.sp
                                                        ),
                                                        child: CustomButton(
                                                          title: state
                                                              .informationModel
                                                              .data![index]
                                                              .title,
                                                          onPressed: () {
                                                            AppRouter.offNamed(
                                                                context,
                                                                RouteConstants
                                                                    .informationScreen,
                                                                arguments: state
                                                                    .informationModel
                                                                    .data![index]);
                                                          },
                                                          width: 250.w,
                                                          height: 40.h,
                                                          color: context
                                                              .read<
                                                              ThemeDataCubit>()
                                                              .recolor ??
                                                              AppColor
                                                                  .primaryAmwaj,
                                                          radius: 25.r,

                                                        ),
                                                      );
                                                    })),
                                            title: AppStrings
                                                .publicInformation
                                                .tr(),
                                            image: 'info-circle-Bold-1.svg',
                                          ),
                                          if (state
                                          is InformationLoadingStates)
                                            CircularProgressIndicator(
                                              color: AppColor.white,
                                            )
                                        ],
                                      );
                                    } else if (state
                                    is InformationErrorStates) {
                                      showToast(
                                          text: state.e.toString(),
                                          color: ToastColors.ERROR);
                                    }
                                    return Center(
                                      child: SizedBox(
                                          height: 50.h,
                                          width: 50.w,
                                          child: CircularProgressIndicator(
                                            color: AppColor.white,
                                          )),
                                    );
                                  },
                                ),
                              ));
                        }),
                    SizedBox(
                      height: 4.h,
                    ),
                    BuildTile(
                        name: AppStrings.contactUs.tr(),
                        onClick: () {
                          showDialog(
                              context: context,
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    ContactCubit(instance()),
                                child: BlocBuilder<ContactCubit,
                                    ContactStates>(
                                  builder: (context, state) {
                                    if (state is ContactSuccessState) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                              (timeStamp) {
                                            customAwesomeDialog(
                                                context,
                                                AppStrings.sendDataSuccessfully
                                                    .tr(),
                                                DialogType.success);
                                          });
                                    } else if (state is ContactErrorState) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                              (timeStamp) {
                                            customAwesomeDialog(
                                                context,
                                                state.e.toString(),
                                                DialogType.error);
                                          });
                                    }
                                    return Stack(
                                      children: [
                                        CustomAlertDialog(
                                          widget: Form(
                                            key: _keyContact,
                                            child: Column(
                                              children: [
                                                CustomTextField(
                                                  width: 250.w,
                                                  radius: 8.r,
                                                  height: 50.h,
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 3.sp,
                                                  ),
                                                  textStyle: mediumTextStyle(fontSize: 12.sp, color: AppColor.black),
                                                  containerColor: AppColor.white,
                                                  hintText: AppStrings.name
                                                      .tr(),
                                                  controller: _name,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return AppStrings
                                                          .required
                                                          .tr();
                                                    }
                                                    return null;
                                                  },
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  disabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  errorBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  borderColor: AppColor.primaryAmwaj,
                                                ),
                                                CustomTextField(
                                                  width: 250.w,
                                                  radius: 8.r,
                                                  height: 50.h,
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 3.sp,
                                                  ),
                                                  textStyle: mediumTextStyle(fontSize: 12.sp, color: AppColor.black),
                                                  containerColor: AppColor.white,
                                                  hintText: AppStrings.email
                                                      .tr(),
                                                  controller: _email,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return AppStrings
                                                          .required
                                                          .tr();
                                                    }
                                                    return null;
                                                  },
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  disabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  errorBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  borderColor: AppColor.primaryAmwaj,
                                                ),
                                                CustomTextField(
                                                  width: 250.w,
                                                  radius: 8.r,
                                                  height: 50.h,
                                                  maxLines: 3,
                                                  contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 3.sp,
                                                  ),
                                                  textStyle: mediumTextStyle(fontSize: 12.sp, color: AppColor.black),
                                                  containerColor: AppColor.white,
                                                  hintText: AppStrings.comments
                                                      .tr(),
                                                  controller: _body,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return AppStrings
                                                          .required
                                                          .tr();
                                                    }
                                                    return null;
                                                  },
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  disabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  errorBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.r),
                                                      borderSide: BorderSide(
                                                          width: 0.8.h,
                                                          color: AppColor
                                                              .grey)),
                                                  borderColor: AppColor.primaryAmwaj,
                                                ),

                                                SizedBox(height: 10.h,),
                                                CustomButton(
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                        ContactCubit>()
                                                        .sendContactCubit({
                                                      "name": _name!.text,
                                                      "email":
                                                      _email!.text,
                                                      "enquiry":
                                                      _body!.text
                                                    });
                                                  },
                                                  width: 250.w,
                                                  height: 40.h,
                                                  color: context
                                                      .read<
                                                      ThemeDataCubit>()
                                                      .recolor ??
                                                      AppColor
                                                          .primaryAmwaj,
                                                  radius: 25.r,
                                                  title: AppStrings.save
                                                      .tr(),
                                                  textStyle:
                                                  textStyleCustom(
                                                    context: context,
                                                    fontSize: 15.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          title: AppStrings.contactUs.tr(),
                                          image: 'comment-dots-Bold.svg',
                                        ),
                                        if (state is ContactLoadingState)
                                          Center(
                                              child:
                                              CircularProgressIndicator(
                                                color: AppColor.primaryAmwaj,
                                              )),
                                      ],
                                    );
                                  },
                                ),
                              ));
                        }),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: InkWell(
      //   onTap: (){
      //     context.read<LogOutCubit>().getLogOut().then((value) {
      //       SharedHelper.sharedPreferences.remove(AppStrings.email);
      //       SharedHelper.sharedPreferences.remove(AppStrings.firstName);
      //       SharedHelper.sharedPreferences.remove(AppStrings.lastName);
      //       AppRouter.offNamed(context, RouteConstants.login);
      //     });
      //   },
      //   child: Container(
      //     height: 25.h,
      //     width: 150.w,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(25.r),
      //     ),
      //     child:Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         SizedBox(
      //           height: 15.h,
      //           width: 15.w,
      //           child: Icon(Icons.logout,
      //               size: 15.sp,
      //               color: AppColor.spareTKTemplate),
      //         ),
      //         SizedBox(width: 5.w,),
      //         Text(AppStrings.logout.tr(),
      //             style: boldTextStyle(fontSize: 10.sp,
      //             color: AppColor.spareTKTemplate)),
      //
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
