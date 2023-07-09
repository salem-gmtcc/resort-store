import 'package:resort_store/business_logic/change_theme/cubit.dart';
import 'package:resort_store/business_logic/change_theme/state.dart';
import 'package:resort_store/business_logic/contact/state.dart';
import 'package:resort_store/business_logic/currencies/currencies_cubit.dart';
import 'package:resort_store/business_logic/edit_profile/cubit.dart';
import 'package:resort_store/business_logic/edit_profile/state.dart';
import 'package:resort_store/business_logic/information/cubit.dart';
import 'package:resort_store/business_logic/information/state.dart';
import 'package:resort_store/business_logic/languages/cubit.dart';
import 'package:resort_store/business_logic/languages/state.dart';
import 'package:resort_store/business_logic/logout/cubit.dart';
import 'package:resort_store/business_logic/payment_address/cubit.dart';
import 'package:resort_store/business_logic/payment_address/state.dart';
import 'package:resort_store/core/constants/route_constant.dart';
import 'package:resort_store/core/constants/strings_app.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/core/helpers/shared_prefrencess.dart';
import 'package:resort_store/data/repository/edit_profile/edit_profile.dart';
import 'package:resort_store/data/repository/information/information.dart';
import 'package:resort_store/data/repository/languages/languages.dart';
import 'package:resort_store/data/repository/payment_address/payment_address.dart';
import 'package:resort_store/di/di.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/screens/settings/widget/custom_list_tile.dart';
import 'package:resort_store/presentation/widgets/dialog/custom_alert_dailog.dart';
import 'package:resort_store/presentation/widgets/custom_button.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:resort_store/presentation/widgets/custom_textFeild.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../business_logic/change_text_color/change_text_color_cubit.dart';
import '../../../business_logic/contact/cubit.dart';
import '../../../core/helpers/textStyle_helper.dart';
import '../../widgets/dialog/custom_awesome_dialog.dart';
import '../../widgets/dialog/custom_general_dialog.dart';
import '../address_payment/custom_payment_address.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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

  int? templateCheck = SharedHelper.sharedPreferences.getInt(AppStrings.template);

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

  //TODO : create some values
  Color pickerColor1 = Color(0xff443a49);
  Color pickerColor2 = Color(0xff443a49);
  Color currentColor = Color(0xffffff);
  Color pickFontColor = Color(0xffffff);

