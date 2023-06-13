import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ProfileController.dart';

class UpdateProfileController extends GetxController {
  static UpdateProfileController get instance => Get.find();

  final name = TextEditingController();
  final username = TextEditingController();
  String profilePicController = "";
  final description = TextEditingController();
}
