import 'package:get/get.dart';

class ValidationController extends GetxController {
  static ValidationController get instance => Get.find();

  /// Validation Checking

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    if (value!.isEmpty) {
      return 'Please enter Email';
    }
    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Invalid Email Entered'
        : null;
  }

  String? validateSignInPassword(String? value) {
    RegExp regex = RegExp(r'^.{8,}$');
    if (value!.isEmpty) {
      return 'Password is required';
    }
    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Invalid Password Entered'
        : null;
  }

  String? validateSignUpPassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    var passNonNullValue = value ?? "";
    if (passNonNullValue.isEmpty) {
      return ("Password is required");
    } else if (passNonNullValue.length < 8) {
      return ("Password Must be more than 7 characters");
    } else if (!regex.hasMatch(passNonNullValue)) {
      return ("1 Upper, 1 Lower, 1 Digit & 1 Special Character needed");
    }
    return null;
  }

  String? validatePhoneNum(String? value) {
    const patttern = r'^[0-9]*$';
    RegExp regex = RegExp(patttern);
    if (value!.isEmpty) {
      return 'Please enter Phone Number';
    }
    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Invalid Phone Number Entered'
        : null;
  }

  String? validateName(String? value) {
    const patttern = r'[A-Za-z0-9_]{1,29}$';
    RegExp regex = RegExp(patttern);
    if (value!.isEmpty) {
      return 'Please enter Your Name';
    }
    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Invalid Name Entered'
        : null;
  }

  String? validateUsername(String? value) {
    const patttern = r'[A-Za-z0-9_]{1,29}$';
    RegExp regex = RegExp(patttern);
    if (value!.isEmpty) {
      return 'Please enter a Username';
    }
    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Invalid Username Entered'
        : null;
  }
}
