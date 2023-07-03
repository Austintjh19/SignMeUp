import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myapplication/src/common_widgets/FullWidthTextButton.dart';
import 'package:myapplication/src/constants/colors.dart';
import 'package:myapplication/src/features/dashboard/controllers/SettingsController.dart';
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
    final settingsController = Get.put(SettingsController());

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

            // Change Password
            ListTile(
              onTap: () async {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: primaryColor100.withOpacity(0.9),
                        title: const Text(
                          'Confirm Reset Password ?',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: textColor600),
                        ),
                        content: Container(
                            height: 350,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Warning Icon
                                  const Icon(Icons.warning_amber_outlined,
                                      color: Colors.redAccent, size: 150),

                                  const SizedBox(height: 10),

                                  // Reset Password Warning
                                  const Text(
                                    'Are you sure you want to reset your password ? Click the button below to proceed.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10,
                                        color: textColor600),
                                  ),

                                  const SizedBox(height: 30),

                                  // Proceed with resetting Password Button
                                  ElevatedButton(
                                    onPressed: () {
                                      settingsController
                                          .resetPasswordviaEmail();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 0),
                                      minimumSize: const Size.fromHeight(30),
                                      shadowColor: primaryColor700,
                                      elevation: 20,
                                      backgroundColor: primaryColor600,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                    child: const Text(
                                      'Proceed',
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 14,
                                          color: textColor100),
                                    ),
                                  )
                                ])),
                      );
                    });
              },
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

            // Delete Account
            ListTile(
              onTap: () async {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: primaryColor100.withOpacity(0.9),
                        title: const Text(
                          'Delete Account ?',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: textColor600),
                        ),
                        content: Container(
                            height: 400,
                            padding: const EdgeInsets.all(0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Warning Icon
                                  const Icon(Icons.dangerous_outlined,
                                      color: Colors.redAccent, size: 150),

                                  const SizedBox(height: 10),

                                  // Delete Warning
                                  const Text(
                                    'Are you sure you want to delete your account ? All user information will be removed from our system. Enter your password and click Proceed to continue.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10,
                                        color: textColor600),
                                  ),

                                  const SizedBox(height: 30),

                                  TextFormField(
                                    controller: settingsController.password,
                                    obscureText: true,
                                    style: const TextStyle(
                                        color: textColor600,
                                        fontFamily: 'Raleway',
                                        fontSize: 12),
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Password',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: primaryColor400)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: primaryColor400)),
                                        prefixIcon: const Icon(
                                            Icons.password_outlined)),
                                  ),

                                  const SizedBox(height: 40),

                                  // Proceed with Account Deletion Button
                                  ElevatedButton(
                                    onPressed: () {
                                      settingsController.deleteUserAccount();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 0),
                                      minimumSize: const Size.fromHeight(30),
                                      shadowColor: primaryColor700,
                                      elevation: 20,
                                      backgroundColor: primaryColor600,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                    child: const Text(
                                      'Proceed',
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontSize: 14,
                                          color: textColor100),
                                    ),
                                  )
                                ])),
                      );
                    });
              },
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromRGBO(119, 143, 253, 1)
                        .withOpacity(0.1)),
                child: const Icon(
                  Icons.person_off_outlined,
                  color: Color.fromRGBO(119, 143, 253, 1),
                ),
              ),
              title: const Text(
                'Delete Account',
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
                settingsController.signOutUser();
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
