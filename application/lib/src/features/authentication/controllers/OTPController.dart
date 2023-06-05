import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/features/authentication/screens/sign_up/SignUpScreen.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  final emailController = TextEditingController();
  final phoneNumController = TextEditingController();
  String phoneCode = '+65';

  final userRepository = Get.put(AuthenticationRepository());

  void phoneNumAuthentication() {
    print(phoneCode + phoneNumController.text.trim());
    AuthenticationRepository.instance
        .phoneAuthentication(phoneCode + phoneNumController.text.trim());
  }

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const SignUpScreen()) : Get.back();
  }
}
