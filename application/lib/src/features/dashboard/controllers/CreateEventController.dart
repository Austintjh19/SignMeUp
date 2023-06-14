import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/models/EventModel.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/event_repository/EventRepository.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';

class CreateEventController extends GetxController {
  static CreateEventController get instance => Get.find();

  final _authRepository = Get.put(AuthenticationRepository());
  final _userRepository = Get.put(UserRepository());

  final _eventRepository = Get.put(EventRepository());

  final eventName = TextEditingController();
  final eventDescription = TextEditingController();
  final eventDate = TextEditingController();
  final eventTime = TextEditingController();
  final eventLocation = TextEditingController();
  final participantsLimit = TextEditingController();
  final eventImage = TextEditingController(text: "");

  Future<void> createEvent() async {
    final uid = _authRepository.firebaseUser.value?.uid;
    final String eventId = DateTime.now().toIso8601String();

    final eventData = EventModel(
        id: eventId,
        eventImage: eventImage.text.trim(),
        eventName: eventName.text.trim(),
        eventLocation: eventLocation.text.trim(),
        eventDate: eventDate.text.trim(),
        eventTime: eventTime.text.trim(),
        partcipantsLimit: participantsLimit.text.trim(),
        eventDescription: eventDescription.text.trim(),
        participants: [uid]);
    await _eventRepository.createEvent(eventData, eventId);
    await _userRepository.addRegisteredEvent(uid!, eventId);
  }
}
