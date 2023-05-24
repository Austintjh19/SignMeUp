import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapplication/Pages/Authentication/Authentication.dart';
import 'package:myapplication/Pages/GeneralWidgets/DateTextField.dart';
import 'package:myapplication/Pages/GeneralWidgets/FWTextButton.dart';
import 'package:myapplication/Pages/GeneralWidgets/BSingleLineTextField.dart';
import 'package:myapplication/Pages/Home/HomePage.dart';
import 'package:myapplication/Pages/SignUp/SignUpPage2.dart';
import 'package:myapplication/User/SignInAction.dart';
import 'package:myapplication/Pages/SignIn/SignInPage.dart';
import 'package:myapplication/User/CreateNewUserAction.dart';

import '../GeneralWidgets/NBSingleLineTextField.dart';

class EnterUserDetails1 extends StatefulWidget {
  const EnterUserDetails1({super.key});

  @override
  State<EnterUserDetails1> createState() => _EnterUserDetails1State();
}

class _EnterUserDetails1State extends State<EnterUserDetails1> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final usernameController = TextEditingController();
    var dobController = TextEditingController();
    final emailController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Column(
      children: [
        BSingleLineTextField(
            controller: nameController,
            labelText: 'Enter Your Name',
            obscureText: false,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: Color.fromRGBO(162, 178, 252, 1)),
        const SizedBox(height: 25),
        BSingleLineTextField(
            controller: usernameController,
            labelText: 'Enter Username',
            obscureText: false,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: Color.fromRGBO(162, 178, 252, 1)),
        const SizedBox(height: 25),
        BSingleLineTextField(
            controller: emailController,
            labelText: 'Enter Email',
            obscureText: false,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: Color.fromRGBO(162, 178, 252, 1)),
        const SizedBox(height: 25),
        BSingleLineTextField(
            controller: newPasswordController,
            labelText: 'Enter Password',
            obscureText: true,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: Color.fromRGBO(162, 178, 252, 1)),
        const SizedBox(height: 25),
        BSingleLineTextField(
            controller: confirmPasswordController,
            labelText: 'Confirm Password',
            obscureText: true,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: Color.fromRGBO(162, 178, 252, 1)),
        const SizedBox(height: 25),
        FWTextButton(
            function: () {
              if (CreateNewUserAction(
                      emailController.text.trim(),
                      newPasswordController.text.trim(),
                      confirmPasswordController.text.trim(),
                      context,
                      nameController.text.trim(),
                      usernameController.text.trim())
                  .createNewUser()) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpPage2()));
              }
            },
            description: 'Continue',
            buttonColor: Color.fromRGBO(128, 150, 255, 1),
            textColor: Colors.white),
      ],
    );
  }
}
