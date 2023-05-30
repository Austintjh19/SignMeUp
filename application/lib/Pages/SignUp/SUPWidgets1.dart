import 'package:flutter/material.dart';
import 'package:myapplication/src/common_widgets/FWTextButton.dart';
import 'package:myapplication/src/common_widgets/BSingleLineTextField.dart';
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
            focusedBorderColor: const Color.fromRGBO(162, 178, 252, 1),
            icon: const Icon(Icons.person_outline_rounded)),
        const SizedBox(height: 25),
        BSingleLineTextField(
            controller: usernameController,
            labelText: 'Enter Username',
            obscureText: false,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: const Color.fromRGBO(162, 178, 252, 1),
            icon: const Icon(Icons.person_outline_rounded)),
        const SizedBox(height: 25),
        BSingleLineTextField(
            controller: emailController,
            labelText: 'Enter Email',
            obscureText: false,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: const Color.fromRGBO(162, 178, 252, 1),
            icon: const Icon(Icons.email_outlined)),
        const SizedBox(height: 25),
        BSingleLineTextField(
            controller: newPasswordController,
            labelText: 'Enter Password',
            obscureText: true,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: const Color.fromRGBO(162, 178, 252, 1),
            icon: const Icon(Icons.fingerprint)),
        const SizedBox(height: 25),
        BSingleLineTextField(
            controller: confirmPasswordController,
            labelText: 'Confirm Password',
            obscureText: true,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: const Color.fromRGBO(162, 178, 252, 1),
            icon: const Icon(Icons.fingerprint)),
      ],
    );
  }
}
