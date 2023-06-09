import 'package:flutter/material.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/widgets/ContinueWith.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/widgets/ForgotPasswordButton.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/widgets/Header.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/widgets/SignInForm.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/widgets/SignUpButton.dart';

import '../../../../common_widgets/FullWidthTextButton.dart';
import '../../controllers/SignInController.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            // Login Page Top Half
            Container(
              padding: const EdgeInsets.all(50),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  // Welcome & Sign In To Start header
                  const Header(),

                  SizedBox(
                    height: height * 0.075,
                  ),

                  // Continue with Facebook/ Google Buttons
                  const ContinueWith(),

                  SizedBox(
                    height: height * 0.025,
                  ),

                  //Sign Up Text Widget
                  const SignUpButton()
                ],
              ),
            ),

            // Login Page Bottom Half
            Container(
              width: width,
              height: 500,
              padding: const EdgeInsets.all(50),
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                gradient: widgetColor1,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // Login Form
                  SignInForm(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
