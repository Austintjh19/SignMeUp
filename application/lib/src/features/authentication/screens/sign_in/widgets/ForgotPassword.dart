import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/features/authentication/screens/forgot_password/ForgotPasswordScreen.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () => Get.to(const ForgotPasswordScreen()),
            child: const Text(
              'Forgot Password ?',
              style: TextStyle(
                  fontFamily: 'Raleway', fontSize: 12, color: Colors.white),
            ))
      ],
    );
  }
}
