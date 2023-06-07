import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:resort_store/presentation/resources/textStyle_manger.dart';
import 'package:flutter/material.dart';


class CustomDropDown extends StatefulWidget {
   List listItem ;
  var dropdownvalue ;
   CustomDropDown({required this.listItem,required this.dropdownvalue});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline:const SizedBox.shrink(),
      value: widget.dropdownvalue,
      items: widget.listItem.map((items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          widget.dropdownvalue = newValue;
        });
      },
    );
  }
}
