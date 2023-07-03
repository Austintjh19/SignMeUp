import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/constants/text_strings.dart';
import 'package:myapplication/src/features/authentication/screens/otp/MailOTPScreen.dart';

import '../../../../../constants/colors.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const AutoSizeText(
        loginPageText5,
        style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(157, 157, 157, 1)),
        maxLines: 1,
      ),
      TextButton(
          onPressed: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              context: context,
              builder: (context) => Container(
                padding: const EdgeInsets.all(50),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Select
                      const AutoSizeText(
                        selectOTPTittle,
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: heading1Color),
                        maxLines: 1,
                      ),

                      const SizedBox(height: 10),

                      // Select OTP Description
                      const AutoSizeText(
                        selectOTPTSUbTittle,
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 16,
                            color: heading1Color),
                        maxLines: 1,
                      ),

                      const SizedBox(height: 30),

                      // Email Button
                      GestureDetector(
                        onTap: () => Get.to(const MailOTPScreen(),
                            transition: Transition.leftToRight),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey.shade200),
                          child: const Row(children: [
                            // Email Icon
                            Icon(Icons.mail_outline_rounded, size: 50.0),

                            SizedBox(width: 10),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Email
                                AutoSizeText(
                                  'Email',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: heading1Color),
                                  maxLines: 1,
                                ),

                                SizedBox(height: 3),

                                // Select Email
                                AutoSizeText(
                                  selectOTPTEmail,
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 14,
                                      color: heading1Color),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Phone Button
                      GestureDetector(
                        onTap: () => Get.snackbar("Unavailable",
                            "Feature is currently under modification",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.redAccent.withOpacity(0.1),
                            colorText: Colors.red),
                        // onTap: () => Get.to(const PhoneOTPScreen(), transition: Transition.leftToRight),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey.shade200),
                          child: const Row(children: [
                            // Email Icon
                            Icon(Icons.mobile_friendly_rounded, size: 50.0),

                            SizedBox(width: 10),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Phone
                                AutoSizeText(
                                  'Phone',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: heading1Color),
                                  maxLines: 1,
                                ),

                                SizedBox(height: 3),

                                // Select Phone
                                AutoSizeText(
                                  selectOTPThone,
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 14,
                                      color: heading1Color),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ]),
              ),
            );
          },
          child: const Text(
            loginPageText6,
            style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(32, 121, 255, 1)),
          )),
    ]);
  }
}

//() => Get.to(const SignUpScreen())
