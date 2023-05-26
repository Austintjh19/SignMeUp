import 'package:flutter/material.dart';
import 'package:myapplication/Pages/GeneralWidgets/FWTextButton.dart';
import 'package:myapplication/Pages/GeneralWidgets/BSingleLineTextField.dart';
import 'package:myapplication/Pages/SignUp/SignUpPage2.dart';
import '../../Verfication/Verification.dart';

class SUPWidgets1 extends StatefulWidget {
  const SUPWidgets1({super.key});

  @override
  State<SUPWidgets1> createState() => _SUPWidgets1State();
}

class _SUPWidgets1State extends State<SUPWidgets1> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final usernameController = TextEditingController();
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
              if (Verification(context).equivalentPassword(
                  newPasswordController.text.trim(),
                  confirmPasswordController.text.trim())) {
                if (Verification(context).appropriatePasswordLength(
                    newPasswordController.text.trim())) {
                  Map<String, dynamic> map = {
                    'Name': nameController.text.trim(),
                    'Username': usernameController.text.trim(),
                    'Email': emailController.text.trim(),
                    'Password': newPasswordController.text.trim(),
                    'Description': '',
                  };
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignUpPage2(map: map)));
                } else {
                  Verification(context)
                      .inapproproatePasswordLenghtNotification();
                }
              } else {
                Verification(context).unequivalentPasswordNotification();
              }
            },
            description: 'Continue',
            buttonColor: Color.fromRGBO(128, 150, 255, 1),
            textColor: Colors.white),
      ],
    );
  }
}
