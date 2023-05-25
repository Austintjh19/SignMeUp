// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:myapplication/Pages/ForgotPassword/ForgotPasswordPage.dart';

import '../OTP/OTPPage.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              // Change back to Forgot Password Page when done working on OTP
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ForgotPasswordPage()));
            },
            child: Text(
              'Forgot Password ?',
              style: TextStyle(
                  fontFamily: 'Raleway', fontSize: 12, color: Colors.white),
            ))
      ],
    );
  }
}
