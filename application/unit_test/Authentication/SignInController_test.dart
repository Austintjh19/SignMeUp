import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:myapplication/src/features/authentication/controllers/SignInController.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';

class MockAuthenticationRepository extends GetxController
    with Mock
    implements AuthenticationRepository {}

void main() {
  setUp(() {
    Get.testMode = true; // Enable test mode for GetX
    Get.reset(); // Reset GetX bindings
    Get.put<AuthenticationRepository>(MockAuthenticationRepository());
  });

  group('SignInController', () {
    late SignInController signInController;
    late MockAuthenticationRepository mockRepository;

    setUp(() {
      signInController = SignInController();
      mockRepository = Get.find<MockAuthenticationRepository>();
    });

    test(
        'signInUserViaEmailAndPassword should call signInUserViaEmailAndPassword method of AuthenticationRepository',
        () async {
      const email = 'test@example.com';
      const password = 'password';

      signInController.email.text = email;
      signInController.password.text = password;

      await signInController.signInUserViaEmailAndPassword();

      verify(mockRepository.signInUserViaEmailAndPassword(email, password))
          .called(1);
    });
  });
}
