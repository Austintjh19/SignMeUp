import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../src/common_widgets/BSingleLineTextField.dart';
import '../../src/common_widgets/FWTextButton.dart';

class FPPWidget extends StatefulWidget {
  const FPPWidget({super.key});

  @override
  State<FPPWidget> createState() => _EnterEmail();
}

class _EnterEmail extends State<FPPWidget> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text(
                'Password reset link sent. Check registered email for notification. If not present, check spam folder.',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    color: Color.fromRGBO(42, 42, 42, 1)),
                textAlign: TextAlign.center,
              ),
            );
          });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                e.message.toString(),
                style: const TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    color: Color.fromRGBO(42, 42, 42, 1)),
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AutoSizeText(
          'Enter Registered Email to Reset Password.',
          style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 16,
              color: Color.fromRGBO(157, 157, 157, 1)),
          maxLines: 1,
        ),
        const SizedBox(height: 25),
        BSingleLineTextField(
            controller: _emailController,
            labelText: 'Enter Email',
            obscureText: false,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: const Color.fromRGBO(162, 178, 252, 1)),
        const SizedBox(height: 25),
        FWTextButton(
            function: () {
              resetPassword();
              dispose();
            },
            description: 'Reset Password',
            buttonColor: const Color.fromRGBO(128, 150, 255, 1),
            textColor: Colors.white),
      ],
    );
  }
}
