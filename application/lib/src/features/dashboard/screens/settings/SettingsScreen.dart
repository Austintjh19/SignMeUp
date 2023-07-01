import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myapplication/src/common_widgets/FullWidthTextButton.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/models/UserModel.dart';
import 'package:myapplication/src/features/dashboard/Dashboard.dart';
import 'package:myapplication/src/features/dashboard/screens/update_profile/UpdateProfileScreen.dart';

import '../../../../constants/image_strings.dart';
import '../../../../repository/authentication_repository/AuthenticationRepository.dart';
import '../../controllers/CurrentUserController.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CurrentUserController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
              // Get.offAll(Dashboard(
              //   initialPageIndex: -1,
              // ));
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
            // Profile Image
            FutureBuilder(
                future: controller.getProfileImage(),
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
                  return const CircleAvatar(
                    radius: 125,
                    backgroundImage: ExactAssetImage(defaultProfileImage),
                  );
                }),

            const SizedBox(height: 20),

            // Username & Email
            FutureBuilder(
                future: controller.getUserData(),
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
                  return const LinearProgressIndicator();
                }),

            const SizedBox(height: 20),

            // Edit Profile Button
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

            // Change Email
            ListTile(
              onTap: () {},
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromRGBO(119, 143, 253, 1)
                        .withOpacity(0.1)),
                child: const Icon(
                  Icons.email_outlined,
                  color: Color.fromRGBO(119, 143, 253, 1),
                ),
              ),
              title: const Text(
                'Change Email',
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
                    color: const Color.fromARGB(255, 124, 124, 124)
                        .withOpacity(0.1)),
                child: const Icon(
                  LineAwesomeIcons.angle_right,
                  size: 18,
                  color: Color.fromARGB(255, 124, 124, 124),
                ),
              ),
            ),

            // Change Password
            ListTile(
              onTap: () {},
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromRGBO(119, 143, 253, 1)
                        .withOpacity(0.1)),
                child: const Icon(
                  Icons.lock_outline,
                  color: Color.fromRGBO(119, 143, 253, 1),
                ),
              ),
              title: const Text(
                'Change Password',
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
                    color: const Color.fromARGB(255, 124, 124, 124)
                        .withOpacity(0.1)),
                child: const Icon(
                  LineAwesomeIcons.angle_right,
                  size: 18,
                  color: Color.fromARGB(255, 124, 124, 124),
                ),
              ),
            ),

            // Sign Out
            ListTile(
              onTap: () {
                AuthenticationRepository.instance.signOutUser();
              },
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromRGBO(119, 143, 253, 1)
                        .withOpacity(0.1)),
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
                    color: const Color.fromARGB(255, 124, 124, 124)
                        .withOpacity(0.1)),
                child: const Icon(
                  LineAwesomeIcons.angle_right,
                  size: 18,
                  color: Color.fromARGB(255, 124, 124, 124),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
