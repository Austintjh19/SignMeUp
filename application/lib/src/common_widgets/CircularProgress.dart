import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircularProgress {
  static CircularProgress get instance => Get.find();

  static getCircularProgressIndicator() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  static popCircularProgressIndicator() {
    Navigator.pop(Get.context!);
  }
}
