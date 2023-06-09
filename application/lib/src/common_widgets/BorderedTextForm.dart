import 'package:flutter/material.dart';

class BorderedTextForm extends StatelessWidget {
  final controller;
  final String labelText;
  final String hintText;
  final int numLines;
  final Color unfocusedBorderColor;
  final Color focusedBorderColor;
  const BorderedTextForm(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.unfocusedBorderColor,
      required this.focusedBorderColor,
      required this.numLines,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.left,
      controller: controller,
      minLines: numLines,
      maxLines: numLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
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
