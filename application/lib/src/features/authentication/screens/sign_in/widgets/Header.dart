import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/constants/text_strings.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // Welcome
        AutoSizeText(
          loginPageText1,
          style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: heading1Color),
          maxLines: 1,
          maxFontSize: 75,
        ),

        // Sign up to Start
        AutoSizeText(
          loginPageText2,
          style: TextStyle(
              fontFamily: 'Raleway', fontSize: 16, color: heading2Color),
          maxLines: 1,
        ),
      ],
    );
  }
}
