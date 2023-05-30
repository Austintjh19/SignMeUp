import 'package:flutter/material.dart';

class BSingleLineTextField extends StatelessWidget {
  final controller;
  final String labelText;
  final bool obscureText;
  final Color unfocusedBorderColor;
  final Color focusedBorderColor;
  final Icon icon;
  const BSingleLineTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.obscureText,
      required this.unfocusedBorderColor,
      required this.focusedBorderColor,
      required this.icon});

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
            fontFamily: 'Raleway',
            fontSize: 14,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: unfocusedBorderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: focusedBorderColor)),
          prefixIcon: icon),
    );
  }
}
