import 'package:flutter/material.dart';
import '../../../../../common_widgets/FWTextButton.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return FWTextButton(
        function: () {},
        description: 'Sign In',
        buttonColor: const Color.fromRGBO(66, 66, 66, 1),
        textColor: Colors.white);
  }
}
