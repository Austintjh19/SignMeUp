import 'package:flutter/material.dart';

class SingleLineTextFieldWithBorder extends StatelessWidget {
  final controller;
  final String labelText;
  final bool obscureText;
  final Color unfocusedBorderColor;
  final Color focusedBorderColor;
  const SingleLineTextFieldWithBorder(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.obscureText,
      required this.unfocusedBorderColor,
      required this.focusedBorderColor});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: unfocusedBorderColor,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: unfocusedBorderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: focusedBorderColor)),
      ),
    );
  }
}
