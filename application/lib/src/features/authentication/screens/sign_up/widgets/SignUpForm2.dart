import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/common_widgets/BTextForm.dart';

import '../../../controllers/SignUpController.dart';

class SignUpForm2 extends StatelessWidget {
  const SignUpForm2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Form(
        child: BTextForm(
            controller: controller.descriptionController,
            labelText: 'Description',
            hintText:
                'Let people know more about you. Enter a short desciption of yourself.',
            unfocusedBorderColor: Colors.grey,
            focusedBorderColor: const Color.fromRGBO(162, 178, 252, 1),
            numLines: 5));
  }
}
