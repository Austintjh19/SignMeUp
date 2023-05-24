// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:myapplication/Pages/SignIn/SignInPageBottomHalf.dart';
import 'package:myapplication/Pages/SignIn/SignInPageTopHalf.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        //  To change to CustomScrollView
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
