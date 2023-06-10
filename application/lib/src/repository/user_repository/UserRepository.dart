import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/authentication/models/UserModel.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> storeUserDetails(UserModel user, UserCredential cred) async {
    // await _db
    //     .collection('UsersSignUpInfo')
    //     .add(user.toJson())
    user.toJson().addAll({'UID': cred.user!.uid.toString()});
    await _db
        .collection('UsersSignUpInfo')
        .doc(cred.user!.uid)
        .set(user.toJson())
        .whenComplete(() => Get.snackbar(
            "Success", "Your account has been registered",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green))
        .catchError((error, StackTrace) {
      Get.snackbar("Error", "An error has occured. Please retry.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    });
  }
}
