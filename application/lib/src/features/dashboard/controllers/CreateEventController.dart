import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  var eventDate = TextEditingController();
  final eventTime = TextEditingController();
  final eventLocation = TextEditingController();
  final participantsLimit = TextEditingController();
  final eventImage = TextEditingController(text: "");

  Future<void> createEvent() async {
    final uid = await _authRepository.getCurrentUserUID();
    final String eventId = DateTime.now().toIso8601String();

    final eventData = EventModel(
        id: eventId,
        eventOrganizer: uid!,
        eventImage: eventImage.text.trim(),
        eventName: setSearchParameters(eventName.text.trim()),
        eventLocation: setSearchParameters(eventLocation.text.trim()),
        eventDate: eventDate.text.trim(),
        eventTime: eventTime.text.trim(),
        eventDateTime:
            getEventDateTime(eventDate.text.trim(), eventTime.text.trim()),
        participantsLimit: participantsLimit.text.trim(),
        eventDescription: eventDescription.text.trim(),
        participants: [uid],
        numParticipants: 1,
        isFull: participantsLimit.text.trim() == '1' ? true : false);
    await _eventRepository.createEvent(eventData, eventId);
    await _userRepository.addToRegisteredEvents(uid, eventId);
  }

  List<String> setSearchParameters(String s) {
    List<String> searchOptions = [];
    String temp = "";
    for (int i = 0; i < s.length; i++) {
      temp = temp + s[i];
      searchOptions.add(temp.toLowerCase());
      searchOptions.add(temp.toUpperCase());
      searchOptions.add(temp);
    }
    return searchOptions;
  }

  DateTime getEventDateTime(String date, String time) {
    final result = DateFormat("EEEE, MMM d, yyyy HH:mm").parse('$date $time');
    return result;
  }
}
