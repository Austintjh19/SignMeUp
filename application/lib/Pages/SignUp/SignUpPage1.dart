import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/src/common_widgets/BackArrowButton.dart';
import 'package:myapplication/Pages/SignUp/SUPWidgets1.dart';

class SignUpPage1 extends StatefulWidget {
  const SignUpPage1({super.key});

  @override
  State<SignUpPage1> createState() => _SignUpPage1State();
}

class _SignUpPage1State extends State<SignUpPage1> {
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
                'Hello There.',
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
                'Let\'s get started. Just fill in a few details.',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    color: Color.fromRGBO(157, 157, 157, 1)),
                maxLines: 1,
              ),

              const SizedBox(height: 25),

              Container(
                height: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage(
                            '../lib/Images/Sign_Up_Temp_Image.png'),
                        fit: BoxFit.fitHeight)),
              ),

              Container(
                width: width,
                padding: const EdgeInsets.all(50),
                alignment: Alignment.topCenter,
                child: const SUPWidgets1(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
