import 'package:flutter/material.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/widgets/ContinueWith.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/widgets/ForgotPasswordButton.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/widgets/Header.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/widgets/SignInForm.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/widgets/SignUpButton.dart';

import '../../../../common_widgets/FWTextButton.dart';
import '../../controllers/SignInController.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final _formKey = GlobalKey<FormState>();

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
                height: height * 0.50,
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
                    SignInForm(formKey: _formKey),

                    const SizedBox(
                      height: 20,
                    ),
                    //Fogot Password
                    const ForgotPasswordButton(),

                    SizedBox(
                      height: height * 0.05,
                    ),

                    //Login
                    FWTextButton(
                        function: () {
                          if (_formKey.currentState!.validate()) {
                            SignInController.instance
                                .signInUserViaEmailAndPassword();
                          }
                        },
                        description: 'Sign In',
                        buttonColor: const Color.fromRGBO(66, 66, 66, 1),
                        textColor: Colors.white)
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}
