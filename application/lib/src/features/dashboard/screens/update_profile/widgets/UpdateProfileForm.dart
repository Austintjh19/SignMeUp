import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapplication/src/features/dashboard/Dashboard.dart';
import 'package:myapplication/src/features/dashboard/screens/update_profile/widgets/UpdateProfileTextField.dart';

import '../../../../../constants/image_strings.dart';
import '../../../../../controllers/ValidationController.dart';
import '../../../../../models/UserModel.dart';
import '../../../controllers/CurrentUserController.dart';
import '../../../controllers/UpdateProfileController.dart';

class UpdatProfileForm extends StatefulWidget {
  const UpdatProfileForm({super.key});

  @override
  State<UpdatProfileForm> createState() => _UpdatProfileFormState();
}

class _UpdatProfileFormState extends State<UpdatProfileForm> {
  final profileController = Get.put(CurrentUserController());
  final updateProfileController = Get.put(UpdateProfileController());
  final validationController = Get.put(ValidationController());
  final String identifier = DateTime.now().toIso8601String();
  bool formEnabled = false;
  String newImageUrl = "";

  void updateProfileImage(String uid) async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 600,
      maxWidth: 600,
      imageQuality: 100,
    );

    Reference ref =
        FirebaseStorage.instance.ref().child("/ProfilePictures/$identifier");

    try {
      await ref.putFile(File(image!.path));

      ref.getDownloadURL().then((value) async {
        setState(() {
          newImageUrl = value;
        });
      });
      updateProfileController.profilePicController.text = ref.fullPath;
      updateProfileController.updateProfileImage(uid);
    } catch (e) {
      Get.snackbar("Error",
          'No Image has been selected. Please try again if you wish to select/ change your profile pic.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
    // await ref.putFile(File(image!.path));

    // ref.getDownloadURL().then((value) async {
    //   setState(() {
    //     newImageUrl = value;
    //   });
    // });

    // updateProfileController.profilePicController.text = ref.fullPath;
    // updateProfileController.updateProfileImage(uid);
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: FutureBuilder(
            future: profileController.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  updateProfileController.name.text = userData.name;
                  updateProfileController.username.text = userData.username;
                  updateProfileController.description.text =
                      userData.description;
                  return Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        // Profile Image
                        Stack(
                          children: [
                            FutureBuilder(
                                future: profileController.getProfileImage(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasData) {
                                      String imageUrl = snapshot.data as String;
                                      return newImageUrl == ""
                                          ? imageUrl != ""
                                              ? CircleAvatar(
                                                  radius: 90,
                                                  backgroundImage:
                                                      NetworkImage(imageUrl))
                                              : const CircleAvatar(
                                                  radius: 90,
                                                  backgroundImage:
                                                      ExactAssetImage(
                                                          defaultProfileImage),
                                                )
                                          : CircleAvatar(
                                              radius: 90,
                                              backgroundImage:
                                                  NetworkImage(newImageUrl));
                                    }
                                  }
                                  return const CircleAvatar(
                                    radius: 90,
                                    backgroundImage:
                                        ExactAssetImage(defaultProfileImage),
                                  );
                                }),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color:
                                        const Color.fromRGBO(119, 143, 253, 1)),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    updateProfileImage(userData.uid);
                                  },
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Edit/ Save Button
                        Container(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            style: TextButton.styleFrom(
                                backgroundColor: formEnabled
                                    ? const Color.fromRGBO(119, 143, 253, 1)
                                    : Colors.grey
                                        .withOpacity(0.1), // Background color
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                            icon: Text(
                              formEnabled ? "Update" : "Edit Profile",
                              style: TextStyle(
                                  color: formEnabled
                                      ? Colors.white
                                      : const Color.fromRGBO(119, 143, 253, 1),
                                  fontFamily: 'Raleway',
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            label: formEnabled
                                ? const Icon(
                                    Icons.update_outlined,
                                    size: 15,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.edit_outlined,
                                    size: 15,
                                    color: Color.fromRGBO(119, 143, 253, 1),
                                  ),
                            onPressed: () async {
                              if (formEnabled == false) {
                                setState(() {
                                  formEnabled = true;
                                });
                              } else {
                                if (_formKey.currentState!.validate()) {
                                  await updateProfileController
                                      .updateProfile(userData.uid);
                                  Get.offAll(Dashboard(initialPageIndex: -1),
                                      transition: Transition.leftToRight);
                                }
                              }
                            },
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Name
                        UpdateProfileTextField(
                          controller: updateProfileController.name,
                          formEnabled: formEnabled,
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            size: 20,
                            color: Color.fromRGBO(119, 143, 253, 1),
                          ),
                          validator: validationController.validateName,
                        ),

                        const SizedBox(height: 20),

                        // Username
                        UpdateProfileTextField(
                          controller: updateProfileController.username,
                          formEnabled: formEnabled,
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            size: 20,
                            color: Color.fromRGBO(119, 143, 253, 1),
                          ),
                          validator: validationController.validateUsername,
                        ),

                        const SizedBox(height: 20),

                        // Description
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 5,
                          maxLines: 5,
                          style: const TextStyle(
                              color: Color.fromRGBO(119, 143, 253, 1),
                              fontFamily: 'Raleway',
                              fontSize: 14),
                          textAlign: TextAlign.left,
                          controller: updateProfileController.description,
                          enabled: formEnabled,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Container(
                              height: 100,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: const BoxDecoration(
                                border: Border(
                                  right:
                                      BorderSide(width: 1, color: Colors.white),
                                ),
                              ),
                              child: const Icon(
                                Icons.description_outlined,
                                size: 20,
                                color: Color.fromRGBO(119, 143, 253, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
