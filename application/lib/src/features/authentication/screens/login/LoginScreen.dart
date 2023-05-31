import 'package:flutter/material.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/authentication/screens/login/widgets/ContinueWith.dart';
import 'package:myapplication/src/features/authentication/screens/login/widgets/ForgotPassword.dart';
import 'package:myapplication/src/features/authentication/screens/login/widgets/Header.dart';
import 'package:myapplication/src/features/authentication/screens/login/widgets/Login.dart';
import 'package:myapplication/src/features/authentication/screens/login/widgets/LoginForm.dart';
import 'package:myapplication/src/features/authentication/screens/login/widgets/SignUp.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  const SignUp()
                ],
              ),
            ),

            // Login Page Bottom Half
            Positioned(
              bottom: 0,
              child: Container(
                  width: width,
                  height: height * 0.5,
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
                      LoginForm(formKey: _formKey),

                      const SizedBox(
                        height: 20,
                      ),
                      //Fogot Password
                      const ForgotPassword(),

                      SizedBox(
                        height: height * 0.05,
                      ),
                      //Login
                      Login(),
                    ],
                  )),
            )
          ]),
        ),
      ),
    );
  }
}

// if (_formKey.currentState!.validate())
//                                       {
//                                         SignUpController.instance
//                                             .registerUser(user)
//                                       }