import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path> {

  @override

 Path getClip(Size size){
  final path = Path();
  path.lineTo(0, size.height);
  path.quadraticBezierTo(size.width /4, size.height-40, size.width/2, size.height-20);
  path.quadraticBezierTo(3/4 * size.width, size.height, size.width, size.height-30);
  path.lineTo(size.width, 0);
  return path;
  }
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
    throw UnimplementedError();
  }
}
