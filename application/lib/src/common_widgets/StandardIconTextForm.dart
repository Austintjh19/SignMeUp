import 'package:flutter/material.dart';
import 'package:myapplication/src/constants/colors.dart';

class StandardIconTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Icon icon;
  final String? Function(String?)? validator;

  const StandardIconTextForm(
      {super.key,
      required this.controller,
      required this.labelText,
      this.validator,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.left,
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: textColor500,
            fontFamily: 'Raleway',
            fontSize: 14,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: primaryColor500)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: primaryColor200)),
          prefixIcon: icon),
      validator: validator,
    );
  }
}
