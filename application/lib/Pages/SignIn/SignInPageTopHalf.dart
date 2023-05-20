import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';

import 'ContinueWithButton.dart';
import 'SignUpTextWidget.dart';

class SignInPageTopHalf extends StatelessWidget {
  const SignInPageTopHalf({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(50),
      alignment: Alignment.topCenter,
      child: Column(children: [
        // Welcome
        const AutoSizeText(
          'Welcome',
          style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(42, 42, 42, 1)),
          maxLines: 1,
          maxFontSize: 75,
        ),

        // Sign up to Start
        const AutoSizeText(
          'Sign Up To Start',
          style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 16,
              color: Color.fromRGBO(157, 157, 157, 1)),
          maxLines: 1,
        ),

        SizedBox(
          height: height * 0.075,
        ),

        // Continue With Google
        const ContinueWithButton(
            iconPath: '../lib/Images/Google_Logo.png',
            description: 'Continue With Google'),

        SizedBox(
          height: height * 0.025,
        ),

        // Continue With Email
        const ContinueWithButton(
            iconPath: '../lib/Images/Email_Icon.png',
            description: 'Continue With Email'),

        SizedBox(
          height: height * 0.025,
        ),

        // Sign Up
        const SignUpTextWidget(),
      ]),
    );
  }
}
