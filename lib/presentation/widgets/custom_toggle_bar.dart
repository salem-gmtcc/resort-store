

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

import '../resources/color_manger.dart';
import '../resources/textStyle_manger.dart';
import 'custom_padding.dart';

class CustomToggleBar extends StatefulWidget{
  final List<String> labels;
  final double width;
  final double height;
   int index;
   CustomToggleBar({required this.labels,required this.width,required this.height,required this.index});
  @override
  State<CustomToggleBar> createState() => _CustomToggleBarState();
}
class _CustomToggleBarState extends State<CustomToggleBar> {
  @override
  Widget build(BuildContext context) {
    return CustomPadding.symmetric(
      horizontal: 5.0,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: FlutterToggleTab(
          borderRadius: 20.r,
          selectedIndex: widget.index,
          selectedBackgroundColors:  [AppColor.grey.withOpacity(0.1)],
          selectedTextStyle: boldTextStyle(
              fontSize: 11.0,
              color:AppColor.black
          ),
          unSelectedTextStyle: boldTextStyle(
              fontSize: 10.0,
              color:AppColor.black
          ),
          labels: widget.labels,
          selectedLabelIndex: (index) {
            setState(() {
              widget.index = index;
              print("index:${index}");
              print("widget.index:${widget.index}");
            });
          },
          isScroll: false,
        ),
      ),
    );
  }
}