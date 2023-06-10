import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';

import '../models/UserModel.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String profilePicController = "";
  final descriptionController = TextEditingController();

  final userRepository = Get.put(UserRepository());

  Future<void> registerUser() async {
    final controller = Get.put(SignUpController());

    UserCredential cred = await AuthenticationRepository.instance
        .createUserViaEmailAndPassword(controller.emailController.text.trim(),
            controller.newPasswordController.text.trim());

    final user = UserModel(
        uid: cred.user!.uid,
        username: controller.usernameController.text.trim(),
        name: controller.nameController.text.trim(),
        email: controller.emailController.text.trim(),
        password: controller.newPasswordController.text.trim(),
        profileImage: controller.profilePicController,
        description: controller.descriptionController.text.trim());

    await userRepository.storeUserDetails(user, cred);
  }
}
