import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:myapplication/src/constants/text_strings.dart';
import 'package:myapplication/src/features/authentication/controllers/OTPController.dart';

import '../../../../common_widgets/FWTextButton.dart';
import '../../../../constants/colors.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var otp;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 25, vertical: 25),
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
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

                  FWTextButton(
                    description: 'Enter',
                    buttonColor: const Color.fromRGBO(128, 150, 255, 1),
                    textColor: Colors.white,
                    function: () {
                      OTPController.instance.verifyOTP(otp);
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
