import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/constants/image_strings.dart';
import 'package:myapplication/src/features/authentication/screens/otp/widgets/PhoneOTPForm.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_strings.dart';
import '../sign_in/SignInScreen.dart';

class PhoneOTPScreen extends StatelessWidget {
  const PhoneOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Change controller
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            // Return Button
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 25, vertical: 25),
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Get.to(const SignInScreen());
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

            Container(
              padding: const EdgeInsets.all(50),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // OTP Image
                    Image.asset(
                      otpImage,
                      width: width * 0.75,
                    ),
                    const SizedBox(height: 20.0),

                    // Enter Phone Number
                    const AutoSizeText(
                      'Enter Phone Number',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: heading1Color),
                      maxLines: 1,
                    ),

                    const SizedBox(height: 20.0),

                    // Enter Phone Number Description
                    const AutoSizeText(
                      enterPhoneNo,
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          color: heading1Color),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 20.0),

                    const PhoneOTPForm(),
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
