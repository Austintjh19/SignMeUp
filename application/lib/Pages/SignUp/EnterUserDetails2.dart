import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapplication/Pages/Authentication/Authentication.dart';
import 'package:myapplication/Pages/GeneralWidgets/BTextForm.dart';
import 'package:myapplication/Pages/GeneralWidgets/DateTextField.dart';
import 'package:myapplication/Pages/GeneralWidgets/FWTextButton.dart';
import 'package:myapplication/Pages/GeneralWidgets/BSingleLineTextField.dart';
import 'package:myapplication/Pages/Home/HomePage.dart';
import 'package:myapplication/Pages/SignUp/SignUpPage2.dart';
import 'package:myapplication/User/SignInAction.dart';
import 'package:myapplication/Pages/SignIn/SignInPage.dart';
import 'package:myapplication/User/CreateNewUserAction.dart';

import '../GeneralWidgets/NBSingleLineTextField.dart';

class EnterUserDetails2 extends StatefulWidget {
  const EnterUserDetails2({super.key});

  @override
  State<EnterUserDetails2> createState() => _EnterUserDetails2State();
}

class _EnterUserDetails2State extends State<EnterUserDetails2> {
  @override
  Widget build(BuildContext context) {
    final descriptionController = TextEditingController();

    return Column(
      children: [
        BTextForm(
            controller: descriptionController,
            labelText: 'Description',
            hintText:
                'Let people know more about you. Enter a short desciption of yourself.',
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: Color.fromRGBO(162, 178, 252, 1),
            numLines: 5)
      ],
    );
  }
}
