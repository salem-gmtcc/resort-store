import 'package:resort_store/business_logic/information/cubit.dart';
import 'package:resort_store/business_logic/information/state.dart';
import 'package:resort_store/core/helpers/app_router.dart';
import 'package:resort_store/data/model/information/information.dart';
import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../business_logic/change_theme/cubit.dart';


class InformationScreen extends StatelessWidget {
  final InformationDataModel? informationDataModel;

  InformationScreen({required this.informationDataModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              AppRouter.back(context);
            },
            child: Icon(Icons.arrow_back, color: AppColor.white, size: 20)),
        elevation: 0.0,
        title: Text(informationDataModel!.title.toString(),
            style: mediumTextStyle(fontSize: 15.0, color: AppColor.white)),
        backgroundColor:context.read<ThemeDataCubit>().recolor,
        centerTitle: true,
      ),
      body: BlocBuilder<InformationCubit, InformationStates>(
        builder: (context, state) {
          if (state is OneInformationSuccessStates) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: context.read<ThemeDataCubit>().recolor,
              child: Center(
                child: HtmlWidget(
                    state.oneInformationModel.informationDataModel!.description!,
                    textStyle:
                    boldTextStyle(
                        color: AppColor.white,
                        fontSize: 12.sp
                    )
                ),
              ),
            );
          } else if (state is InformationErrorStates) {
            showToast(text: state.e.toString(), color: ToastColors.ERROR);
          } else if (state is InformationLoadingStates) {
            Center(child: CircularProgressIndicator(color: AppColor.white));
          }
          return Center(
              child: CircularProgressIndicator(color: AppColor.white));
        },
      ),
    );
  }
}
