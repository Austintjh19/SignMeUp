import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';

class OtherUsersController extends GetxController {
  static OtherUsersController get instance => Get.find();

  final _userRepository = Get.put(UserRepository());

  getUserData(String uid) {
    if (uid != null) {
      return _userRepository.getUserData(uid);
    } else {
      Get.snackbar("Error", "Unable to retrive User Data",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      return null;
    }
  }

  getUserProfileImage(String uid) {
    if (uid != null) {
      return _userRepository.getProfileImage(uid);
    } else {
      Get.snackbar("Error", "Unable to retrive User Profile Image",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }
}
