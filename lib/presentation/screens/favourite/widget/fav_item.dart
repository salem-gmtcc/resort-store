import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:resort_store/presentation/widgets/custom_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../business_logic/change_theme/cubit.dart';
import '../../../../core/helpers/textStyle_helper.dart';
import '../../../resources/color_manger.dart';

class FavItemWidget extends StatelessWidget {
  String? image, name;
  final Function() ? onClick;

  FavItemWidget(
      {required this.name, required this.image, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return CustomPadding.symmetric(
      horizontal: 10.w,
      vertical: 20.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //TODO: IMAGE Container
          Container(
            height: 80.h,
            width: 80.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.white),
            child: Stack(
              children: [
                Center(child: Image.network(image!,height: 50.h,width: 50.w,)),
                CustomPadding.symmetric(
                  horizontal: 8.w,
                  vertical: 5.h,
                  child: Container(
                      height: 20.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color:context.read<ThemeDataCubit>().recolor),
                      child: InkWell(
                        onTap: onClick,
                        child: Icon(Icons.close,
                            color: AppColor.white, size: 15.sp),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(width: 15.w,),
          //TODO: Product Name
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name!,
                  // maxLines: 1,
                  style:
                  textStyleCustom(
                    fontSize: 10.sp,
                  ),
                ),
                Text(
                  "",
                  style: textStyleCustom(
                    fontSize:  8.sp,
                    fontColor:Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 15.sp,
                      color: Colors.amber,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "8.5",
                      style: textStyleCustom(
                        fontSize: 10.sp,
                        fontColor:Colors.white,
                      )
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "||",
                      style: textStyleCustom(
                        fontSize: 8.sp,
                        fontColor:AppColor.white,
                      )
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "110 Review",
                      style: textStyleCustom(
                        fontSize: 10.sp,
                        fontColor:Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
