import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/models/EventModel.dart';

import '../../../repository/authentication_repository/AuthenticationRepository.dart';
import '../../../repository/event_repository/EventRepository.dart';
import '../../../repository/user_repository/UserRepository.dart';
import 'DisplayEventsController.dart';

class SearchEventController extends GetxController {
  static SearchEventController get instance => Get.find();

  final _authRepository = Get.put(AuthenticationRepository());
  final _userRepository = Get.put(UserRepository());
  final _eventRepository = Get.put(EventRepository());
  final displayEventsController = Get.put(DisplayEventsController());

  final stringQuery = TextEditingController(text: '');

  Future<List<EventModel>?> searchEvents() async {
    if (stringQuery.text == '') {
      return displayEventsController.getAllEvents();
    }
    return _eventRepository.searchEvent(stringQuery.text);
  }
}
