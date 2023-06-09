import 'package:flutter/material.dart';

class FullWidthTextButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String description;
  final Function function;
  const FullWidthTextButton(
      {super.key,
      required this.description,
      required this.buttonColor,
      required this.textColor,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
        minimumSize: const Size.fromHeight(30),
        shadowColor: Colors.black,
        elevation: 20,
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        description,
        style: TextStyle(fontFamily: 'Raleway', fontSize: 16, color: textColor),
      ),
    );
  }
}
