import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myapplication/src/constants/image_strings.dart';

import '../../../controllers/SignUpController.dart';

class SelectProfileImageWidget extends StatefulWidget {
  const SelectProfileImageWidget({
    super.key,
  });

  @override
  State<SelectProfileImageWidget> createState() =>
      _SelectProfileImageWidgetState();
}

class _SelectProfileImageWidgetState extends State<SelectProfileImageWidget> {
  String imageUrl = "";
  final String profileImageID = DateTime.now().toIso8601String();

  final controller = Get.put(SignUpController());

  void selectProfileImage() async {
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
          imageUrl = value;
        });
      });
      controller.profileImage.text = ref.fullPath;
    } catch (e) {
      Get.snackbar("Error",
          'No Image has been selected. Please try again if you wish to select your profile image now.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectProfileImage,
      child: Stack(children: [
        imageUrl != ""
            ? CircleAvatar(radius: 125, backgroundImage: NetworkImage(imageUrl))
            : const CircleAvatar(
                radius: 125,
                backgroundImage: ExactAssetImage(defaultProfileImage),
              ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.grey),
            child: const Icon(
              LineAwesomeIcons.alternate_pencil,
              color: Colors.white,
              size: 20,
            ),
          ),
        )
      ]),
    );
  }
}
