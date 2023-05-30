import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: TextTheme(
        displayLarge:
            GoogleFonts.ubuntu(color: const Color.fromRGBO(42, 42, 42, 1)),
        displayMedium:
            GoogleFonts.ubuntu(color: const Color.fromRGBO(157, 157, 157, 1)),
        bodyText1:
            GoogleFonts.ubuntu(color: const Color.fromRGBO(42, 42, 42, 1)),
        bodyText2:
            GoogleFonts.ubuntu(color: const Color.fromRGBO(255, 255, 255, 1)),
      ));
}
