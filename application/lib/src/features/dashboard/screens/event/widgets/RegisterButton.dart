import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';

class RegisterButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final Function function;
  const RegisterButton(
      {super.key,
      required this.buttonColor,
      required this.buttonText,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        minimumSize: const Size.fromHeight(30),
        shadowColor: primaryColor700,
        elevation: 20,
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
            fontFamily: 'Raleway', fontSize: 16, color: textColor100),
      ),
    );
  }
}
