import 'package:get/get.dart';
import 'package:myapplication/Pages/SignIn/SignInPage.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController get find => Get.find();

  Future toLoginPage() async {
    await Future.delayed(Duration(microseconds: 1000));
    Get.to(SignInPage());
  }
}
