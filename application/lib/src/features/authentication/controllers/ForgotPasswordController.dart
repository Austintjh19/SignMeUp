import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  final email = TextEditingController();

  final _authenticationRepository = Get.put(AuthenticationRepository());

  Future<void> resetPasswordviaEmail() async {
    await _authenticationRepository.resetPasswordViaEmail(email.text.trim());
  }
}
