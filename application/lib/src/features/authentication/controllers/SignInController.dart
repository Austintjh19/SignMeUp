import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';

import '../models/UserModel.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final userRepository = Get.put(UserRepository());

  Future<void> signInUserViaEmailAndPassword() async {
    await AuthenticationRepository.instance.signInUserViaEmailAndPassword(
        emailController.text.trim(), passwordController.text.trim());
  }
}
