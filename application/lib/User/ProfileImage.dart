import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({
    super.key,
  });

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  String imageUrl = '';

  // void selectProfileImage() async {
  //   final image = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //     maxHeight: 512,
  //     maxWidth: 512,
  //     imageQuality: 90,
  //   );

  //   Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");

  //   await ref.putFile(File(image!.path));

  //   ref.getDownloadURL().then((value) async {
  //     setState(() {
  //       profilePicLink = value;
  //     });
  //   });
  // }

  void selectProfileImage() async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('ProfilePictures');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      // Error Handling here
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: selectProfileImage,
      child: CircleAvatar(
        radius: width * 0.25,
        child: const SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.fill,
            child: Icon(
              Icons.person_2_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
