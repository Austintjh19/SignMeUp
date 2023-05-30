import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/common_widgets/BSingleLineTextField.dart';

import '../../../controllers/SignUpController.dart';

class SignUpForm1 extends StatelessWidget {
  final GlobalKey formKey;

  const SignUpForm1({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Form(
      key: formKey,
      child: Column(children: [
        BSingleLineTextField(
            controller: controller.nameController,
            labelText: 'Enter Your Name',
            obscureText: false,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: const Color.fromRGBO(162, 178, 252, 1),
            icon: const Icon(Icons.person_outline_rounded)),
        const SizedBox(height: 25),
        BSingleLineTextField(
            controller: controller.usernameController,
            labelText: 'Enter Username',
            obscureText: false,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: const Color.fromRGBO(162, 178, 252, 1),
            icon: const Icon(Icons.person_outline_rounded)),
        const SizedBox(height: 25),
        BSingleLineTextField(
            controller: controller.emailController,
            labelText: 'Enter Email',
            obscureText: false,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: const Color.fromRGBO(162, 178, 252, 1),
            icon: const Icon(Icons.email_outlined)),
        const SizedBox(height: 25),
        BSingleLineTextField(
            controller: controller.newPasswordController,
            labelText: 'Enter Password',
            obscureText: true,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: const Color.fromRGBO(162, 178, 252, 1),
            icon: const Icon(Icons.fingerprint)),
        const SizedBox(height: 25),
        BSingleLineTextField(
            controller: controller.confirmPasswordController,
            labelText: 'Confirm Password',
            obscureText: true,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: const Color.fromRGBO(162, 178, 252, 1),
            icon: const Icon(Icons.fingerprint)),
      ]),
    );
  }
}
