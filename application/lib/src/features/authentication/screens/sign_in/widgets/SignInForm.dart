import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myapplication/src/features/authentication/controllers/ValidationController.dart';

import '../../../../../common_widgets/FWTextButton.dart';
import '../../../../../common_widgets/NBSingleLineTextField.dart';
import '../../../controllers/SignInController.dart';
import 'ForgotPasswordButton.dart';

class SignInForm extends StatelessWidget {
  SignInForm({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final controller = Get.put(SignInController());
    final validationController = Get.put(ValidationController());

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  labelText: 'Enter Email',
                  labelStyle: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16,
                  )),
              validator: validationController.validateEmail,
            ),

            SizedBox(
              height: height * 0.025,
            ),

            TextFormField(
              controller: controller.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  labelText: 'Enter Password',
                  labelStyle: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16,
                  )),
              validator: validationController.validatePassword,
            ),

            const SizedBox(
              height: 20,
            ),
            //Fogot Password
            const ForgotPasswordButton(),

            SizedBox(
              height: height * 0.05,
            ),

            //Sign In
            FWTextButton(
                function: () {
                  if (_formKey.currentState!.validate()) {
                    SignInController.instance.signInUserViaEmailAndPassword();
                  }
                },
                description: 'Sign In',
                buttonColor: const Color.fromRGBO(66, 66, 66, 1),
                textColor: Colors.white)
          ],
        ),
      ),
    );
  }
}
