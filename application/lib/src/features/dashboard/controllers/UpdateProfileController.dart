import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  static UpdateProfileController get instance => Get.find();

  final name = TextEditingController();
  final username = TextEditingController();
  final profilePicController = TextEditingController(text: "");
  final description = TextEditingController();
}
