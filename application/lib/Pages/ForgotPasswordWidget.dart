// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password ?',
              style: TextStyle(
                  fontFamily: 'Raleway', fontSize: 12, color: Colors.white),
            ))
      ],
    );
  }
}
