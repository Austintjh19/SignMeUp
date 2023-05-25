import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapplication/Services/GoogleSignInAndUp.dart';
import 'package:myapplication/User/AppUser.dart';

import 'ContinueWithButton.dart';
import 'SignUpText.dart';

class SIPTopWidgets extends StatefulWidget {
  const SIPTopWidgets({super.key});

  @override
  State<SIPTopWidgets> createState() => _SIPTopWidgetsState();
}

class _SIPTopWidgetsState extends State<SIPTopWidgets> {
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
        ContinueWithButton(
            function: () {
              GoogleSignInAndUp().signInWithGoogle();
            },
            iconPath: '../lib/Images/Google_Logo.png',
            description: 'Continue With Google'),

        SizedBox(
          height: height * 0.025,
        ),

        // Continue With Email
        ContinueWithButton(
            function: () {},
            iconPath: '../lib/Images/Email_Icon.png',
            description: 'Continue With Email'),

        SizedBox(
          height: height * 0.025,
        ),

        // Sign Up
        const SignUpText(),
      ]),
    );
  }
}
