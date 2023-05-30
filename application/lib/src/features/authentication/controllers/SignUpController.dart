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
  final descriptionController = TextEditingController();

  final userRepository = Get.put(UserRepository());

  Future<void> registerUser(UserModel user) async {
    await AuthenticationRepository.instance.createUserViaEmailAndPassword(
        user.toJson()["Email"], user.toJson()["Password"]);
    await userRepository.createUser(user);
  }
}
