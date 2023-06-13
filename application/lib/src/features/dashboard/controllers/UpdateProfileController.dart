import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/user_repository/UserRepository.dart';

class UpdateProfileController extends GetxController {
  static UpdateProfileController get instance => Get.find();

  final name = TextEditingController();
  final username = TextEditingController();
  final profilePicController = TextEditingController(text: "");
  final description = TextEditingController();

  final _userRepository = Get.put(UserRepository());

  updateProfile(String uid) async {
    await _userRepository.updateProfile(
        uid, name.text.trim(), username.text.trim(), description.text.trim());
  }

  updateProfileImage(String uid) async {
    await _userRepository.updateProfileImage(
        uid, profilePicController.text.trim());
  }
}
