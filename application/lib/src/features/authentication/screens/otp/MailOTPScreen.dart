import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/src/constants/image_strings.dart';
import 'package:myapplication/src/features/authentication/screens/otp/widgets/MailOTPForm.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_strings.dart';

class MailOTPScreen extends StatelessWidget {
  const MailOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Change controller
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
