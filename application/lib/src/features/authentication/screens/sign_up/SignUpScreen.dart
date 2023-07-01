import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:myapplication/src/constants/image_strings.dart';
import 'package:myapplication/src/features/authentication/screens/sign_up/widgets/ProfileImage.dart';
import 'package:myapplication/src/features/authentication/controllers/SignUpController.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/SignInScreen.dart';
import 'package:myapplication/src/features/authentication/screens/sign_up/widgets/SignUpForm1.dart';
import 'package:myapplication/src/features/authentication/screens/sign_up/widgets/SignUpForm2.dart';
import 'package:myapplication/src/common_widgets/FullWidthTextButton.dart';

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
    final formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                onForm1
                    ? Get.to(
                        const SignInScreen(),
                      )
                    : setState(() => onForm1 = true);
              },
              icon: const Icon(Icons.arrow_back_outlined,
                  color: Colors.black, size: 25)),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // // Return Button
                // Container(
                //   padding: const EdgeInsetsDirectional.symmetric(
                //       horizontal: 25, vertical: 25),
                //   alignment: Alignment.centerLeft,
                //   child: GestureDetector(
                //     onTap: () {
                //       onForm1
                //           ? Get.to(const SignInScreen())
                //           : setState(() => onForm1 = true);
                //     },
                //     child: Container(
                //       height: 30,
                //       padding: const EdgeInsets.all(0),
                //       child: const Icon(
                //         Icons.arrow_back,
                //         size: 30,
                //       ),
                //     ),
                //   ),
                // ),

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

                      const SizedBox(height: 30),

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

                      const SizedBox(height: 30),

                      // Sign Up Form 1 / Sign Up Form 2
                      onForm1
                          ? SignUpForm1(
                              signUpFormKey: formKey,
                            )
                          : const SignUpForm2(),

                      const SizedBox(height: 25),

                      // Continue/ Create Account Button
                      FullWidthTextButton(
                          function: () {
                            if (onForm1) {
                              if (formKey.currentState!.validate()) {
                                setState(() => onForm1 = false);
                              }
                            } else {
                              SignUpController.instance.registerUser();
                            }
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
