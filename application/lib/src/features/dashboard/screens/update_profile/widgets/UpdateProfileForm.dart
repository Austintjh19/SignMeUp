import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../authentication/models/UserModel.dart';
import '../../../controllers/ProfileController.dart';
import '../../../controllers/UpdateProfileController.dart';

class UpdatProfileForm extends StatefulWidget {
  const UpdatProfileForm({super.key});

  @override
  State<UpdatProfileForm> createState() => _UpdatProfileFormState();
}

class _UpdatProfileFormState extends State<UpdatProfileForm> {
  bool formEnabled = false;

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    final updateProfileController = Get.put(UpdateProfileController());
    return SingleChildScrollView(
      child: FutureBuilder(
          future: profileController.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                UserModel userData = snapshot.data as UserModel;
                updateProfileController.name.text = userData.name;
                updateProfileController.username.text = userData.username;
                updateProfileController.description.text = userData.description;
                return Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
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
                          onPressed: () {
                            setState(() => formEnabled = true);
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Name
                      TextFormField(
                        style: const TextStyle(
                            color: Color.fromRGBO(119, 143, 253, 1),
                            fontFamily: 'Raleway',
                            fontSize: 14),
                        textAlign: TextAlign.left,
                        controller: updateProfileController.name,
                        enabled: formEnabled,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(right: 10),
                            decoration: const BoxDecoration(
                              border: Border(
                                right:
                                    BorderSide(width: 1, color: Colors.white),
                              ),
                            ),
                            child: const Icon(
                              Icons.person_outline_rounded,
                              size: 20,
                              color: Color.fromRGBO(119, 143, 253, 1),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Username
                      TextFormField(
                        style: const TextStyle(
                            color: Color.fromRGBO(119, 143, 253, 1),
                            fontFamily: 'Raleway',
                            fontSize: 14),
                        textAlign: TextAlign.left,
                        controller: updateProfileController.username,
                        enabled: formEnabled,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Container(
                            margin: const EdgeInsets.only(right: 10),
                            decoration: const BoxDecoration(
                              border: Border(
                                right:
                                    BorderSide(width: 1, color: Colors.white),
                              ),
                            ),
                            child: const Icon(
                              Icons.person_outline_rounded,
                              size: 20,
                              color: Color.fromRGBO(119, 143, 253, 1),
                            ),
                          ),
                        ),
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
    );
  }
}
