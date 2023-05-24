import 'package:flutter/material.dart';
import 'package:myapplication/Pages/Authentication/Authentication.dart';
import 'package:myapplication/Pages/GeneralWidgets/BTextForm.dart';
import 'package:myapplication/Pages/GeneralWidgets/FWTextButton.dart';
import 'package:myapplication/User/ProfileImage.dart';
import '../../User/AppUser.dart';

class EnterUserDetails2 extends StatefulWidget {
  final Map<String, dynamic> map;
  const EnterUserDetails2({super.key, required this.map});

  @override
  State<EnterUserDetails2> createState() => _EnterUserDetails2State();
}

class _EnterUserDetails2State extends State<EnterUserDetails2> {
  @override
  Widget build(BuildContext context) {
    final descriptionController = TextEditingController();

    return Column(
      children: [
        ProfileImage(),
        const SizedBox(height: 25),
        BTextForm(
            controller: descriptionController,
            labelText: 'Description',
            hintText:
                'Let people know more about you. Enter a short desciption of yourself.',
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: Color.fromRGBO(162, 178, 252, 1),
            numLines: 5),
        const SizedBox(height: 25),
        FWTextButton(
            function: () {
              widget.map
                  .update('Description', (value) => descriptionController.text);
              if (AppUser.signUp(context).createNewUser(widget.map)) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Authentication()));
              }
            },
            description: 'Create Account',
            buttonColor: Color.fromRGBO(128, 150, 255, 1),
            textColor: Colors.white),
      ],
    );
  }
}
