import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';

import '../models/UserModel.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final name = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  final profilePic = TextEditingController(text: "");
  final description = TextEditingController();

  final userRepository = Get.put(UserRepository());

  Future<void> registerUser() async {
    final controller = Get.put(SignUpController());

    UserCredential cred = await AuthenticationRepository.instance
        .createUserViaEmailAndPassword(
            controller.email.text.trim(), controller.newPassword.text.trim());

    final user = UserModel(
        uid: cred.user!.uid,
        username: controller.username.text.trim(),
        name: controller.name.text.trim(),
        email: controller.email.text.trim(),
        password: controller.newPassword.text.trim(),
        profileImage: controller.profilePic.text.trim(),
        description: controller.description.text.trim());

    await userRepository.storeUserDetails(user, cred);
  }
}
