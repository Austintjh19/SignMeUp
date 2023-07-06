import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../../constants/colors.dart';
import '../../../controllers/SettingsController.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.put(SettingsController());

    return ListTile(
      onTap: () {
        settingsController.signOutUser();
      },
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color.fromRGBO(119, 143, 253, 1).withOpacity(0.1)),
        child: const Icon(
          LineAwesomeIcons.alternate_sign_out,
          color: Color.fromRGBO(119, 143, 253, 1),
        ),
      ),
      title: const Text(
        'Sign Out',
        style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: heading1Color),
      ),
      trailing: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color.fromARGB(255, 124, 124, 124).withOpacity(0.1)),
        child: const Icon(
          LineAwesomeIcons.angle_right,
          size: 18,
          color: Color.fromARGB(255, 124, 124, 124),
        ),
      ),
    );
  }
}
