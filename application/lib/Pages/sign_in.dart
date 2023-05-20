// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:myapplication/Pages/ContinueWithWidget.dart';
import 'package:myapplication/Pages/SignInWidget.dart';
import 'package:myapplication/Pages/SignUpWidget.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(children: [
            SizedBox(
              height: height * 0.075,
            ),

            // Welcome
            AutoSizeText(
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
            AutoSizeText(
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
            ContinueWith(
                iconPath: '../lib/Images/Google_Logo.png',
                description: 'Continue With Google'),

            SizedBox(
              height: height * 0.025,
            ),

            // Continue With Email
            ContinueWith(
                iconPath: '../lib/Images/Email_Icon.png',
                description: 'Continue With Email'),

            SizedBox(
              height: height * 0.025,
            ),

            // Sign Up
            SignUp(),

            SizedBox(
              height: height * 0.025,
            ),

            Expanded(
              child: SignIn(),
            ),
          ]),
        ),
      ),
    );
  }
}
