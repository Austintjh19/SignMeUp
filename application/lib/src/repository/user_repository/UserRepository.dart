import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/UserModel.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> storeUserDetails(UserModel user, UserCredential cred) async {
    try {
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
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  Future<UserModel> getUserData(String uid) async {
    final snapshot = await _db
        .collection('UsersSignUpInfo')
        .where("UID", isEqualTo: uid)
        .get();
    if (snapshot != null) {
      final userData =
          snapshot.docs.map((e) => UserModel.fromSnapShot(e)).single;
      return userData;
    }
    return UserModel([],
        uid: '',
        username: 'Unknown',
        name: '',
        email: '',
        password: '',
        profileImage: '',
        description: '');
  }

  Future<String> getProfileImage(String uid) async {
    UserModel userData = await getUserData(uid);
    if (userData.profileImage != "") {
      Reference ref =
          FirebaseStorage.instance.ref().child(userData.profileImage);
      final imageURL = await ref.getDownloadURL();
      return imageURL;
    }
    return "";
  }

  Future<void> updateProfile(
      String uid, String name, String username, String description) async {
    await _db.collection('UsersSignUpInfo').doc(uid).update(
        {'Name': name, 'Username': username, 'Description': description});
    Get.snackbar("Success", "User Profile updated.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green);
  }

  Future<void> updateProfileImage(String uid, String profileImage) async {
    await _db
        .collection('UsersSignUpInfo')
        .doc(uid)
        .update({'Profile Image': profileImage});
    Get.snackbar("Success", "User Profile Image updated.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green);
  }

  Future<void> addRegisteredEvent(String uid, String eventID) async {
    await _db.collection('UsersSignUpInfo').doc(uid).update({
      "Registered Events": FieldValue.arrayUnion([eventID])
    });
  }

  Future<void> removeRegisteredEvent(String uid, String eventID) async {
    await _db.collection('UsersSignUpInfo').doc(uid).update({
      "Registered Events": FieldValue.arrayRemove([eventID])
    });
  }

  Future<List?> getRegisteredEvents(String uid) async {
    final snapshot = await _db
        .collection('UsersSignUpInfo')
        .where("UID", isEqualTo: uid)
        .get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapShot(e)).single;
    return userData.registeredEvents;
  }
}
