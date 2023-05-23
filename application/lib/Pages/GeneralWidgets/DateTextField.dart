import 'package:flutter/material.dart';

class DateTextField extends StatefulWidget {
  final controller;
  final String labelText;
  final bool obscureText;
  final Color unfocusedBorderColor;
  final Color focusedBorderColor;
  final Function function;

  DateTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.obscureText,
      required this.unfocusedBorderColor,
      required this.focusedBorderColor,
      required this.function});

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  DateTime setDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.left,
      controller: widget.controller,
      obscureText: widget.obscureText,
      onTap: widget.function(),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: widget.unfocusedBorderColor,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: widget.unfocusedBorderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: widget.focusedBorderColor)),
      ),
    );
  }
}


// DateTextField(
//             controller: dobController,
//             labelText: 'Enter Date of Birth',
//             obscureText: false,
//             unfocusedBorderColor: Colors.grey,
//             focusedBorderColor: Color.fromRGBO(162, 178, 252, 1),
//             function: () async {
//               DateTime? selectedDate = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime(1900),
//                 lastDate: DateTime(2010),
//               ).then((value) {
//                 setState(() {
//                   dobController.text = DateFormat('yyyy-MM-dd').format(value!);
//                 });
//               });
//             }),