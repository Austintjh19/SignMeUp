import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:myapplication/src/constants/image_strings.dart';
import 'package:myapplication/src/common_widgets/ProfileImage.dart';
import 'package:myapplication/src/features/authentication/controllers/SignUpController.dart';
import 'package:myapplication/src/features/authentication/models/UserModel.dart';
import 'package:myapplication/src/features/authentication/screens/sign_up/widgets/SignUpForm1.dart';
import 'package:myapplication/src/features/authentication/screens/sign_up/widgets/SignUpForm2.dart';
import 'package:myapplication/src/common_widgets/FWTextButton.dart';
import 'package:myapplication/src/features/home/HomePage.dart';

import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool onForm1 = true;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Return Button
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 25, vertical: 25),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      onForm1
                          ? Navigator.pop(context)
                          : setState(() => onForm1 = true);
                    },
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.all(0),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                  ),
                ),

                // Header 1
                Container(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
                  child: Column(
                    children: [
                      AutoSizeText(
                        onForm1 ? 'Hello There.' : 'Almost Done',
                        style: const TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(42, 42, 42, 1)),
                        maxLines: 1,
                        maxFontSize: 75,
                      ),

                      // Header 2
                      AutoSizeText(
                        onForm1
                            ? 'Let\'s get started. Just fill in a few details.'
                            : 'Just add a Profile Image & Description about you.',
                        style: const TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 14,
                            color: Color.fromRGBO(157, 157, 157, 1)),
                        maxLines: 1,
                      ),

                      const SizedBox(height: 50),

                      // Sign Up Screen Image / Profile Image
                      onForm1
                          ? Container(
                              height: 200,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: ExactAssetImage(tempSignUpImage),
                                      fit: BoxFit.fitHeight)),
                            )
                          : const ProfileImage(),

                      const SizedBox(height: 50),

                      // Sign Up Form 1 / Sign Up Form 2
                      onForm1
                          ? SignUpForm1(
                              formKey: _formKey,
                            )
                          : SignUpForm2(
                              formKey: _formKey,
                            ),

                      const SizedBox(height: 40),

                      // Continue/ Create Account Button
                      FWTextButton(
                          function: () {
                            final user = UserModel(
                                username:
                                    controller.usernameController.text.trim(),
                                name: controller.nameController.text.trim(),
                                email: controller.emailController.text.trim(),
                                password: controller.newPasswordController.text
                                    .trim(),
                                description: controller
                                    .descriptionController.text
                                    .trim());
                            onForm1
                                ? setState(() => onForm1 = false)
                                : // Perform input handling
                                {
                                    if (_formKey.currentState!.validate())
                                      {
                                        SignUpController.instance
                                            .registerUser(user)
                                      }
                                  };
                          },
                          description: onForm1 ? 'Continue' : 'Create Account',
                          buttonColor: const Color.fromRGBO(128, 150, 255, 1),
                          textColor: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
