import 'package:flutter/material.dart';

class UpdateProfileTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool formEnabled;
  final Icon prefixIcon;
  final String? Function(String?)? validator;
  const UpdateProfileTextField(
      {super.key,
      required this.controller,
      required this.formEnabled,
      required this.prefixIcon,
      this.validator});

  @override
  State<UpdateProfileTextField> createState() => _UpdateProfileTextFieldState();
}

class _UpdateProfileTextFieldState extends State<UpdateProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
          color: Color.fromRGBO(119, 143, 253, 1),
          fontFamily: 'Raleway',
          fontSize: 14),
      textAlign: TextAlign.left,
      controller: widget.controller,
      enabled: widget.formEnabled,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Container(
          margin: const EdgeInsets.only(right: 10),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 1, color: Colors.white),
            ),
          ),
          child: widget.prefixIcon,
        ),
      ),
      validator: widget.validator,
    );
  }
}
