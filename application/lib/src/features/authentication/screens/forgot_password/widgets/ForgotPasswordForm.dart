import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/common_widgets/StandardIconTextForm.dart';
import 'package:myapplication/src/constants/colors.dart';

import '../../../../../common_widgets/FullWidthTextButton.dart';
import '../../../controllers/ForgotPasswordController.dart';
import '../../../../../controllers/ValidationController.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

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
        StandardIconTextForm(
            controller: controller.email,
            labelText: 'Enter Email',
            icon: const Icon(Icons.key),
            validator: validationController.validateEmail),

        const SizedBox(height: 25),

        // Send Button
        FullWidthTextButton(
            function: () {
              if (_formKey.currentState!.validate()) {
                ForgotPasswordController.instance.resetPasswordviaEmail();
              }
            },
            description: 'Send',
            buttonColor: primaryColor300,
            textColor: textColor100),
      ]),
    );
  }
}
