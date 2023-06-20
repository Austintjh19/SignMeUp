import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/features/dashboard/controllers/OtherUsersController.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/image_strings.dart';
import '../../../../../models/UserModel.dart';

class OtherParticipantWidget extends StatelessWidget {
  final String uid;
  const OtherParticipantWidget({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    final otherUsersController = Get.put(OtherUsersController());

    return Column(
      children: [
        Row(
          children: [
            // Profile Image
            FutureBuilder(
              future: otherUsersController.getUserProfileImage(uid),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    String imageUrl = snapshot.data as String;
                    return imageUrl != ""
                        ? CircleAvatar(
                            radius: 25, backgroundImage: NetworkImage(imageUrl))
                        : const CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                ExactAssetImage(defaultProfileImage),
                          );
                  }
                }
                return const CircleAvatar(
                  radius: 25,
                  backgroundImage: ExactAssetImage(defaultProfileImage),
                );
              }),
            ),

            const SizedBox(width: 40),
            // Username and Description

            FutureBuilder(
                future: otherUsersController.getUserData(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData.username,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: textColor600),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            userData.description,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                height: 1.5,
                                color: textColor600),
                          ),
                        ],
                      );
                    }
                  }
                  return const Text('');
                })
          ],
        ),
        const SizedBox(width: 5),
        const Divider(),
        const SizedBox(width: 5),
      ],
    );
  }
}
