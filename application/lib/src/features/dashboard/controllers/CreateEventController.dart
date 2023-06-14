import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';

class CreateEventController extends GetxController {
  static CreateEventController get instance => Get.find();

  final _authRepository = Get.put(AuthenticationRepository());
  final _userRepository = Get.put(UserRepository());

  final eventName = TextEditingController();
  final eventDescription = TextEditingController();
  final eventDate = TextEditingController();
  final eventTime = TextEditingController();
  final eventLocation = TextEditingController();
  final maxParticipants = TextEditingController();
  final eventImage = TextEditingController(text: "");
}
