import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/features/authentication/models/EventModel.dart';

class EventRepository extends GetxController {
  static EventRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createEvent(EventModel event) async {
    try {
      await _db
          .collection('EventsInfo')
          .add(event.toJson())
          .whenComplete(() => Get.snackbar(
              "Success", "Event Succefully Created",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green))
          .catchError((error, StackTrace) {
        Get.snackbar("Error", "An error has occured. Please retry.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
      });
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }
}
