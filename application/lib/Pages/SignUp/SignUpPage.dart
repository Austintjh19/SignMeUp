import 'package:flutter/material.dart';
import 'package:myapplication/Pages/GeneralWidgets/ReturnButton.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: ReturnButton(context: context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
