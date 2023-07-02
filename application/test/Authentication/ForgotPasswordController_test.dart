import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
//import 'package:myapplication/firebase_options.dart';
import 'package:myapplication/src/features/authentication/controllers/ForgotPasswordController.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    Firebase.initializeApp();
  });

  group('ForgotPasswordController', () {
    late ForgotPasswordController forgotPasswordController;
    setUp(() async {
      forgotPasswordController = ForgotPasswordController();
    });

    test(
        'resetPasswordviaEmail should call resetPasswordViaEmail method of AuthenticationRepository',
        () async {
      final mockRepository = MockAuthenticationRepository();
      Get.put<AuthenticationRepository>(mockRepository);

      await forgotPasswordController.resetPasswordviaEmail();

      expect(mockRepository.resetPasswordViaEmailCalled, true);
      expect(
          mockRepository.new_email, forgotPasswordController.email.text.trim());
    });

    tearDown(() {
      Get.reset(); // Reset GetX bindings
    });
  });
}

// MockAuthenticationRepository for testing purposes
class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {
  bool resetPasswordViaEmailCalled = false;
  late String new_email;

  @override
  Future<void> resetPasswordViaEmail(String email) async {
    resetPasswordViaEmailCalled = true;
    new_email = email;
  }
}
