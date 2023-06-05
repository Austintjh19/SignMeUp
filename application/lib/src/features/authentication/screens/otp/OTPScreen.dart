import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/src/constants/text_strings.dart';

import '../../../../constants/colors.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(50),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CODE
            AutoSizeText(
              tOTPtittle,
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: heading1Color),
              maxLines: 1,
              maxFontSize: 75,
            ),

            // Verification
            AutoSizeText(
              tOTPSubTittle,
              style: TextStyle(
                  fontFamily: 'Raleway', fontSize: 25, color: heading2Color),
              maxLines: 1,
            ),

            // Message sent to ...
            AutoSizeText(
              tOTPMessage,
              style: TextStyle(
                  fontFamily: 'Raleway', fontSize: 16, color: heading2Color),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
