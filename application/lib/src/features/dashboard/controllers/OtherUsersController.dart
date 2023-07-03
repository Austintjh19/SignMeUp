import 'package:get/get.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';

class OtherUsersController extends GetxController {
  static OtherUsersController get instance => Get.find();

  final _userRepository = Get.put(UserRepository());

  getUserData(String uid) {
    if (uid != '') {
      return _userRepository.getUserData(uid);
    } else {
      return null;
    }
  }

  getUserProfileImage(String uid) {
    return _userRepository.getProfileImage(uid);
  }
}
