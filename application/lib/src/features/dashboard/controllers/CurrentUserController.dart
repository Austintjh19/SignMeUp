import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';

import '../../../models/EventModel.dart';
import '../../../repository/event_repository/EventRepository.dart';

class CurrentUserController extends GetxController {
  static CurrentUserController get instance => Get.find();

  final _authRepository = Get.put(AuthenticationRepository());
  final _userRepository = Get.put(UserRepository());
  final _eventRepository = Get.put(EventRepository());

  getUserData() {
    final uid = _authRepository.firebaseUser.value?.uid;
    if (uid != null) {
      return _userRepository.getUserData(uid);
    } else {
      Get.snackbar("Error", "Unable to retrive User Data",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  getProfileImage() {
    final uid = _authRepository.firebaseUser.value?.uid;
    if (uid != null) {
      return _userRepository.getProfileImage(uid);
    } else {
      Get.snackbar("Error", "Unable to retrive User Profile Image",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  Future<List<EventModel>?> getUserRegisteredEvents() async {
    final uid = _authRepository.firebaseUser.value?.uid;
    List? registedEvents = await _userRepository.getRegisteredEvents(uid!);
    if (registedEvents != null) {
      List<EventModel> registeredEventsCollection =
          await _eventRepository.getSelectedEvents(registedEvents);
      return registeredEventsCollection;
    }
    return null;
  }

  Future<List<EventModel>?> getBookmarkedEvents() async {
    final uid = _authRepository.firebaseUser.value?.uid;
    List? bookmarkedEvents = await _userRepository.getBookmarkedEvents(uid!);
    if (bookmarkedEvents != null) {
      List<EventModel> bookmarkedEventsCollection =
          await _eventRepository.getSelectedEvents(bookmarkedEvents);
      return bookmarkedEventsCollection;
    }
    return null;
  }

  Future<bool> getIsEventRegistered(String eventID) async {
    final uid = _authRepository.firebaseUser.value?.uid;
    List? registedEvents = await _userRepository.getRegisteredEvents(uid!);
    if (registedEvents != null) {
      for (final events in registedEvents) {
        if (events == eventID) {
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> getIsEventBookmarked(String eventID) async {
    final uid = _authRepository.firebaseUser.value?.uid;
    List? bookmarkedEvents = await _userRepository.getBookmarkedEvents(uid!);
    if (bookmarkedEvents != null) {
      for (final events in bookmarkedEvents) {
        if (events == eventID) {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> addRegisteredEvent(String eventID) async {
    final uid = _authRepository.firebaseUser.value?.uid;
    await _userRepository.addRegisteredEvent(uid!, eventID);
  }

  Future<void> addBookmarkedEvent(String eventID) async {
    final uid = _authRepository.firebaseUser.value?.uid;
    await _userRepository.addBookmarkedEvent(uid!, eventID);
  }

  Future<void> removeRegisteredEvent(String eventID) async {
    final uid = _authRepository.firebaseUser.value?.uid;
    await _userRepository.removeRegisteredEvent(uid!, eventID);
  }

  Future<void> removeBookmarkedEvent(String eventID) async {
    final uid = _authRepository.firebaseUser.value?.uid;
    await _userRepository.removeBookmarkedEvent(uid!, eventID);
  }
}
