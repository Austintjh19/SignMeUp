import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/Pages/SignIn/ForgotPasswordTextWidget.dart';
import 'package:myapplication/Pages/GeneralWidgets/FullWidthTextButton.dart';
import 'package:myapplication/Pages/GeneralWidgets/SingleLineTextField.dart';

class SignInPageBottomHalf extends StatelessWidget {
  SignInPageBottomHalf({super.key});

  final idController = TextEditingController();
  final paswordController = TextEditingController();

  signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: idController.text,
      password: paswordController.text,
    );
  }

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
        SingleLineTextField(
          controller: idController,
          hintText: 'Username',
          obscureText: false,
          unfocusedBorderColor: Colors.white,
          focusedBorderColor: Colors.grey,
        ),
        SizedBox(
          height: height * 0.025,
        ),
        SingleLineTextField(
          controller: paswordController,
          hintText: 'Password',
          obscureText: true,
          unfocusedBorderColor: Colors.white,
          focusedBorderColor: Colors.grey,
        ),
        const ForgotPasswordTextWidget(),
        SizedBox(
          height: height * 0.05,
        ),
        FullWidthTextButton(
            function: signUserIn,
            description: 'Continue',
            buttonColor: Color.fromRGBO(66, 66, 66, 1),
            textColor: Colors.white)
      ]),
    );
  }
}
