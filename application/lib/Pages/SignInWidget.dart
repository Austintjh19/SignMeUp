import 'package:flutter/material.dart';
import 'package:myapplication/Pages/ForgotPasswordWidget.dart';
import 'package:myapplication/Pages/FullWidthButton.dart';
import 'package:myapplication/Pages/SignInTextFieldWidget.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final usernameController = TextEditingController();
  final paswordController = TextEditingController();

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
        SignInTextField(
          controller: usernameController,
          hintText: 'Username',
          obscureText: false,
          unfocusedBorderColor: Colors.white,
          focusedBorderColor: Colors.grey,
        ),
        SizedBox(
          height: height * 0.025,
        ),
        SignInTextField(
          controller: paswordController,
          hintText: 'Password',
          obscureText: true,
          unfocusedBorderColor: Colors.white,
          focusedBorderColor: Colors.grey,
        ),
        const ForgotPassword(),
        SizedBox(
          height: height * 0.05,
        ),
        const FullWidthButton(
            description: 'Continue',
            buttonColor: Color.fromRGBO(66, 66, 66, 1),
            textColor: Colors.white)
      ]),
    );
  }
}
