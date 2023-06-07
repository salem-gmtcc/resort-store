import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manger.dart';
import '../resources/textStyle_manger.dart';


class CustomToggleButton extends StatefulWidget {
   final String title;
   final String title1;
   CustomToggleButton({
     required this.title,
      required this.title1
   });

  @override
  State<CustomToggleButton> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {

  List<bool> _isSelected = List.generate(2, (index) => false);

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: (int index) {
       setState(() {
           _isSelected = [false ,false];
          _isSelected[index] = true;
          print(_isSelected);
       });
      },
      borderRadius:  BorderRadius.all(Radius.circular(8.r)),
      selectedBorderColor: AppColor.primaryAmwaj,
      selectedColor: AppColor.primaryAmwaj,
      color: AppColor.primaryAmwaj,
      constraints:  BoxConstraints(
        minHeight: 30.h,
        minWidth: 110.w,
      ),
      isSelected: _isSelected,
      children: [
        Text(widget.title,style: mediumTextStyle(fontSize: 15, color: AppColor.black)),
        Text(widget.title1,style: mediumTextStyle(fontSize: 15, color: AppColor.black)),
    ]
    );
  }
}
