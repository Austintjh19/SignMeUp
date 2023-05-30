import 'package:flutter/material.dart';
import 'package:myapplication/Pages/Authentication/Authentication.dart';
import 'package:myapplication/src/common_widgets/BTextForm.dart';
import 'package:myapplication/src/common_widgets/FWTextButton.dart';
import 'package:myapplication/User/ProfileImage.dart';
import '../../User/AppUser.dart';

class SUPWidgets2 extends StatefulWidget {
  final Map<String, dynamic> map;
  const SUPWidgets2({super.key, required this.map});

  @override
  State<SUPWidgets2> createState() => _SUPWidgets2State();
}

class _SUPWidgets2State extends State<SUPWidgets2> {
  @override
  Widget build(BuildContext context) {
    final descriptionController = TextEditingController();

    return Column(
      children: [
        const ProfileImage(),
        const SizedBox(height: 25),
        BTextForm(
            controller: descriptionController,
            labelText: 'Description',
            hintText:
                'Let people know more about you. Enter a short desciption of yourself.',
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: const Color.fromRGBO(162, 178, 252, 1),
            numLines: 5),
        const SizedBox(height: 25),
        FWTextButton(
            function: () {
              widget.map
                  .update('Description', (value) => descriptionController.text);
              if (AppUser.signUp(context).createNewUser(widget.map)) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Authentication()));
              }
            },
            description: 'Create Account',
            buttonColor: const Color.fromRGBO(128, 150, 255, 1),
            textColor: Colors.white),
      ],
    );
  }
}
