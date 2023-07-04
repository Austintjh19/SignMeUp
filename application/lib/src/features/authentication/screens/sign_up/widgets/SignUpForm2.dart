import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/constants/colors.dart';

import '../../../controllers/SignUpController.dart';

class SignUpForm2 extends StatefulWidget {
  const SignUpForm2({super.key});

  @override
  State<SignUpForm2> createState() => _SignUpForm2State();
}

class _SignUpForm2State extends State<SignUpForm2> {
  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpController());

    return Form(
        child: TextFormField(
      textAlign: TextAlign.left,
      controller: signUpController.description,
      minLines: 5,
      maxLines: 5,
      decoration: InputDecoration(
        labelText: 'Enter your Bio',
        hintText:
            'Let people know more about you. Enter a short desciption of yourself.',
        labelStyle: const TextStyle(
          color: textColor500,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor500)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor200)),
      ),
    ));
  }
}
