import 'package:flutter/material.dart';
import 'package:myapplication/src/features/authentication/screens/login/widgets/ContinueWith.dart';
import 'package:myapplication/src/features/authentication/screens/login/widgets/Header.dart';
import 'package:myapplication/src/features/authentication/screens/login/widgets/SignUp.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
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
                  const SignUp()
                ],
              ),
            ),
            Container()
          ]),
        ),
      ),
    );
  }
}
