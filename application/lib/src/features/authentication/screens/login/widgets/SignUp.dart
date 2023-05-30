import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/Pages/SignUp/SignUpPage1.dart';
import 'package:myapplication/src/constants/text_strings.dart';
import 'package:myapplication/src/features/authentication/screens/sign_up/SignUpScreen.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const AutoSizeText(
        loginPageText5,
        style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(157, 157, 157, 1)),
        maxLines: 1,
      ),
      TextButton(
          onPressed: () => Get.to(const SignUpScreen()),
          child: const Text(
            loginPageText6,
            style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(32, 121, 255, 1)),
          )),
    ]);
  }
}
