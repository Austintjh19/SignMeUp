import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/models/EventModel.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/event_repository/EventRepository.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';

class GeneralEventController extends GetxController {
  static GeneralEventController get instance => Get.find();

  final _authRepository = Get.put(AuthenticationRepository());
  final _userRepository = Get.put(UserRepository());
  final _eventRepository = Get.put(EventRepository());

  final stringQuery = TextEditingController(text: '');

  Future<List<EventModel>?> searchEvents() async {
    if (stringQuery.text == '') {
      return getAllEvents();
    }
    return _eventRepository.searchEvent(stringQuery.text.trim());
  }

  Future<List<EventModel>?> getUserRegisteredEvents() async {
    final uid = _authRepository.firebaseUser.value?.uid;
    List? registedEvents = await _userRepository.getRegisteredEvents(uid!);
    if (registedEvents != null) {
      List<EventModel> registeredEventsCollection =
          await _eventRepository.getUserRegisteredEvents(registedEvents!);
      return registeredEventsCollection;
    }
    return null;
  }

  getEventImage(String imagePath) {
    return _eventRepository.getEventImage(imagePath);
  }

  Future<List<EventModel>?> getAllEvents() async {
    return await _eventRepository.getAllEvents();
  }
}
