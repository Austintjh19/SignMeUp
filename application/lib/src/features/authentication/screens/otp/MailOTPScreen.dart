import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/common_widgets/FullWidthTextButton.dart';
import 'package:myapplication/src/constants/image_strings.dart';
import 'package:myapplication/src/features/authentication/controllers/OTPController.dart';
import 'package:myapplication/src/features/authentication/screens/otp/OTPScreen.dart';
import 'package:myapplication/src/features/authentication/screens/otp/widgets/MailOTPForm.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_strings.dart';
import '../sign_in/SignInScreen.dart';

class MailOTPScreen extends StatelessWidget {
  const MailOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Change controller
    final controller = Get.put(OTPController());
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
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

                      // Enter Email
                      const AutoSizeText(
                        'Enter Email',
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: heading1Color),
                        maxLines: 1,
                      ),

                      const SizedBox(height: 20.0),

                      // Enter Email Description
                      const AutoSizeText(
                        enterEmail,
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 16,
                            color: heading1Color),
                        maxLines: 1,
                      ),

                      const SizedBox(height: 20.0),

                      // Mail OTP Form
                      const MailOTPForm(),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
