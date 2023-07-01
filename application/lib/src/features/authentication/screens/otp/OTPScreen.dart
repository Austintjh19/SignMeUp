import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:myapplication/src/constants/text_strings.dart';
import 'package:myapplication/src/features/authentication/controllers/OTPController.dart';
import 'package:myapplication/src/features/authentication/screens/sign_in/SignInScreen.dart';

import '../../../../common_widgets/FullWidthTextButton.dart';
import '../../../../constants/colors.dart';

class OTPScreen extends StatelessWidget {
  final String phoneNumVerificationID;
  const OTPScreen({super.key, required this.phoneNumVerificationID});

  @override
  Widget build(BuildContext context) {
    var otp;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.to(const SignInScreen(),
                    transition: Transition.rightToLeft);
              },
              icon: const Icon(Icons.arrow_back_outlined,
                  color: Colors.black, size: 25)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // CODE
                      Text(tOTPtittle,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 100,
                          )),

                      const SizedBox(
                        height: 30,
                      ),

                      // Verification
                      const AutoSizeText(
                        tOTPSubTittle,
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 30,
                            color: heading1Color),
                        maxLines: 1,
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // Message sent to ...
                      const AutoSizeText(
                        "$tOTPMessage support@gmail.com",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 16,
                            color: heading1Color),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      //OTP Text Field
                      OtpTextField(
                        numberOfFields: 6,
                        fillColor: Colors.black.withOpacity(0.1),
                        filled: true,
                        keyboardType: TextInputType.number,
                        onSubmit: (code) {
                          otp = code;
                        },
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      FullWidthTextButton(
                        description: 'Enter',
                        buttonColor: const Color.fromRGBO(128, 150, 255, 1),
                        textColor: Colors.white,
                        function: () {
                          OTPController.instance
                              .verifyOTP(otp, phoneNumVerificationID);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
