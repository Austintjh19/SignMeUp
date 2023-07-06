import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapplication/src/models/UserModel.dart';

import '../../../../../constants/image_strings.dart';
import '../../../controllers/CurrentUserController.dart';
import '../../../controllers/UpdateProfileController.dart';

class UpdateProfileImageWidget extends StatefulWidget {
  final UserModel userData;
  const UpdateProfileImageWidget({super.key, required this.userData});

  @override
  State<UpdateProfileImageWidget> createState() =>
      _UpdateProfileImageWidgetState();
}

class _UpdateProfileImageWidgetState extends State<UpdateProfileImageWidget> {
  String newImageUrl = "";
  final String profileImageID = DateTime.now().toIso8601String();

  final updateProfileController = Get.put(UpdateProfileController());
  final currentUserController = Get.put(CurrentUserController());

  void updateProfileImage(String uid) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 600,
      maxWidth: 600,
      imageQuality: 100,
    );

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("/ProfilePictures/$profileImageID");

    try {
      await ref.putFile(File(image!.path));

      ref.getDownloadURL().then((value) async {
        setState(() {
          newImageUrl = value;
        });
      });
      updateProfileController.profileImage.text = ref.fullPath;
      updateProfileController.updateProfileImage(uid);
    } catch (e) {
      Get.snackbar("Error",
          'No Image has been selected. Please try again if you wish to select/ change your profile pic.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
            future: currentUserController.getProfileImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  String imageUrl = snapshot.data as String;
                  return newImageUrl == ""
                      ? imageUrl != ""
                          ? CircleAvatar(
                              radius: 90,
                              backgroundImage: NetworkImage(imageUrl))
                          : const CircleAvatar(
                              radius: 90,
                              backgroundImage:
                                  ExactAssetImage(defaultProfileImage),
                            )
                      : CircleAvatar(
                          radius: 90,
                          backgroundImage: NetworkImage(newImageUrl));
                }
              }
              return const CircleAvatar(
                radius: 90,
                backgroundImage: ExactAssetImage(defaultProfileImage),
              );
            }),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color.fromRGBO(119, 143, 253, 1)),
            child: IconButton(
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                updateProfileImage(widget.userData.uid);
              },
            ),
          ),
        )
      ],
    );
  }
}
