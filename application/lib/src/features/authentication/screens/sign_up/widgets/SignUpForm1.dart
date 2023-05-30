import 'package:flutter/material.dart';
import 'package:myapplication/src/common_widgets/BSingleLineTextField.dart';

class SignUpForm1 extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  const SignUpForm1(
      {super.key,
      required this.nameController,
      required this.usernameController,
      required this.emailController,
      required this.newPasswordController,
      required this.confirmPasswordController});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
    ]);
  }
}
