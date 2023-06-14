import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/models/EventModel.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/event_repository/EventRepository.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';

class DisplayEventsController extends GetxController {
  static DisplayEventsController get instance => Get.find();

  final _authRepository = Get.put(AuthenticationRepository());
  final _userRepository = Get.put(UserRepository());
  final _eventRepository = Get.put(EventRepository());

  Future<List<EventModel>> getUserRegisteredEvents() async {
    final uid = _authRepository.firebaseUser.value?.uid;
    List registedEvents = await _userRepository.getRegisteredEvents(uid!);
    List<EventModel> registeredEventsCollection =
        await _eventRepository.getUserRegisteredEvents(registedEvents);
    return registeredEventsCollection;
  }
}
