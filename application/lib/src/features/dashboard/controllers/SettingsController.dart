import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/models/UserModel.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';

import 'CurrentUserController.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  final _authenticationRepository = Get.put(AuthenticationRepository());
  final currentUserController = Get.put(CurrentUserController());

  final password = TextEditingController();

  Future<void> resetPasswordviaEmail() async {
    await _authenticationRepository.resetPasswordViaEmail(
        (await currentUserController.getUserData() as UserModel).email);
    signOutUser();
  }

  Future<void> signOutUser() async {
    _authenticationRepository.signOutUser();
  }

  Future<void> deleteUserAccount() async {
    _authenticationRepository.deleteUserAccount(
        (await currentUserController.getUserData() as UserModel).email,
        password.text.trim());
  }
}
