import 'package:flutter/material.dart';
import 'package:myapplication/Pages/SignIn/ForgotPasswordText.dart';
import 'package:myapplication/src/common_widgets/FWTextButton.dart';
import 'package:myapplication/src/common_widgets/NBSingleLineTextField.dart';
import 'package:myapplication/User/AppUser.dart';

class SIPBottomWidgets extends StatefulWidget {
  const SIPBottomWidgets({super.key});

  @override
  State<SIPBottomWidgets> createState() => _SIPBottomWidgetsState();
}

class _SIPBottomWidgetsState extends State<SIPBottomWidgets> {
  final SIPBottomWidgetsKey = GlobalKey();

  // Text Editing Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height * 0.5,
      padding: const EdgeInsets.all(50),
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            Color.fromRGBO(119, 143, 253, 1),
            Color.fromRGBO(252, 236, 175, 1)
          ],
        ),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(children: [
        // Enter Username/ Email Text Field
        NBSingleLineTextField(
          controller: emailController,
          labelText: 'Username/ Email',
          obscureText: false,
          unfocusedBorderColor: Colors.white,
          focusedBorderColor: Colors.grey,
        ),

        SizedBox(
          height: height * 0.025,
        ),

        // Enter Password Text Field
        NBSingleLineTextField(
          controller: passwordController,
          labelText: 'Password',
          obscureText: true,
          unfocusedBorderColor: Colors.white,
          focusedBorderColor: Colors.grey,
        ),

        // Forgot Password Button
        const ForgotPasswordText(),

        SizedBox(
          height: height * 0.05,
        ),

        // Sign In Button
        FWTextButton(
            function: () {
              AppUser.signIn(emailController.text.trim(),
                      passwordController.text.trim(), context)
                  .signUserIn();
            },
            description: 'Continue',
            buttonColor: const Color.fromRGBO(66, 66, 66, 1),
            textColor: Colors.white),
      ]),
    );
  }
}
