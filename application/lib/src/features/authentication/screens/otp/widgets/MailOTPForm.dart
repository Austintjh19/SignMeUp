import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common_widgets/FullWidthTextButton.dart';
import '../../../../../repository/authentication_repository/AuthenticationRepository.dart';
import '../../../controllers/OTPController.dart';
import '../../../../../controllers/ValidationController.dart';
import '../OTPScreen.dart';

class MailOTPForm extends StatefulWidget {
  const MailOTPForm({super.key});

  @override
  State<MailOTPForm> createState() => _MailOTPFormState();
}

class _MailOTPFormState extends State<MailOTPForm> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(OTPController());
  final validationController = Get.put(ValidationController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        // Enter Email
        TextFormField(
          textAlign: TextAlign.left,
          controller: controller.email,
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
              prefixIcon: const Icon(Icons.key)),
          validator: validationController.validateEmail,
        ),

        const SizedBox(height: 20.0),

        // Next Button
        FullWidthTextButton(
          description: 'Next',
          buttonColor: const Color.fromRGBO(128, 150, 255, 1),
          textColor: Colors.white,
          function: () {
            if (_formKey.currentState!.validate()) {
              AuthenticationRepository.instance.verifyViaEmailOTP = true;
              OTPController.instance.emailAuthentication();
              Get.to(() => const OTPScreen());
            }
          },
        ),
      ]),
    );
  }
}
