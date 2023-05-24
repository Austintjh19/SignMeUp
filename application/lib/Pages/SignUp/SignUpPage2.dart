import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/Pages/GeneralWidgets/BackArrowButton.dart';
import 'package:myapplication/Pages/SignUp/EnterUserDetails1.dart';

import 'EnterUserDetails2.dart';

class SignUpPage2 extends StatefulWidget {
  const SignUpPage2({super.key});

  @override
  State<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 25, vertical: 25),
                alignment: Alignment.centerLeft,
                child: BackArrowButton(context: context),
              ),

              // Greetings
              const AutoSizeText(
                'Almost Done',
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
                'Just add a Profile Image & Description about you.',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    color: Color.fromRGBO(157, 157, 157, 1)),
                maxLines: 1,
              ),

              const SizedBox(height: 25),

              Container(
                width: width,
                padding: EdgeInsets.all(50),
                alignment: Alignment.topCenter,
                child: EnterUserDetails2(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
