import 'package:flutter/material.dart';

class FullWidthButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String description;
  const FullWidthButton(
      {super.key,
      required this.description,
      required this.buttonColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 75),
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
