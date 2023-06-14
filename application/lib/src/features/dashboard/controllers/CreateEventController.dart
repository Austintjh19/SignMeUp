import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/features/authentication/models/EventModel.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/event_repository/EventRepository.dart';

class CreateEventController extends GetxController {
  static CreateEventController get instance => Get.find();

  final _authRepository = Get.put(AuthenticationRepository());
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
    final eventData = EventModel(
        eventImage: eventImage.text.trim(),
        eventName: eventName.text.trim(),
        eventLocation: eventLocation.text.trim(),
        eventDate: eventDate.text.trim(),
        eventTime: eventTime.text.trim(),
        partcipantsLimit: participantsLimit.text.trim(),
        eventDescription: eventDescription.text.trim(),
        participants: {uid});
    await _eventRepository.createEvent(eventData);
  }
}
