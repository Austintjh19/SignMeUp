import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/image_strings.dart';
import '../../../controllers/CreateEventController.dart';

class SelectEventImageWidget extends StatefulWidget {
  const SelectEventImageWidget({super.key});

  @override
  State<SelectEventImageWidget> createState() => _SelectEventImageWidgetState();
}

class _SelectEventImageWidgetState extends State<SelectEventImageWidget> {
  String imageUrl = "";
  final String eventImageID = DateTime.now().toIso8601String();

  final createEventController = Get.put(CreateEventController());

  void selectEventImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 600,
      maxWidth: 600,
      imageQuality: 100,
    );

    Reference ref =
        FirebaseStorage.instance.ref().child("/EventImages/$eventImageID");
    try {
      await ref.putFile(File(image!.path));

      ref.getDownloadURL().then((value) async {
        setState(() {
          imageUrl = value;
        });
      });

      createEventController.eventImage.text = ref.fullPath;
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
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        imageUrl != ""
            ? Container(
                width: width,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.cover)),
              )
            : Container(
                width: width,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: ExactAssetImage(defaultEventImage),
                        fit: BoxFit.cover)),
              ),
        Positioned(
          bottom: 8,
          right: 8,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: primaryColor500.withOpacity(0.8)),
            child: IconButton(
              icon: const Icon(
                Icons.edit_outlined,
                color: primaryColor100,
                size: 15,
              ),
              onPressed: () {
                selectEventImage();
              },
            ),
          ),
        )
      ],
    );
  }
}
