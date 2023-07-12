
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:myapplication/src/features/authentication/controllers/OTPController.dart';
import 'package:myapplication/src/features/authentication/screens/sign_up/SignUpScreen.dart';
import 'package:myapplication/src/repository/authentication_repository/AuthenticationRepository.dart';

class MockAuthenticationRepository extends GetxController with Mock implements AuthenticationRepository {}

void main() {
  setUp(() {
    Get.reset(); // Reset GetX bindings
    Get.put<AuthenticationRepository>(MockAuthenticationRepository());
  });

  group('OTPController', () {
    late OTPController otpController;
    late MockAuthenticationRepository mockRepository;
    setUp(() {
      otpController = OTPController();
      mockRepository = Get.find<MockAuthenticationRepository>();
    });

    test('phoneNumAuthentication should call phoneAuthentication method of AuthenticationRepository', () {
      const phoneNumber = '12345678';
      otpController.phoneNum.text = phoneNumber;
      otpController.phoneNumAuthentication();
      verify(mockRepository.phoneAuthentication('+65$phoneNumber')).called(1);
    });

    test('emailAuthentication should call emailAuthentication method of AuthenticationRepository', () {
      const email = 'test@example.com';
      otpController.email.text = email;
      otpController.emailAuthentication();
      verify(mockRepository.emailAuthentication(email)).called(1);
    });

    test('verifyOTP should navigate to SignUpScreen when OTP is verified', () async {
      const otp = '123456';
      when(mockRepository.verifyOTP(otp,'')).thenAnswer((_) async => true);
      await Future.delayed(Duration.zero, () async {
        otpController.verifyOTP(otp,'');
      });
      verify(mockRepository.verifyOTP(otp,'')).called(1);
      verify(Get.offAll(const SignUpScreen())).called(1);
    });

    test('verifyOTP should go back when OTP is not verified', () async {
      const otp = '123456';
      when(mockRepository.verifyOTP(otp,'')).thenAnswer((_) async => false);
      await Future.delayed(Duration.zero, () async {
        otpController.verifyOTP(otp,'');
      });
      verify(mockRepository.verifyOTP(otp,'')).called(1);
      verify(Get.back()).called(1);
    });
  });
}
