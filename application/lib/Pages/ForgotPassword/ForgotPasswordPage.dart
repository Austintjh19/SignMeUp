// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import '../GeneralWidgets/BackArrowButton.dart';
import 'EnterEmail.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 25, vertical: 25),
              alignment: Alignment.centerLeft,
              child: BackArrowButton(context: context),
            ),
            Container(
                width: width,
                padding: EdgeInsets.all(50),
                alignment: Alignment.topCenter,
                child: EnterEmail()),
          ]),
        ),
      ),
    );
  }
}
