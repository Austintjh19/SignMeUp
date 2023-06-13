import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/common_widgets/BorderedTextForm.dart';
import 'package:myapplication/src/features/dashboard/controllers/ProfileController.dart';
import 'package:myapplication/src/features/dashboard/controllers/UpdateProfileController.dart';

import '../../../../constants/colors.dart';
import '../../../authentication/models/UserModel.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    final updateProfileController = Get.put(UpdateProfileController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined,
                color: Colors.black, size: 25)),
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              color: heading1Color),
        ),
      ),
      body: SingleChildScrollView(
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
                          // Name
                          TextFormField(
                            style: const TextStyle(
                                color: Color.fromRGBO(119, 143, 253, 1),
                                fontFamily: 'Raleway',
                                fontSize: 14),
                            textAlign: TextAlign.left,
                            controller: updateProfileController.name,
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
                                    right: BorderSide(
                                        width: 1, color: Colors.white),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.person_outline_rounded,
                                  size: 20,
                                  color: Color.fromRGBO(119, 143, 253, 1),
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  size: 20,
                                  color: Color.fromRGBO(119, 143, 253, 1),
                                ),
                                onPressed: () {},
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
                                    right: BorderSide(
                                        width: 1, color: Colors.white),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.person_outline_rounded,
                                  size: 20,
                                  color: Color.fromRGBO(119, 143, 253, 1),
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  size: 20,
                                  color: Color.fromRGBO(119, 143, 253, 1),
                                ),
                                onPressed: () {},
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
                                    right: BorderSide(
                                        width: 1, color: Colors.white),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.description_outlined,
                                  size: 20,
                                  color: Color.fromRGBO(119, 143, 253, 1),
                                ),
                              ),
                              suffixIcon: Container(
                                width: 20,
                                height: 100,
                                alignment: Alignment.bottomCenter,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    size: 20,
                                    color: Color.fromRGBO(119, 143, 253, 1),
                                  ),
                                  onPressed: () {},
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
              })),
    );
  }
}
