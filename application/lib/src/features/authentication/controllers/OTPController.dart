import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/features/authentication/screens/sign_up/SignUpScreen.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  final email = TextEditingController()..text = '';
  final phoneNum = TextEditingController();
  String phoneCode = '+65';

  final userRepository = Get.put(AuthenticationRepository());

  Future<String> phoneNumAuthentication() {
    return AuthenticationRepository.instance
        .phoneAuthentication(phoneCode + phoneNum.text.trim());
  }

  void emailAuthentication() {
    AuthenticationRepository.instance.emailAuthentication(email.text.trim());
  }

  void verifyOTP(String otp, String phoneVerificationID) async {
    var isVerified = await AuthenticationRepository.instance
        .verifyOTP(otp, phoneVerificationID);
    isVerified ? Get.offAll(const SignUpScreen()) : Get.back();
  }
}
