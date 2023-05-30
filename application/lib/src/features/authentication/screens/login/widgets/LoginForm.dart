import 'package:flutter/material.dart';

import '../../../../../common_widgets/NBSingleLineTextField.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        NBSingleLineTextField(
          controller: emailController,
          labelText: 'Email',
          obscureText: false,
          unfocusedBorderColor: Colors.white,
          focusedBorderColor: Colors.grey,
        ),

        SizedBox(
          height: height * 0.025,
        ),

        // Enter Password Text Field
        NBSingleLineTextField(
          controller: passwordController,
          labelText: 'Password',
          obscureText: true,
          unfocusedBorderColor: Colors.white,
          focusedBorderColor: Colors.grey,
        ),
      ],
    );
  }
}
