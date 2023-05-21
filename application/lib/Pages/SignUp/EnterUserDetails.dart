import 'package:flutter/material.dart';
import 'package:myapplication/Pages/GeneralWidgets/FullWidthTextButton.dart';
import 'package:myapplication/Pages/GeneralWidgets/SingleLineTextFielldWithBorder.dart';

import '../GeneralWidgets/SingleLineTextField.dart';

class EnterUserDetails extends StatelessWidget {
  const EnterUserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final usernameController = TextEditingController();
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
            labelText: 'Enter New Username',
            obscureText: false,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: Color.fromRGBO(162, 178, 252, 1)),
        const SizedBox(height: 25),
        SingleLineTextFieldWithBorder(
            controller: emailController,
            labelText: 'Enter Your Email',
            obscureText: false,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: Color.fromRGBO(162, 178, 252, 1)),
        const SizedBox(height: 25),
        SingleLineTextFieldWithBorder(
            controller: newPasswordController,
            labelText: 'Enter new Password',
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
            function: () {},
            description: 'Continue',
            buttonColor: Color.fromRGBO(162, 178, 252, 1),
            textColor: Colors.white),
      ],
    );
  }
}
