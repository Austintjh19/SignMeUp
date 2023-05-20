// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
            onPressed: () {},
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
