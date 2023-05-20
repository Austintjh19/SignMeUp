import 'package:flutter/material.dart';

class SignInTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Color unfocusedBorderColor;
  final Color focusedBorderColor;
  const SignInTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.unfocusedBorderColor,
      required this.focusedBorderColor});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: unfocusedBorderColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: focusedBorderColor)),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 16,
            color: unfocusedBorderColor,
          )),
    );
  }
}
