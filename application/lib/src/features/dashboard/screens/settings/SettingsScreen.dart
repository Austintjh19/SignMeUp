import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/common_widgets/FullWidthTextButton.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/dashboard/screens/settings/widgets/ChangePasswordButton.dart';
import 'package:myapplication/src/features/dashboard/screens/settings/widgets/DeleteAccountButton.dart';
import 'package:myapplication/src/features/dashboard/screens/settings/widgets/SignOutButton.dart';
import 'package:myapplication/src/models/UserModel.dart';
import 'package:myapplication/src/features/dashboard/screens/update_profile/UpdateProfileScreen.dart';

import '../../../../constants/image_strings.dart';
import '../../controllers/CurrentUserController.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserController = Get.put(CurrentUserController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined,
                color: Colors.black, size: 25)),
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: heading1Color),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // Profile Image ---------------------------------------------------
            FutureBuilder(
                future: currentUserController.getProfileImage(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      String imageUrl = snapshot.data as String;
                      return imageUrl != ""
                          ? CircleAvatar(
                              radius: 125,
                              backgroundImage: NetworkImage(imageUrl))
                          : const CircleAvatar(
                              radius: 125,
                              backgroundImage:
                                  ExactAssetImage(defaultProfileImage),
                            );
                    }
                  }
                  return Container();
                }),

            const SizedBox(height: 20),

            // Username & Email ------------------------------------------------
            FutureBuilder(
                future: currentUserController.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userData.username,
                              style: const TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: heading1Color),
                            ),
                            Text(
                              userData.email,
                              style: const TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: heading1Color),
                            ),
                          ]);
                    }
                  }
                  return const Text('');
                }),

            const SizedBox(height: 20),

            // Edit Profile Button ---------------------------------------------
            FullWidthTextButton(
                description: 'Edit Profile',
                buttonColor: const Color.fromRGBO(119, 143, 253, 1),
                textColor: Colors.white,
                function: () {
                  Get.to(const UpdateProfileScreen(),
                      transition: Transition.rightToLeft);
                }),

            const SizedBox(height: 10),

            const Divider(),

            const SizedBox(height: 25),

            // Change Password -------------------------------------------------
            const ChangePasswordButton(),

            // Delete Account --------------------------------------------------
            const DeleteAccountButton(),

            // Sign Out --------------------------------------------------------
            const SignOutButton(),
          ]),
        ),
      ),
    );
  }
}
