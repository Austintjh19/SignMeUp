import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final _authenticationRepository = Get.put(AuthenticationRepository());
  final userRepository = Get.put(AuthenticationRepository());

  Future<bool> signInUserViaEmailAndPassword() async {
    await _authenticationRepository.signInUserViaEmailAndPassword(
        email.text.trim(), password.text.trim());
    return true;
  }
}
