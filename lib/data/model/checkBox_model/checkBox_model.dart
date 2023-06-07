import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckBoxModel {

  String? title ;
  bool value;
  CheckBoxModel({required this.title, this.value = false});

}


class MyNode {
   MyNode({
    required this.title,
    this.children = const [],
  });
   String? title;
   final List<MyNode> children;
}

class FancyTreeNode {
  String? title;
  IconData? icon;
  bool isSelected;
  final List<FancyTreeNode> children;

  FancyTreeNode({required this.title, this.icon = Icons.construction , this.isSelected = false, this.children = const <FancyTreeNode>[],});
}
