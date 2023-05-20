// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:myapplication/Pages/SignIn/ContinueWithButton.dart';
import 'package:myapplication/Pages/SignIn/SignInPageBottomHalf.dart';
import 'package:myapplication/Pages/SignIn/SignUpTextWidget.dart';
import 'package:myapplication/Pages/SignIn/SignInPageTopHalf.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          SignInPageTopHalf(),
          Expanded(
            child: SignInPageBottomHalf(),
          ),
        ]),
      ),
    );
  }
}
