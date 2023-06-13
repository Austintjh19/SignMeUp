import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myapplication/src/features/dashboard/screens/settings/SettingsScreen.dart';
import 'package:myapplication/src/features/dashboard/screens/update_profile/widgets/UpdateProfileForm.dart';

import '../../../../constants/colors.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.to(() => const SettingsScreen());
              },
              icon: const Icon(Icons.arrow_back_outlined,
                  color: Colors.black, size: 25)),
          centerTitle: true,
          title: const Text(
            "Profile",
            style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                color: heading1Color),
          ),
        ),
        body: const UpdatProfileForm());
  }
}
