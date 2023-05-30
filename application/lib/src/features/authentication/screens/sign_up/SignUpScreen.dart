import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:myapplication/src/constants/image_strings.dart';
import 'package:myapplication/src/common_widgets/ProfileImage.dart';
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
    final nameController = TextEditingController();
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final descriptionController = TextEditingController();

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
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    children: [
                      AutoSizeText(
                        onForm1 ? 'Hello There.' : 'Almost Done',
                        style: const TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 50,
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
                            fontSize: 16,
                            color: Color.fromRGBO(157, 157, 157, 1)),
                        maxLines: 1,
                      ),

                      const SizedBox(height: 25),

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

                      // Sign Up Form 1 / Sign Up Form 2
                      onForm1
                          ? SignUpForm1(
                              nameController: nameController,
                              emailController: emailController,
                              usernameController: usernameController,
                              newPasswordController: newPasswordController,
                              confirmPasswordController:
                                  confirmPasswordController,
                            )
                          : SignUpForm2(
                              descriptionController: descriptionController,
                            ),

                      // Continuer/ Create Account Button
                      FWTextButton(
                          function: () {
                            onForm1
                                ? setState(() => onForm1 = false)
                                : Get.to(const HomePage());
                          },
                          description: onForm1 ? 'Continue' : 'Creater Account',
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

                          // Map<String, dynamic> map = {
                          //   'Name': nameController.text.trim(),
                          //   'Username': usernameController.text.trim(),
                          //   'Email': emailController.text.trim(),
                          //   'Password': newPasswordController.text.trim(),
                          //   'Description': '',
                          // };
