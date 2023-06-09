import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common_widgets/FullWidthTextButton.dart';
import '../../../controllers/ForgotPasswordController.dart';
import '../../../controllers/ValidationController.dart';

class ForgotPasswordForm extends StatefulWidget {
  ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final controller = Get.put(ForgotPasswordController());

  final _formKey = GlobalKey<FormState>();

  final validationController = Get.put(ValidationController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        // Enter Email
        TextFormField(
          textAlign: TextAlign.left,
          controller: controller.emailController,
          decoration: InputDecoration(
              labelText: 'Enter Email',
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: 'Raleway',
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(162, 178, 252, 1))),
              prefixIcon: const Icon(Icons.key)),
          validator: validationController.validateEmail,
        ),

        const SizedBox(height: 25),

        // Send Button
        FullWidthTextButton(
            function: () {
              if (_formKey.currentState!.validate()) {
                ForgotPasswordController.instance.resetPasswordviaEmail();
              }
            },
            description: 'Send',
            buttonColor: const Color.fromRGBO(128, 150, 255, 1),
            textColor: Colors.white),
      ]),
    );
  }
}
