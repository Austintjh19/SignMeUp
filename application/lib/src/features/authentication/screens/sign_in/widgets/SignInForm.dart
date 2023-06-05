import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common_widgets/NBSingleLineTextField.dart';
import '../../../controllers/SignInController.dart';

class SignInForm extends StatelessWidget {
  final GlobalKey formKey;

  SignInForm({super.key, required this.formKey});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final controller = Get.put(SignInController());

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            NBSingleLineTextField(
              controller: controller.emailController,
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
              controller: controller.passwordController,
              labelText: 'Password',
              obscureText: true,
              unfocusedBorderColor: Colors.white,
              focusedBorderColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
