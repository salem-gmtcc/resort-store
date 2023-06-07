import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manger.dart';
import '../resources/textStyle_manger.dart';
import 'custom_padding.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final Function(T value) onChanged;
  final T value;
  final String title;
  final bool isSelected;
  final double fontSize;
  final double? width;
  final bool filled;
  final bool enableBorder;
  final EdgeInsets? padding;

  const CustomRadioButton({
    Key? key,
    required this.onChanged,
    required this.value,
    required this.title,
    this.isSelected = false,
    this.fontSize = 12,
    this.width,
    this.filled = false,
    this.enableBorder = true,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: width?.w,
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: 4.h,
              horizontal: 12.w,
            ),
        decoration: BoxDecoration(
          color: filled
              ? isSelected
              ? AppColor.primaryAmwaj
              : AppColor.white
              : AppColor.white,
          border: enableBorder
              ? Border.all(
            color: isSelected
                ? filled
                ? AppColor.border1
                : AppColor.primaryAmwaj
                : AppColor.border1,
            width: 1.w,
          )
              : null,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomPadding.symmetric(
              vertical: 4,
              horizontal: 4,
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 400,
                ),
                width: 16.w,
                height: 16.w,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? filled
                        ? AppColor.white
                        : AppColor.primaryAmwaj
                        : AppColor.grey.withOpacity(0.7),
                    width: 1.w,
                  ),
                ),
                child: isSelected
                    ? Center(
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    width: 11.w,
                    height: 11.w,
                    decoration: BoxDecoration(
                      color: AppColor.primaryAmwaj,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
                    : const SizedBox.shrink(),
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            Expanded(
              child: Text(
                title,
                style: semiBoldTextStyle(
                  fontSize: fontSize,
                  color: isSelected
                      ? filled
                      ? AppColor.white
                      : AppColor.primaryAmwaj
                      : AppColor.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
