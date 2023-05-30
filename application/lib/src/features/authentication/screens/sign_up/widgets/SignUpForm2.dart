import 'package:flutter/material.dart';
import 'package:myapplication/src/common_widgets/BTextForm.dart';

class SignUpForm2 extends StatelessWidget {
  final TextEditingController descriptionController;
  const SignUpForm2({super.key, required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    return BTextForm(
        controller: descriptionController,
        labelText: 'Description',
        hintText:
            'Let people know more about you. Enter a short desciption of yourself.',
        unfocusedBorderColor: Colors.grey,
        focusedBorderColor: const Color.fromRGBO(162, 178, 252, 1),
        numLines: 5);
  }
}
