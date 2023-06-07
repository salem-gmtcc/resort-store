import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../resources/color_manger.dart';

class CustomLoading extends StatefulWidget {
   final Color? color;
  const CustomLoading({this.color});
  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> with TickerProviderStateMixin{


  late final AnimationController _animationController;
  late Animation<double> _animation;

 @override
  void initState() {
    // TODO: implement initState
  _animationController =   AnimationController(
      vsync: this , duration: const Duration(seconds: 2)) ;
  _animation = CurvedAnimation(parent: _animationController, curve:Curves.ease);
  _animationController.repeat();
  print("repeat !!!!!");
  // _animationController.stop();
   super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: 60.w,
      child: RotationTransition(
        turns: _animation,
        child: Image.asset("assets/images/img.png",
            width: 20.w,
            height: 20.h,
            color:widget.color ?? AppColor.white),
      ),
    );
  }
}
