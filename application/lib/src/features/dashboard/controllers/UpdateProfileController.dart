import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/user_repository/UserRepository.dart';

class UpdateProfileController extends GetxController {
  static UpdateProfileController get instance => Get.find();

  final _userRepository = Get.put(UserRepository());

  final name = TextEditingController();
  final username = TextEditingController();
  final profileImage = TextEditingController(text: "");
  final description = TextEditingController();

  updateProfile(String uid) async {
    await _userRepository.updateUserProfile(
        uid, name.text.trim(), username.text.trim(), description.text.trim());
  }

  updateProfileImage(String uid) async {
    await _userRepository.updateProfileImage(uid, profileImage.text.trim());
  }
}
