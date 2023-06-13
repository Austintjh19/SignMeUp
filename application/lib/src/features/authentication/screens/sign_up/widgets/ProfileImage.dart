import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myapplication/src/constants/image_strings.dart';

import '../../../controllers/SignUpController.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    super.key,
  });

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  String imageUrl = "";
  final controller = Get.put(SignUpController());
  final String identifier = DateTime.now().toIso8601String();

  void selectProfileImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 600,
      maxWidth: 600,
      imageQuality: 100,
    );

    Reference ref =
        FirebaseStorage.instance.ref().child("/ProfilePictures/$identifier");

    await ref.putFile(File(image!.path));

    ref.getDownloadURL().then((value) async {
      setState(() {
        imageUrl = value;
      });
    });

    controller.profilePicController.text = ref.fullPath;
  }

  // void selectProfileImage() async {
  //   String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   ImagePicker imagePicker = ImagePicker();
  //   XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  //   if (file == null) return;
  //   Reference referenceRoot = FirebaseStorage.instance.ref();
  //   Reference referenceDirImages = referenceRoot.child('ProfilePictures');
  //   Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
  //   try {
  //     await referenceImageToUpload.putFile(File(file.path));
  //     imageUrl = await referenceImageToUpload.getDownloadURL();
  //   } catch (error) {
  //     // Error Handling here
  //   }
  // }

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
