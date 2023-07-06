import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';

import '../../../models/UserModel.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final name = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  final profileImage = TextEditingController(text: "");
  final description = TextEditingController();

  final _userRepository = Get.put(UserRepository());
  final _authenticationRepository = Get.put(AuthenticationRepository());

  Future<void> registerUser() async {
    UserCredential cred =
        await _authenticationRepository.createUserViaEmailAndPassword(
            email.text.trim(), newPassword.text.trim());

    final user = UserModel([], [],
        uid: cred.user!.uid,
        username: username.text.trim(),
        name: name.text.trim(),
        email: email.text.trim(),
        password: newPassword.text.trim(),
        profileImage: profileImage.text.trim(),
        description: description.text.trim());

    await _userRepository.storeUserProfile(user, cred);
  }
}
