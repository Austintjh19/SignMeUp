import 'dart:ui';

import 'package:flutter/material.dart';

/// Text
const textColor600 = Color.fromRGBO(42, 42, 42, 1);
const textColor500 = Color.fromRGBO(128, 128, 128, 1); // grey
const textColor400 = Color.fromRGBO(122, 122, 122, 1);
const textColor300 = Color.fromRGBO(157, 157, 157, 1);
const textColor200 = Color.fromRGBO(162, 178, 252, 1);
const textColor100 = Color.fromRGBO(255, 255, 255, 1);

const heading1Color = Color.fromRGBO(42, 42, 42, 1);
const heading2Color = Color.fromRGBO(157, 157, 157, 1);
const bodyColor1 = Color.fromRGBO(42, 42, 42, 1);
const bodyColor2 = Color.fromRGBO(255, 255, 255, 1);

/// Primary Colors
const primaryColor100 = Color.fromRGBO(255, 255, 255, 1);
const primaryColor200 = Color.fromRGBO(162, 178, 252, 1);
const primaryColor300 = Color.fromRGBO(128, 150, 255, 1);
const primaryColor400 = Color.fromRGBO(157, 157, 157, 1);
const primaryColor500 = Color.fromRGBO(128, 128, 128, 1); // grey
const primaryColor600 = Color.fromRGBO(42, 42, 42, 1);
const primaryColor700 = Color.fromRGBO(0, 0, 0, 1);

// Box Shadow
List<BoxShadow> defaultBoxShadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.3),
    spreadRadius: 3,
    blurRadius: 7,
    offset: const Offset(0, 3),
  ),
];

/// Widgets
const unfocusedBorderColor = Color.fromRGBO(255, 255, 255, 1);
const focusedBorderColor = Color.fromRGBO(122, 122, 122, 1);
const widgetColor1 = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Color.fromRGBO(119, 143, 253, 1),
      Color.fromRGBO(252, 236, 175, 1)
    ]);

/// Container
const container1Color = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Color.fromRGBO(138, 158, 248, 1),
      Color.fromRGBO(252, 236, 175, 1)
    ]);

const container2Color = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Color.fromRGBO(219, 101, 140, 0.8),
      Color.fromRGBO(247, 187, 151, 0.8)
    ]);

const container3Color = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Color.fromRGBO(201, 115, 255, 0.8),
      Color.fromRGBO(174, 186, 248, 0.8)
    ]);

const container4Color = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Color.fromRGBO(127, 127, 213, 0.8),
      Color.fromRGBO(145, 234, 228, 0.8)
    ]);

const container5Color = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Color.fromRGBO(252, 182, 159, 0.8),
      Color.fromRGBO(255, 236, 210, 0.8)
    ]);

const container6Color = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [
      Color.fromRGBO(221, 214, 243, 0.8),
      Color.fromRGBO(250, 172, 168, 0.8)
    ]);
