import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  final emailController = TextEditingController();

  final authenticationRepository = Get.put(AuthenticationRepository());

  Future<void> resetPasswordviaEmail() async {
    await AuthenticationRepository.instance
        .resetPasswordViaEmail(emailController.text.trim());
  }
}
