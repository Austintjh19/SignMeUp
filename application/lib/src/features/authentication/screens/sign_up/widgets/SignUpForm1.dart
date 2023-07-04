import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/SignUpController.dart';
import '../../../../../controllers/ValidationController.dart';

class SignUpForm1 extends StatefulWidget {
  final GlobalKey signUpFormKey;

  const SignUpForm1({super.key, required this.signUpFormKey});

  @override
  State<SignUpForm1> createState() => _SignUpForm1State();
}

class _SignUpForm1State extends State<SignUpForm1> {
  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpController());
    final validationController = Get.put(ValidationController());

    return Form(
      key: widget.signUpFormKey,
      child: Column(children: [
        // Enter Name
        TextFormField(
          textAlign: TextAlign.left,
          controller: signUpController.name,
          decoration: InputDecoration(
              labelText: 'Enter Your Name',
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: 'Raleway',
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(162, 178, 252, 1))),
              prefixIcon: const Icon(Icons.person_outline_rounded)),
          validator: validationController.validateName,
        ),

        const SizedBox(height: 25),

        // Enter Username
        TextFormField(
          textAlign: TextAlign.left,
          controller: signUpController.username,
          decoration: InputDecoration(
              labelText: 'Enter Username',
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: 'Raleway',
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(162, 178, 252, 1))),
              prefixIcon: const Icon(Icons.person_outline_rounded)),
          validator: validationController.validateUsername,
        ),

        const SizedBox(height: 25),

        // Enter Email
        TextFormField(
          textAlign: TextAlign.left,
          controller: signUpController.email,
          decoration: InputDecoration(
              labelText: 'Enter Email',
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: 'Raleway',
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(162, 178, 252, 1))),
              prefixIcon: const Icon(Icons.email_outlined)),
          validator: validationController.validateEmail,
        ),

        const SizedBox(height: 25),

        // Enter Password
        TextFormField(
          obscureText: true,
          textAlign: TextAlign.left,
          controller: signUpController.newPassword,
          decoration: InputDecoration(
              labelText: 'Enter Password',
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: 'Raleway',
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(162, 178, 252, 1))),
              prefixIcon: const Icon(Icons.fingerprint)),
          validator: validationController.validateSignUpPassword,
        ),

        const SizedBox(height: 25),

        // Confirm Password
        TextFormField(
          obscureText: true,
          textAlign: TextAlign.left,
          controller: signUpController.confirmPassword,
          decoration: InputDecoration(
              labelText: 'Confirm Password',
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: 'Raleway',
                fontSize: 16,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(162, 178, 252, 1))),
              prefixIcon: const Icon(Icons.fingerprint)),
          validator: (value) {
            if (signUpController.newPassword.text.trim() !=
                signUpController.confirmPassword.text.trim()) {
              return "Passwords do not match";
            } else {
              return null;
            }
          },
        )
      ]),
    );
  }
}
