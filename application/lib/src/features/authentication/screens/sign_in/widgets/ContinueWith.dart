import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/constants/image_strings.dart';
import 'package:myapplication/src/constants/text_strings.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';

class ContinueWith extends StatelessWidget {
  const ContinueWith({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // Continue with Google
        ElevatedButton.icon(
          onPressed: () {
            AuthenticationRepository.instance.signInWithGoogle();
          },
          icon: Image.asset(
            googleLogo,
            height: 30,
            width: 30,
          ),
          label: const AutoSizeText(
            loginPageText3,
            style: TextStyle(fontFamily: 'Raleway', color: bodyColor1),
            minFontSize: 10,
            maxFontSize: 16,
            maxLines: 1,
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            minimumSize: const Size.fromHeight(30),
            shadowColor: Colors.black,
            elevation: 20,
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),

        SizedBox(
          height: height * 0.025,
        ),

        // Continue with Facebook
        ElevatedButton.icon(
          onPressed: () {},
          icon: Image.asset(
            facebookLogo,
            height: 30,
            width: 30,
          ),
          label: const AutoSizeText(
            loginPageText4,
            style: TextStyle(fontFamily: 'Raleway', color: bodyColor1),
            minFontSize: 10,
            maxFontSize: 16,
            maxLines: 1,
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            minimumSize: const Size.fromHeight(30),
            shadowColor: Colors.black,
            elevation: 20,
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    );
  }
}
