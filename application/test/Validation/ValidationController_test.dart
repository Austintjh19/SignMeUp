import 'package:flutter_test/flutter_test.dart';
import 'package:myapplication/src/controllers/ValidationController.dart';

void main() {
  group('ValidationController', () {
    late ValidationController validationController;

    setUp(() {
      validationController = ValidationController();
    });

    group('validateEmail', () {
      test('should return an error message when value is empty', () {
        final result = validationController.validateEmail('');
        expect(result, 'Please enter Email');
      });

      test('should return an error message when value is not a valid email', () {
        final result = validationController.validateEmail('haitaowang_not_valid_email');
        expect(result, 'Invalid Email Entered');
      });

      test('should return null when value is a valid email', () {
        final result = validationController.validateEmail('valid_email@example.com');
        expect(result, isNull);
      });
    });

    group('validateSignInPassword', () {
      test('should return an error message when value is empty', () {
        final result = validationController.validateSignInPassword('');
        expect(result, 'Password is required');
      });

      test('should return null when value is not empty', () {
        final result = validationController.validateSignInPassword('example_password');
        expect(result, isNull);
      });
    });

    tearDown(() {
      // Clean up any resources if needed
    });
  });
}
