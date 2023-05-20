import 'package:flutter/material.dart';

class ContinueWith extends StatelessWidget {
  final String iconPath;
  final String description;
  const ContinueWith(
      {super.key, required this.iconPath, required this.description});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ElevatedButton.icon(
      onPressed: () {},
      icon: Image.asset(
        iconPath,
        height: 30,
        width: 30,
      ),
      label: Text(
        description,
        style: const TextStyle(
            fontFamily: 'Raleway',
            fontSize: 16,
            color: Color.fromRGBO(42, 42, 42, 1)),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 75),
        minimumSize: Size(width * 0.75, 30),
        shadowColor: Colors.black,
        elevation: 20,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
