// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../SignUp/SignUpPage1.dart';

class SignUpText extends StatefulWidget {
  const SignUpText({super.key});

  @override
  State<SignUpText> createState() => _SignUpTextState();
}

class _SignUpTextState extends State<SignUpText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        AutoSizeText(
          'Haven\'t got an account ?',
          style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(157, 157, 157, 1)),
          maxLines: 1,
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SignUpPage1()));
            },
            child: Text(
              'Sign Up !',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(32, 121, 255, 1)),
            )),
      ]),
    );
  }
}
