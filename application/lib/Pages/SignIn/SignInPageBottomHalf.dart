import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/Pages/SignIn/ForgotPasswordTextWidget.dart';
import 'package:myapplication/Pages/GeneralWidgets/FullWidthTextButton.dart';
import 'package:myapplication/Pages/GeneralWidgets/SingleLineTextField.dart';
import 'package:myapplication/Pages/SignIn/SignInAction.dart';

class SignInPageBottomHalf extends StatefulWidget {
  SignInPageBottomHalf({super.key});

  @override
  State<SignInPageBottomHalf> createState() => _SignInPageBottomHalfState();
}

class _SignInPageBottomHalfState extends State<SignInPageBottomHalf> {
  // Text Editing Controller
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      padding: EdgeInsets.all(50),
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color.fromRGBO(162, 178, 252, 1),
            Color.fromRGBO(252, 236, 175, 1)
          ],
        ),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(children: [
        // Enter Username/ Email Text Field
        SingleLineTextField(
          controller: idController,
          labelText: 'Username/ Email',
          obscureText: false,
          unfocusedBorderColor: Colors.white,
          focusedBorderColor: Colors.grey,
        ),

        SizedBox(
          height: height * 0.025,
        ),

        // Enter Password Text Field
        SingleLineTextField(
          controller: passwordController,
          labelText: 'Password',
          obscureText: true,
          unfocusedBorderColor: Colors.white,
          focusedBorderColor: Colors.grey,
        ),

        // Forgot Password Button
        const ForgotPasswordTextWidget(),

        SizedBox(
          height: height * 0.05,
        ),

        // Sign In Button
        FullWidthTextButton(
            function: () {
              SignInAction(idController.text, passwordController.text, context)
                  .signUserIn();
            },
            description: 'Continue',
            buttonColor: Color.fromRGBO(66, 66, 66, 1),
            textColor: Colors.white),
      ]),
    );
  }
}
