import 'package:flutter/material.dart';


class CustomPopUpDialog extends StatefulWidget {
  @override
  _CustomPopUpDialogState createState() => _CustomPopUpDialogState();
}

class _CustomPopUpDialogState extends State<CustomPopUpDialog> {
  String _selectedOption = "Option 1";
  final List<String> _menuItems = ["Option 1", "Option 2", "Option 3"];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String selectedOption) {
        setState(() {
          _selectedOption = selectedOption;
        });
      },
      itemBuilder: (BuildContext context) {
        return _menuItems.map((String menuItem) {
          return PopupMenuItem<String>(
            value: menuItem,
            child: Text(menuItem),
          );
        }).toList();
      },
      child: Text("$_selectedOption"),
    );
  }
}