//TODO: ValueChanged<Color> callback
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

  String code = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
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
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => BlocProvider(
                    create: (context) => EditProfileCubit(
                        editProfileRepository:
                        instance<EditProfileRepository>()),
                    child: BlocBuilder<EditProfileCubit, EditProfileStates>(
                      builder: (context, state) {
                        if (state is SuccessEditProfileState) {
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            customAwesomeDialog(
                                context,
                                "Successfully Update Profile",
                                DialogType.success);
                          });
                        } else if (state is ErrorEditProfileState) {
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            customAwesomeDialog(context, state.e.toString(),
                                DialogType.error);
                          });
                        }
                        return CustomAlertDialog(
                          widget: Stack(
                            children: [
                              Container(
                                height: 300.h,
                                width: 250.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: AppColor.white,
                                ),
                                child: Form(
                                  key: _keyUpdateProfile,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomTextField(
                                        width: 250.w,
                                        height: 40.h,
                                        radius: 50.r,
                                        hintText: AppStrings.firstName.tr(),
                                        controller: _updateFirstName,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppStrings.required.tr();
                                          }
                                          return null;
                                        },
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                            borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                            borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                            borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj)),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                            borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                            borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj)),
                                        borderColor:
                                        AppColor.primaryAmwaj,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      CustomTextField(
                                        width: 250.w,
                                        height: 40.h,
                                        radius: 50.r,
                                        hintText: AppStrings.lastName.tr(),
                                        controller: _updateLastName,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppStrings.required.tr();
                                          }
                                          return null;
                                        },
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                            borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                            borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                            borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj)),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                            borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                            borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj)),
                                        borderColor:
                                        AppColor.primaryAmwaj,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      IntlPhoneField(
                                        validator: (val) {
                                          if (val!.number.isEmpty) {
                                            showToast(
                                                text:
                                                "please enter your phone Number",
                                                color: ToastColors.WARNING);
                                          }
                                          return;
                                        },
                                        controller: _updatePhone,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                          ),
                                          disabledBorder:
                                          OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                          ),
                                        ),
                                        onChanged: (phone) {
                                          print(phone.completeNumber);
                                        },
                                        initialCountryCode: "SA",
                                        onCountryChanged: (country) {
                                          print(
                                              'Country changed to: ${country.name}');
                                        },
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      CustomTextField(
                                        width: 250.w,
                                        height: 40.h,
                                        radius: 50.r,
                                        hintText: AppStrings.email.tr(),
                                        controller: _updateEmail,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppStrings.required.tr();
                                          }
                                          return null;
                                        },
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                            borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                            borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                            borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj)),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                            borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.r),
                                            borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj)),
                                        borderColor:
                                        AppColor.primaryAmwaj,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      CustomButton(
                                        onPressed: () {
                                          if (_keyUpdateProfile
                                              .currentState!
                                              .validate()) {
                                            context
                                                .read<EditProfileCubit>()
                                                .editProfileCubit({
                                              "firstname":
                                              _updateFirstName!.text,
                                              "lastname":
                                              _updateLastName!.text,
                                              "email": _email!.text,
                                              "telephone":
                                              _updatePhone!.text
                                            });
                                          }
                                        },
                                        height: 35.h,
                                        width: 100.w,
                                        radius: 5.r,
                                        color: AppColor.primaryAmwaj,
                                        title: AppStrings.save.tr(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              if (state is LoadingEditProfileState)
                                Center(
                                  child: CircularProgressIndicator(
                                      color: AppColor.primaryAmwaj),
                                )
                            ],
                          ),
                          title: "Update Profile",
                          image: "user-Bold-1.svg",
                        );
                      },
                    ),
                  ));
            },
          ),
          Divider(color: AppColor.primaryLight, height: 1.h),
          //TODO: CHANGE LANGUAGE

          CustomTile(
              title: AppStrings.languages.tr(),
              onClick: () {
                showDialog(
                    context: context,
                    builder: (context) => BlocProvider(
                      create: (context) => LanguagesCubit(
                          languagesRepository:
                          instance<LanguagesRepository>())
                        ..getAllLanguagesCubit(),
                      child: BlocBuilder<LanguagesCubit, LanguageStates>(
                        builder: (context, state) {
                          if (state is GetAllLanguageSuccessState) {
                            return Stack(
                              children: [
                                CustomAlertDialog(
                                  widget: Container(
                                      height: 100.h,
                                      width: 180.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.r),
                                        // color: AppColor.red,
                                      ),
                                      child: ListView.builder(
                                          itemCount: state.languagesModel
                                              .languageDataModel!.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.all(5.sp),
                                              child: CustomButton(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Text(state.languagesModel.languageDataModel![index].name!,
                                                        style: mediumTextStyle(
                                                            fontSize: 12.sp,
                                                            color: AppColor
                                                                .white))

                                                  ],
                                                ),
                                                onPressed: () {
                                                  if (state.languagesModel.languageDataModel![index].code == "ar")
                                                  {
                                                    setState(() {
                                                      context.setLocale(const Locale('ar', 'SA'))
                                                          .then((value) {
                                                        AppRouter.back(context);
                                                      });
                                                    });
                                                  } else {
                                                    setState(() {
                                                      context
                                                          .setLocale(
                                                          const Locale(
                                                              'en',
                                                              'US'))
                                                          .then((value) {
                                                        AppRouter.back(
                                                            context);
                                                      });
                                                    });
                                                  }
                                                  print("---- ${state.languagesModel.languageDataModel![index].code}");

                                                  SharedHelper
                                                      .sharedPreferences
                                                      .setString(
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
                                                width: 80.w,
                                                height: 35.h,
                                                color: context.read<ThemeDataCubit>().recolor ??
                                                    AppColor.primaryAmwaj,
                                                radius: 20.r,
                                                textStyle: textStyleCustom(
                                                  context: context,
                                                  fontSize: 15.sp,
                                                ),
                                              ),
                                            );
                                          })),
                                  title: AppStrings.selectLanguages.tr(),
                                  image: 'globe-Bold.svg',
                                ),
                                if (state is LanguageLoadingState)
                                  Center(
                                    child: CircularProgressIndicator(
                                        color: AppColor.primaryAmwaj
                                    ),
                                  )
                              ],
                            );
                          } else if (state is LanguageErrorState) {
                            showToast(
                                text: state.error.toString(),
                                color: ToastColors.ERROR
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(
                                color: AppColor.white
                            ),
                          );
                        },
                      ),
                    ));
              },
              icon: Icons.language,
              iconColor: AppColor.white),
          // TODO: CHANGE CURRENCY
          CustomTile(
              title: AppStrings.changeCurrency.tr(),
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
                                    width: 180.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: AppColor.white,
                                    ),
                                    child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: state
                                            .currencies
                                            .currenciesModel!
                                            .currenciesDataModel!
                                            .length,
                                        itemBuilder: (context, index) {
                                          print(state
                                              .currencies
                                              .currenciesModel!
                                              .currenciesDataModel![index]
                                              .title);
                                          return Padding(
                                            padding: EdgeInsets.all(5.sp),
                                            child: CustomButton(
                                              title: state
                                                  .currencies
                                                  .currenciesModel!
                                                  .currenciesDataModel![index]
                                                  .title,
                                              onPressed: () {
                                                setState(() {
                                                  SharedHelper.sharedPreferences
                                                      .setString(
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
                                                    color: ToastColors.SUCCESS);

                                                AppRouter.back(context);
                                              },
                                              width: 80.w,
                                              height: 35.h,
                                              color: context.read<ThemeDataCubit>().recolor ??
                                                  AppColor.primaryAmwaj,
                                              radius: 20.r,
                                              textStyle: textStyleCustom(
                                                context: context,
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                          );
                                        })),
                                title: AppStrings.changeCurrency.tr(),
                                image: 'globe-Bold.svg',
                              );
                            } else if (state is ChangeCurrencyCode) {
                              code = state.code.toString();
                              print("*/**/*/*/*/*/*       $code");
                            } else if (state is CurrenciesErrorState) {
                              print("-------------- * ${state.error}");
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
              },
              icon: Icons.currency_exchange,
              iconColor: AppColor.white),

          // TODO: Information
          CustomTile(
              title: AppStrings.publicInformation.tr(),
              onClick: () {
                showDialog(
                    context: context,
                    builder: (context) => BlocProvider(
                      create: (context) => InformationCubit(
                          informationRepository:
                          instance<InformationRepository>())
                        ..getInformationCubit(),
                      child:
                      BlocBuilder<InformationCubit, InformationStates>(
                        builder: (context, state) {
                          if (state is InformationSuccessStates) {
                            return Stack(
                              children: [
                                CustomAlertDialog(
                                  widget: Container(
                                      height: 100.h,
                                      width: 180.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.r),
                                        color: AppColor.white,
                                      ),
                                      child: ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          itemCount: state.informationModel.data!.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.all(5.sp),
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
                                                width: 80.w,
                                                height: 35.h,
                                                color: context.read<ThemeDataCubit>().recolor ??
                                                    AppColor.primaryAmwaj,
                                                radius: 20.r,
                                                textStyle: textStyleCustom(
                                                  context: context,
                                                  fontSize: 15.sp,
                                                ),
                                              ),
                                            );
                                          })),
                                  title: AppStrings.publicInformation.tr(),
                                  image: 'info-circle-Bold-1.svg',
                                ),
                                if (state is InformationLoadingStates)
                                  CircularProgressIndicator(
                                    color: AppColor.white,
                                  )
                              ],
                            );
                          } else if (state is InformationErrorStates) {
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
              },
              icon: Icons.info_outline,
              iconColor: AppColor.white),
          //TODO: CHANGE PASSWORD
          CustomTile(
              title: AppStrings.changePassword.tr(),
              onClick: () {
                showDialog(
                    context: context,
                    builder: (context) => BlocProvider(
                      create: (context) => EditProfileCubit(
                          editProfileRepository:
                          instance<EditProfileRepository>()),
                      child:
                      BlocBuilder<EditProfileCubit, EditProfileStates>(
                        builder: (context, state) {
                          if (state is SuccessEditProfileState) {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              customAwesomeDialog(
                                  context,
                                  AppStrings.changeSuccessfully.tr(),
                                  DialogType.success);
                            });
                          } else if (state is ErrorEditProfileState) {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              customAwesomeDialog(context,
                                  state.e.toString(), DialogType.error);
                            });
                          }
                          return CustomAlertDialog(
                              image: "lock-Bold.svg",
                              widget: Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      height: 180.h,
                                      width: 200.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10.r),
                                        color: AppColor.white,
                                      ),
                                      child: Form(
                                        key: _keyChangePassword,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            CustomTextField(
                                              containerColor: AppColor.white,
                                              width: 190.w,
                                              height: 35.h,
                                              radius: 20.r,
                                              hintText: "",
                                              controller: _oldPassword,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppStrings.required
                                                      .tr();
                                                }
                                                return null;
                                              },
                                              focusedBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(10.r),
                                                  borderSide: BorderSide(
                                                    color: AppColor
                                                        .primaryAmwaj,
                                                  )),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.r),
                                                  borderSide: BorderSide(
                                                      color: AppColor
                                                          .primaryAmwaj)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.r),
                                                  borderSide: BorderSide(
                                                      color: AppColor
                                                          .primaryAmwaj)),
                                              disabledBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(10.r),
                                                  borderSide: BorderSide(
                                                      color: AppColor
                                                          .primaryAmwaj)),
                                              labelText:
                                              AppStrings.password.tr(),
                                              borderColor:
                                              AppColor.primaryAmwaj,
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            CustomTextField(
                                              containerColor: AppColor.white,
                                              width: 190.w,
                                              height: 35.h,
                                              radius: 20.r,
                                              hintText: "",
                                              controller: _newPassword,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppStrings.required
                                                      .tr();
                                                }
                                                return null;
                                              },
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.r),
                                                  borderSide: BorderSide(
                                                      color: AppColor
                                                          .primaryAmwaj)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.r),
                                                  borderSide: BorderSide(
                                                      color: AppColor
                                                          .primaryAmwaj)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.r),
                                                  borderSide: BorderSide(
                                                      color: AppColor
                                                          .primaryAmwaj)),
                                              disabledBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(10.r),
                                                  borderSide: BorderSide(
                                                      color: AppColor
                                                          .primaryAmwaj)),
                                              labelText:
                                              AppStrings.newPassword.tr(),
                                              borderColor:
                                              AppColor.primaryAmwaj,
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            CustomTextField(
                                              containerColor: AppColor.white,
                                              width: 190.w,
                                              height: 35.h,
                                              radius: 20.r,
                                              hintText: "",
                                              controller: _confirmPassword,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return AppStrings.required
                                                      .tr();
                                                }
                                                return null;
                                              },
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.r),
                                                  borderSide: BorderSide(
                                                      color: AppColor
                                                          .primaryAmwaj)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.r),
                                                  borderSide: BorderSide(
                                                      color: AppColor
                                                          .primaryAmwaj)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.r),
                                                  borderSide: BorderSide(
                                                      color: AppColor
                                                          .primaryAmwaj)),
                                              disabledBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(20.r),
                                                  borderSide: BorderSide(
                                                      color: AppColor
                                                          .primaryAmwaj)),
                                              labelText: AppStrings
                                                  .confirmPassword
                                                  .tr(),
                                              borderColor:
                                              AppColor.primaryAmwaj,
                                            ),
                                            SizedBox(
                                              height: 15.h,
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
                                                    _newPassword!.text,
                                                    "confirm":
                                                    _confirmPassword!.text
                                                  });
                                                }
                                              },
                                              width: 100.w,
                                              height: 30.h,
                                              color: context
                                                  .read<ThemeDataCubit>()
                                                  .recolor ??
                                                  AppColor.primaryAmwaj,
                                              radius: 20.r,
                                              title: AppStrings.save.tr(),
                                              textStyle: textStyleCustom(
                                                context: context,
                                                fontSize: 15.sp,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (state is LoadingEditProfileState)
                                    Center(
                                      child: CircularProgressIndicator(
                                          color: AppColor.primaryAmwaj),
                                    )
                                ],
                              ),
                              title: AppStrings.changePassword.tr());
                        },
                      ),
                    ));
              },
              icon: Icons.lock_open_outlined,
              iconColor: AppColor.white),
          //TODO:Shipping Address
          CustomTile(
              title: AppStrings.shippingAddress.tr(),
              onClick: () {
                //TODO : get All Address
                showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                        image: "map-marker-Bold.svg",
                        widget: BlocProvider(
                          create: (context) => PaymentAddressCubit(
                              paymentAddressRepository:
                              instance<PaymentAddressRepository>())
                            ..getAllPaymentAddressCubit(),
                          child: Column(
                            children: [
                              BlocBuilder<PaymentAddressCubit,
                                  PaymentAddressStates>(
                                  builder: (context, state) {
                                    print("******state : $state");
                                    if (state is SuccessGetAllPaymentAddressState) {
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
                                                    AppRouter.back(context);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(3.0),
                                                    child: Container(
                                                      height: 60.h,
                                                      width: 120.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
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
                                                                  .withOpacity(0.7)
                                                            ],
                                                            begin:
                                                            Alignment.topLeft,
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
                                                              style: boldTextStyle(
                                                                  fontSize: 10.0,
                                                                  color: AppColor
                                                                      .white)),
                                                          Text(
                                                              state
                                                                  .paymentAddressModel!
                                                                  .getPaymentAddressModel!
                                                                  .paymentListAddressModel![
                                                              i]
                                                                  .country!,
                                                              style: boldTextStyle(
                                                                color:
                                                                AppColor.white,
                                                                fontSize: 10.0,
                                                              )),
                                                          Text(
                                                              state
                                                                  .paymentAddressModel!
                                                                  .getPaymentAddressModel!
                                                                  .paymentListAddressModel![
                                                              i]
                                                                  .city!,
                                                              style:
                                                              mediumTextStyle(
                                                                color:
                                                                AppColor.white,
                                                                fontSize: 10.0,
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
                                                  Image.asset(
                                                      "assets/images/empty_box.png",
                                                      width: 100.w,
                                                      height: 80.h),
                                                  Text(
                                                    AppStrings.listEmpty.tr(),
                                                    style: textStyleCustom(
                                                      context: context,
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
                                          child: CircularProgressIndicator(
                                            color: AppColor.primaryAmwaj,
                                          ));
                                    } else if (state is ErrorPaymentAddressState) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((timeStamp) {
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
                                        create: (context) => PaymentAddressCubit(
                                            paymentAddressRepository: instance<
                                                PaymentAddressRepository>()),
                                        child: BlocBuilder<PaymentAddressCubit,
                                            PaymentAddressStates>(
                                          builder: (context, state) {
                                            if (state
                                            is SuccessSaveNewPaymentAddressState) {
                                              showToast(
                                                  text: AppStrings
                                                      .addSuccessfully
                                                      .tr(),
                                                  color:
                                                  ToastColors.SUCCESS)
                                                  .then((value) {
                                                AppRouter.back(context);
                                              });
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
                                            return SingleChildScrollView(
                                                child: CustomPaymentAddress());
                                          },
                                        ),
                                      ),
                                      AppStrings.addNewAddress.tr());
                                },
                                color: context.read<ThemeDataCubit>().recolor ??
                                    AppColor.primaryAmwaj,
                                height: 35.h,
                                width: 120.w,
                                radius: 5.r,
                                elevation: 2.0,
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
              },
              icon: Icons.local_shipping,
              iconColor: AppColor.white),
          //TODO:Return Order
          CustomTile(
              title: AppStrings.returnOrder.tr(),
              onClick: () {
                AppRouter.to(context, RouteConstants.returnOrder);
              },
              icon: Icons.keyboard_return_outlined,
              iconColor: AppColor.white),
          //TODO: Change Theme
          CustomTile(
              title: AppStrings.changeTheme.tr(),
              onClick: () {
                showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                        image: "settings-Bold-1.svg",
                        widget: BlocBuilder<ThemeDataCubit, ChangeThemeStates>(
                          builder: (context, state) {
                            if (state is ChangeThemeState) {
                              pickerColor1 = state.color;
                            } else if (state is ChangeSecondColorState) {
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
                                                .read<ThemeDataCubit>()
                                                .changeThemeDataCubit(
                                                colors[index]);
                                            SharedHelper.sharedPreferences
                                                .setInt(AppStrings.saveTheme,
                                                colors[index].value);
                                            AppRouter.back(context);
                                          },
                                          child: Container(
                                            height: 65.h,
                                            width: 65.w,
                                            child: index == 0 ?  Center(child: Text(AppStrings.primary.tr(),
                                              style: mediumTextStyle(fontSize: 12.sp, color: AppColor.white),
                                            )):Text(""),
                                            decoration: BoxDecoration(
                                                color: colors[index],
                                                borderRadius:
                                                BorderRadius.circular(
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
                                      builder: (context) => AlertDialog(
                                        title: Text(AppStrings.color1.tr()),
                                        content: SingleChildScrollView(
                                          child: ColorPicker(
                                            pickerColor: pickerColor1,
                                            onColorChanged: changeColor1,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: Text(AppStrings.ok.tr()),
                                            onPressed: () {
                                              // setState(() => currentColor = pickerColor1);
                                              print("pick color one ! !");
                                              context
                                                  .read<ThemeDataCubit>()
                                                  .changeThemeDataCubit(
                                                  pickerColor1);
                                              SharedHelper.sharedPreferences
                                                  .setInt(AppStrings.saveTheme,
                                                  pickerColor1.value);

                                              AppRouter.back(context);

                                              // TODO : Pick Second Color ------------------------------------ !!!
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title: Text(
                                                          AppStrings.color2.tr()),
                                                      content:
                                                      SingleChildScrollView(
                                                        child: ColorPicker(
                                                          pickerColor: pickerColor2,
                                                          onColorChanged:
                                                          changeColor2,
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        ElevatedButton(
                                                          child: Text(
                                                              AppStrings.ok.tr()),
                                                          onPressed: () {
                                                            // setState(() =>
                                                            //     currentColor =
                                                            //         pickerColor2);
                                                            context
                                                                .read<
                                                                ThemeDataCubit>()
                                                                .changeSecondColor(
                                                                pickerColor2);
                                                            SharedHelper.sharedPreferences
                                                                .setInt(
                                                                AppStrings
                                                                    .saveSecondColor,
                                                                pickerColor2
                                                                    .value);
                                                            AppRouter.back(context);
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
                                  color: context.read<ThemeDataCubit>().recolor,
                                  radius: 5.r,
                                  title: AppStrings.custom.tr(),
                                  textStyle: mediumTextStyle(
                                      fontSize: 15.sp, color: AppColor.white),
                                ),
                              ],
                            );
                          },
                        ),
                        title: AppStrings.changeTheme.tr()));
              },
              icon: Icons.color_lens_outlined,
              iconColor: AppColor.white),
          //TODO: Change Template
          CustomTile(
              title: AppStrings.changeTemplate.tr(),
              onClick: () {
                showDialog(
                    context: context,
                    builder: (context) => CustomAlertDialog(
                      title: AppStrings.changeTemplate.tr(),
                      image: "settings-Bold-1.svg",
                      widget: Container(
                        height: 100.h,
                        width: 180.w,
                        child: Column(
                          children: [
                            CustomButton(
                                onPressed: () {
                                  SharedHelper.sharedPreferences
                                      .setInt(AppStrings.template, 1);
                                  if (templateCheck == 1) {
                                    print("-------------- 1");
                                    AppRouter.back(context);
                                  }
                                },
                                color: AppColor.primaryAmwaj,
                                height: 35.h,
                                width: 150.w,
                                radius: 20.r,
                                title: AppStrings.template1.tr()),
                            SizedBox(
                              height: 15.h,
                            ),
                            CustomButton(
                                onPressed: () {
                                  print("-------------- 2");
                                  SharedHelper.sharedPreferences.setInt(AppStrings.template, 2);
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                      RouteConstants.splash,
                                          (route) => false);
                                },
                                color: AppColor.primaryAmwaj,
                                height: 30.h,
                                width: 150.w,
                                radius: 20.r,
                                title: AppStrings.template2.tr()),
                          ],
                        ),
                      ),
                    ));
                // AppRouter.offNamed(context, RouteConstants.mainNewTemplate);
              },
              icon: Icons.track_changes,
              iconColor: AppColor.white),
          //TODO : Change text Color
          CustomTile(
              title: AppStrings.ChangeTextColor.tr(),
              onClick: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      BlocBuilder<ChangeTextColorCubit, Color>(
                        builder: (context, state) {
                          pickFontColor = state;
                          print("************************ Color State  || $state");
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
                                  setState(() => currentColor = pickFontColor);
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
              },
              icon: Icons.text_fields,
              iconColor: AppColor.white),
          //TODO:my Order
          CustomTile(
              title: AppStrings.myOrder.tr(),
              onClick: () {
                AppRouter.to(context, RouteConstants.myOrder);
              },
              icon: Icons.repeat,
              iconColor: AppColor.white),
          //TODO: contact us
          CustomTile(
              title: AppStrings.contactUs.tr(),
              onClick: () {
                showDialog(
                    context: context,
                    builder: (context) => BlocProvider(
                      create: (context) => ContactCubit(instance()),
                      child: BlocBuilder<ContactCubit, ContactStates>(
                        builder: (context, state) {
                          if (state is ContactSuccessState) {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              customAwesomeDialog(
                                  context,
                                  AppStrings.sendDataSuccessfully.tr(),
                                  DialogType.success);
                            });
                          } else if (state is ContactErrorState) {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              customAwesomeDialog(context,
                                  state.e.toString(), DialogType.error);
                            });
                          }
                          return Stack(
                            children: [
                              CustomAlertDialog(
                                widget: Container(
                                  height: 190.h,
                                  width: 200.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(20.r),
                                    color: AppColor.white,
                                  ),
                                  child: Form(
                                    key: _keyContact,
                                    child: Column(
                                      children: [
                                        CustomTextField(
                                          containerColor: AppColor.white,
                                          width: 190.w,
                                          height: 35.h,
                                          radius: 20.r,
                                          hintText: "",
                                          controller: _name,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return AppStrings.required
                                                  .tr();
                                            }
                                            return null;
                                          },
                                          focusedBorder:
                                          OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(10.r),
                                              borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj,
                                              )),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.r),
                                              borderSide: BorderSide(
                                                  color: AppColor
                                                      .primaryAmwaj)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.r),
                                              borderSide: BorderSide(
                                                  color: AppColor
                                                      .primaryAmwaj)),
                                          disabledBorder:
                                          OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(10.r),
                                              borderSide: BorderSide(
                                                  color: AppColor
                                                      .primaryAmwaj)),
                                          labelText:
                                          AppStrings.name.tr(),
                                          borderColor:
                                          AppColor.primaryAmwaj,
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        CustomTextField(
                                          containerColor: AppColor.white,
                                          width: 190.w,
                                          height: 35.h,
                                          radius: 20.r,
                                          hintText: "",
                                          controller: _email,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return AppStrings.required
                                                  .tr();
                                            }
                                            return null;
                                          },
                                          focusedBorder:
                                          OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(10.r),
                                              borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj,
                                              )),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.r),
                                              borderSide: BorderSide(
                                                  color: AppColor
                                                      .primaryAmwaj)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.r),
                                              borderSide: BorderSide(
                                                  color: AppColor
                                                      .primaryAmwaj)),
                                          disabledBorder:
                                          OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(10.r),
                                              borderSide: BorderSide(
                                                  color: AppColor
                                                      .primaryAmwaj)),
                                          labelText:
                                          AppStrings.email.tr(),
                                          borderColor:
                                          AppColor.primaryAmwaj,
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        CustomTextField(
                                          containerColor: AppColor.white,
                                          width: 190.w,
                                          height: 60.h,
                                          radius: 20.r,
                                          hintText: AppStrings.comments.tr(),
                                          controller: _body,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return AppStrings.required
                                                  .tr();
                                            }
                                            return null;
                                          },
                                          errorBorder:  OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(10.r),
                                              borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj,
                                              )),
                                          focusedBorder:
                                          OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(10.r),
                                              borderSide: BorderSide(
                                                color: AppColor
                                                    .primaryAmwaj,
                                              )),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.r),
                                              borderSide: BorderSide(
                                                  color: AppColor
                                                      .primaryAmwaj)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10.r),
                                              borderSide: BorderSide(
                                                  color: AppColor
                                                      .primaryAmwaj)),
                                          disabledBorder:
                                          OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(10.r),
                                              borderSide: BorderSide(
                                                  color: AppColor
                                                      .primaryAmwaj)),
                                          // labelText:
                                          // AppStrings.comments.tr(),
                                          borderColor:
                                          AppColor.primaryAmwaj,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomButton(
                                          onPressed: () {
                                            context
                                                .read<ContactCubit>()
                                                .sendContactCubit({
                                              "name": _name!.text,
                                              "email": _email!.text,
                                              "enquiry": _body!.text
                                            });
                                          },
                                          width: 100.w,
                                          height: 30.h,
                                          color: context
                                              .read<ThemeDataCubit>()
                                              .recolor ??
                                              AppColor.primaryAmwaj,
                                          radius: 20.r,
                                          title: AppStrings.save.tr(),
                                          textStyle: textStyleCustom(
                                            context: context,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                title: AppStrings.contactUs.tr(),
                                image: 'comment-dots-Bold.svg',
                              ),
                              if (state is ContactLoadingState)
                                Center(
                                    child: CircularProgressIndicator(
                                      color: AppColor.primaryAmwaj,
                                    )),
                            ],
                          );
                        },
                      ),
                    ));
              },
              icon: Icons.contact_support_outlined,
              iconColor: AppColor.white),
          //TODO: LOG OUT
          CustomTile(
              title: AppStrings.logout.tr(),
              onClick: () {
                context.read<LogOutCubit>().getLogOut().then((value) {
                  SharedHelper.sharedPreferences.remove(AppStrings.email);
                  SharedHelper.sharedPreferences.remove(AppStrings.firstName);
                  SharedHelper.sharedPreferences.remove(AppStrings.lastName);
                  AppRouter.offNamed(context, RouteConstants.login);
                });
              },
              icon: Icons.logout,
              iconColor: AppColor.white),
          SizedBox(
            height: 60.h,
          )
        ],
      ),
    );
  }
}
