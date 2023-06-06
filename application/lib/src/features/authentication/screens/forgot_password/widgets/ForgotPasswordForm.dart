import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common_widgets/BSingleLineTextField.dart';
import '../../../controllers/ForgotPasswordController.dart';

class ForgotPasswordForm extends StatelessWidget {
  final GlobalKey formKey;

  ForgotPasswordForm({super.key, required this.formKey});

  final controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Form(
        child: BSingleLineTextField(
      controller: controller.emailController,
      labelText: 'Enter Email',
      obscureText: false,
      unfocusedBorderColor: Colors.grey,
      focusedBorderColor: const Color.fromRGBO(162, 178, 252, 1),
      icon: const Icon(Icons.key),
    ));
  }
}
