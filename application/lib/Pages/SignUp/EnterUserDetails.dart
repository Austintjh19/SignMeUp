import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapplication/Pages/GeneralWidgets/DateTextField.dart';
import 'package:myapplication/Pages/GeneralWidgets/FullWidthTextButton.dart';
import 'package:myapplication/Pages/GeneralWidgets/SingleLineTextFielldWithBorder.dart';
import 'package:myapplication/Pages/Home/HomePage.dart';
import 'package:myapplication/Pages/SignIn/SignInPage.dart';
import 'package:myapplication/Pages/SignUp/CreateNewUserAction.dart';

import '../GeneralWidgets/SingleLineTextField.dart';

class EnterUserDetails extends StatefulWidget {
  const EnterUserDetails({super.key});

  @override
  State<EnterUserDetails> createState() => _EnterUserDetailsState();
}

class _EnterUserDetailsState extends State<EnterUserDetails> {
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
        SingleLineTextFieldWithBorder(
            controller: nameController,
            labelText: 'Enter Your Name',
            obscureText: false,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: Color.fromRGBO(162, 178, 252, 1)),
        const SizedBox(height: 25),
        SingleLineTextFieldWithBorder(
            controller: usernameController,
            labelText: 'Enter Username',
            obscureText: false,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: Color.fromRGBO(162, 178, 252, 1)),
        const SizedBox(height: 25),
        SingleLineTextFieldWithBorder(
            controller: emailController,
            labelText: 'Enter Email',
            obscureText: false,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: Color.fromRGBO(162, 178, 252, 1)),
        const SizedBox(height: 25),
        SingleLineTextFieldWithBorder(
            controller: newPasswordController,
            labelText: 'Enter Password',
            obscureText: true,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: Color.fromRGBO(162, 178, 252, 1)),
        const SizedBox(height: 25),
        SingleLineTextFieldWithBorder(
            controller: confirmPasswordController,
            labelText: 'Confirm Password',
            obscureText: true,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: Color.fromRGBO(162, 178, 252, 1)),
        const SizedBox(height: 25),
        FullWidthTextButton(
            function: () {
              CreateNewUserAction(
                      emailController.text.trim(),
                      newPasswordController.text.trim(),
                      confirmPasswordController.text.trim(),
                      context,
                      nameController.text.trim(),
                      usernameController.text.trim())
                  .createNewUser();
            },
            description: 'Continue',
            buttonColor: Color.fromRGBO(128, 150, 255, 1),
            textColor: Colors.white),
      ],
    );
  }
}
