import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../GeneralWidgets/BSingleLineTextField.dart';
import '../GeneralWidgets/FWTextButton.dart';

class EnterEmail extends StatefulWidget {
  const EnterEmail({super.key});

  @override
  State<EnterEmail> createState() => _EnterEmail();
}

class _EnterEmail extends State<EnterEmail> {
  final _emailController = TextEditingController();

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
            obscureText: true,
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: Color.fromRGBO(162, 178, 252, 1)),
        const SizedBox(height: 25),
        FWTextButton(
            function: () {},
            description: 'Reset Password',
            buttonColor: Color.fromRGBO(128, 150, 255, 1),
            textColor: Colors.white),
      ],
    );
  }
}
