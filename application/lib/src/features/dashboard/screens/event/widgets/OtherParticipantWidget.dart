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

    return Row(
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
                        radius: 20, backgroundImage: NetworkImage(imageUrl))
                    : const CircleAvatar(
                        radius: 20,
                        backgroundImage: ExactAssetImage(defaultProfileImage),
                      );
              }
            }
            return const CircleAvatar(
              radius: 20,
              backgroundImage: ExactAssetImage(defaultProfileImage),
            );
          }),
        ),

        const SizedBox(width: 30),
        // Username and Description

        FutureBuilder(
            future: otherUsersController.getUserData(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return Column(
                    children: [
                      Text(
                        userData.username,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
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
    );
  }
}
