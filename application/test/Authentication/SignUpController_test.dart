import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:myapplication/src/features/authentication/controllers/SignUpController.dart';
import 'package:myapplication/src/models/UserModel.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';
import 'package:myapplication/src/repository/user_repository/UserRepository.dart';

class MockAuthenticationRepository extends GetxController with Mock implements AuthenticationRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  setUp(() {
    Get.reset(); // Reset GetX bindings
    Get.put<AuthenticationRepository>(MockAuthenticationRepository());
    Get.put<UserRepository>(MockUserRepository());
  });

  group('SignUpController', () {
    late SignUpController signUpController;
    late MockAuthenticationRepository mockAuthRepository;
    late MockUserRepository mockUserRepository;

    setUp(() {
      signUpController = SignUpController();
      mockAuthRepository = Get.find<MockAuthenticationRepository>();
      mockUserRepository = Get.find<MockUserRepository>();
    });

    test('registerUser should create a user via email and password, and store user details', () async {
      const name = 'haitao';
      const username = 'haitao';
      const email = 'johndoe@example.com';
      const newPassword = 'password123';
      const profilePic = 'profile.jpg';
      const description = 'This is haitao';

      final mockCredential = MockUserCredential();
      final mockUser = UserModel([],[], uid: '123', username: username, name: name, email: email, password: newPassword, profileImage: profilePic, description: description);

      when(mockAuthRepository.createUserViaEmailAndPassword('test@example.com', 'password')).thenAnswer((_) async => mockCredential);
      when(mockUserRepository.storeUserDetails(mockUser,mockCredential)).thenAnswer((_) async {});

      signUpController.name.text = name;
      signUpController.username.text = username;
      signUpController.email.text = email;
      signUpController.newPassword.text = newPassword;
      signUpController.profilePic.text = profilePic;
      signUpController.description.text = description;

      await signUpController.registerUser();

      verify(mockAuthRepository.createUserViaEmailAndPassword(email, newPassword)).called(1);
      verify(mockUserRepository.storeUserDetails(mockUser, mockCredential)).called(1);
    });
  });
}

// MockUserCredential for testing purposes
class MockUserCredential extends Mock implements UserCredential {}
