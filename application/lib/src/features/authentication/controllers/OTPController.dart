import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/features/authentication/screens/sign_up/SignUpScreen.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  final email = TextEditingController()..text = '';
  final phoneNum = TextEditingController();
  String phoneCode = '+65';

  final _authenticationRepository = Get.put(AuthenticationRepository());

  Future<String> phoneNumAuthentication() {
    return _authenticationRepository
        .phoneAuthentication(phoneCode + phoneNum.text.trim());
  }

  void emailAuthentication() {
    _authenticationRepository.emailAuthentication(email.text.trim());
  }

  void verifyOTP(String otp, String phoneVerificationID) async {
    var isVerified =
        await _authenticationRepository.verifyOTP(otp, phoneVerificationID);
    isVerified ? Get.offAll(const SignUpScreen()) : Get.back();
  }
}
