import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../repository/authentication_repository/AuthenticationRepository.dart';
import '../../../repository/event_repository/EventRepository.dart';
import '../../../repository/user_repository/UserRepository.dart';

class SearchEventController extends GetxController {
  static SearchEventController get instance => Get.find();

  final _authRepository = Get.put(AuthenticationRepository());
  final _userRepository = Get.put(UserRepository());

  final _eventRepository = Get.put(EventRepository());

  final searchString = TextEditingController();
}
