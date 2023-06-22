import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/models/EventModel.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/event_repository/EventRepository.dart';

class GeneralEventController extends GetxController {
  static GeneralEventController get instance => Get.find();

  final _authRepository = Get.put(AuthenticationRepository());
  final _eventRepository = Get.put(EventRepository());

  final stringQuery = TextEditingController(text: '');

  Future<List<EventModel>?> searchEvents() async {
    if (stringQuery.text == '') {
      return getAllEvents();
    }
    return _eventRepository.searchEvent(stringQuery.text.trim());
  }

  getEventImage(String imagePath) {
    return _eventRepository.getEventImage(imagePath);
  }

  Future<List<EventModel>?> getAllEvents() async {
    return await _eventRepository.getAllEvents();
  }

  Future<void> addParticipant(String eventID) async {
    final uid = _authRepository.firebaseUser.value?.uid;
    await _eventRepository.addParticipant(uid!, eventID);
  }

  Future<void> removeParticipant(String eventID) async {
    final uid = _authRepository.firebaseUser.value?.uid;
    await _eventRepository.removeParticipant(uid!, eventID);
  }
}
