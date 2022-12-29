import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  //
  final TextInputType inputType;
  final TextEditingController controller;
  final String errortext;
  final String labeltext;
  bool isenable;

  //
  MyTextField({
    this.isenable = true,
    required this.errortext,
    required this.inputType,
    required this.controller,
    required this.labeltext,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isenable,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errortext;
        }
        return null;
      },
      keyboardType: inputType,
      controller: controller,
      cursorColor: Colors.purpleAccent,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_box),
        labelText: labeltext,
        labelStyle: TextStyle(
            fontSize: 17,
            color: Colors.purpleAccent,
            fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purpleAccent),
          borderRadius: (BorderRadius.circular(15.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.purpleAccent),
        ),
        contentPadding: EdgeInsets.only(top: 40, left: 20, right: 20),
      ),
    );
  }
}
