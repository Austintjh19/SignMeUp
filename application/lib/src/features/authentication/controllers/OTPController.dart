import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/features/authentication/screens/sign_up/SignUpScreen.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  final emailController = TextEditingController()..text = '';
  final phoneNumController = TextEditingController();
  String phoneCode = '+65';

  final userRepository = Get.put(AuthenticationRepository());

  void phoneNumAuthentication() {
    AuthenticationRepository.instance
        .phoneAuthentication(phoneCode + phoneNumController.text.trim());
  }

  void emailAuthentication() {
    AuthenticationRepository.instance
        .emailAuthentication(emailController.text.trim());
  }

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const SignUpScreen()) : Get.back();
  }
}
