import 'package:flutter/material.dart';

class NBSingleLineTextField extends StatelessWidget {
  final controller;
  final String labelText;
  final bool obscureText;
  final Color unfocusedBorderColor;
  final Color focusedBorderColor;
  const NBSingleLineTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.obscureText,
      required this.unfocusedBorderColor,
      required this.focusedBorderColor});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: unfocusedBorderColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: focusedBorderColor)),
          labelText: labelText,
          hintStyle: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 16,
            color: unfocusedBorderColor,
          )),
    );
  }
}
