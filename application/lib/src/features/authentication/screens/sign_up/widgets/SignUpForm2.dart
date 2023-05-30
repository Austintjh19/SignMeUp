import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/common_widgets/BTextForm.dart';

import '../../../controllers/SignUpController.dart';

class SignUpForm2 extends StatelessWidget {
  final GlobalKey formKey;
  const SignUpForm2({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Form(
        key: formKey,
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
