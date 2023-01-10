import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/settings_provider.dart';

class EditTaskField extends StatelessWidget {
  TextEditingController controller;
  String hint;
  TextInputType type;

  EditTaskField(this.hint, this.controller, this.type);

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return TextFormField(
      style: TextStyle(
          color: settingsProvider.isDarkMood() ? Colors.white : Colors.black),
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }
}
