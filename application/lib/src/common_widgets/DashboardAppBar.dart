import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myapplication/src/models/UserModel.dart';
import 'package:myapplication/src/features/dashboard/controllers/ProfileController.dart';
import 'package:myapplication/src/features/dashboard/screens/settings/SettingsScreen.dart';

import '../constants/colors.dart';
import '../constants/image_strings.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return FutureBuilder(
        future: controller.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              UserModel userData = snapshot.data as UserModel;
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 5),

                      // Profile Image
                      FutureBuilder(
                          future: controller.getProfileImage(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                String imageUrl = snapshot.data as String;
                                return imageUrl != ""
                                    ? CircleAvatar(
                                        radius: 35,
                                        backgroundImage: NetworkImage(imageUrl))
                                    : const CircleAvatar(
                                        radius: 35,
                                        backgroundImage: ExactAssetImage(
                                            defaultProfileImage),
                                      );
                              }
                            }
                            return const CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  ExactAssetImage(defaultProfileImage),
                            );
                          }),

                      const SizedBox(width: 15),

                      // Welcome Back
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Welcome Back !',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: textColor400)),
                          const SizedBox(height: 2.5),
                          Text(
                            userData.name,
                            style: const TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor600),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Settings
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => const SettingsScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Colors.white,
                        ),
                        child: const Icon(
                          LineAwesomeIcons.cog,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }
          return const LinearProgressIndicator();
        });
  }
}
