import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/Pages/OTP/OTPWidgets.dart';

import '../../src/common_widgets/BackArrowButton.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPage();
}

class _OTPPage extends State<OTPPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 25, vertical: 25),
              alignment: Alignment.centerLeft,
              child: BackArrowButton(context: context),
            ),

            Container(
              padding: const EdgeInsets.all(50),
              alignment: Alignment.topCenter,
              child: Column(children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage(
                              '../lib/Images/Sign_Up_Temp_Image.png'),
                          fit: BoxFit.fitHeight)),
                ),
                const AutoSizeText(
                  'Just Got To Verify you.',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(42, 42, 42, 1)),
                  maxLines: 1,
                  maxFontSize: 75,
                ),
                const SizedBox(height: 10),
                const AutoSizeText(
                  'Enter your phone number. A 6 digit verification code will be sent to you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 16,
                      color: Color.fromRGBO(157, 157, 157, 1)),
                  maxLines: 2,
                ),
              ]),
            ),

            // Phone Number Text Input
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
                alignment: Alignment.topCenter,
                child: const OTPWidgets()),
          ]),
        ),
      ),
    );
  }
}
