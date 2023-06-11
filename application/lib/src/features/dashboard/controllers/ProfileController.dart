import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepository = Get.put(AuthenticationRepository());
  final _userRepository = Get.put(UserRepository());

  getUserData() {
    final uid = _authRepository.firebaseUser.value?.uid;
    if (uid != null) {
      return _userRepository.getUserData(uid);
    } else {
      Get.snackbar("Error", "Unable to retrive User Data",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  getProfileImage() {
    final uid = _authRepository.firebaseUser.value?.uid;
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
