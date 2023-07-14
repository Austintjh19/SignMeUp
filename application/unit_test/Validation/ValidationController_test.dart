import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/controllers/ValidationController.dart';

void main() {
  group('Test ValidationController', () {
    late ValidationController validationController;

    setUpAll(() {
      validationController = Get.put(ValidationController());
    });

    group('Test Email Validation', () {
      test('Empty String Handling', () {
        final output = validationController.validateEmail('');
        expect(output, 'Please enter Email');
      });

      test('Invalid Email Handling', () {
        var result = validationController.validateEmail('a');
        expect(result, 'Invalid Email Entered');
        result = validationController.validateEmail('@');
        expect(result, 'Invalid Email Entered');
        result = validationController.validateEmail('@gmail');
        expect(result, 'Invalid Email Entered');
        result = validationController.validateEmail('@gmail.com');
        expect(result, 'Invalid Email Entered');
        result = validationController.validateEmail('.com');
        expect(result, 'Invalid Email Entered');
      });

      test('Valid Email Handling', () {
        var result = validationController.validateEmail('a@gmail.com');
        expect(result, isNull);
        result = validationController.validateEmail('a@yahoo.com');
        expect(result, isNull);
        result = validationController.validateEmail('a@outlook.edu');
        expect(result, isNull);
      });
    });

    group('Test Sign In Password Validation', () {
      test('Empty Password', () {
        final result = validationController.validateSignInPassword('');
        expect(result, 'Password is required');
      });

      test('Valid Password', () {
        var result = validationController.validateSignInPassword('1234567');
        expect(result, isNull);
        result = validationController.validateSignInPassword('Password');
        expect(result, isNull);
      });
    });

    group('Test Sign Up Password Validation', () {
      test('Empty Password', () {
        final result = validationController.validateSignUpPassword('');
        expect(result, 'Password is required');
      });

      test('Invalid Password Length', () {
        var result = validationController.validateSignUpPassword('1234567');
        expect(result, 'Password Must be more than 7 characters');
      });

      test('Invalid Password', () {
        var result = validationController.validateSignUpPassword('password');

        expect(
            result, '1 Upper, 1 Lower, 1 Digit & 1 Special Character needed');
        result = validationController.validateSignUpPassword('password123');
        expect(
            result, '1 Upper, 1 Lower, 1 Digit & 1 Special Character needed');
        result = validationController.validateSignUpPassword('Password');
        expect(
            result, '1 Upper, 1 Lower, 1 Digit & 1 Special Character needed');
        result = validationController.validateSignUpPassword('Password123');
        expect(
            result, '1 Upper, 1 Lower, 1 Digit & 1 Special Character needed');
        result = validationController.validateSignUpPassword('p@ssword');
        expect(
            result, '1 Upper, 1 Lower, 1 Digit & 1 Special Character needed');
        result = validationController.validateSignUpPassword('P@ssword');
        expect(
            result, '1 Upper, 1 Lower, 1 Digit & 1 Special Character needed');
        result = validationController.validateSignUpPassword('p@ssword123');
        expect(
            result, '1 Upper, 1 Lower, 1 Digit & 1 Special Character needed');
      });

      test('Valid Password', () {
        var result = validationController.validateSignUpPassword('P@ssword123');
        expect(result, isNull);
        result = validationController.validateSignUpPassword('pa\$\$worD321');
        expect(result, isNull);
      });
    });

    group('Phone Numeber Validation', () {
      test('Empty String Handling', () {
        final output = validationController.validatePhoneNum('');
        expect(output, 'Please enter Phone Number');
      });

      test('Invalid Phone Number Handling', () {
        var output = validationController.validatePhoneNum('ABCD');
        expect(output, 'Invalid Phone Number Entered');
        output = validationController.validatePhoneNum('+12323');
        expect(output, 'Invalid Phone Number Entered');
        output = validationController.validatePhoneNum('ABCD1231232');
        expect(output, 'Invalid Phone Number Entered');
        output = validationController.validatePhoneNum('9777 7777');
        expect(output, 'Invalid Phone Number Entered');
      });

      test('Valid Phone Number Handling', () {
        var output = validationController.validatePhoneNum('97407876');
        expect(output, isNull);
      });
    });

    group('Name Validation', () {
      test('Empty String Handling', () {
        final output = validationController.validateName('');
        expect(output, 'Please enter Your Name');
      });

      test('Invalid Name Handling', () {
        var output = validationController.validateName('ABCD ');
        expect(output, 'Invalid Name Entered');
      });

      test('Valid Name Handling', () {
        var output = validationController.validateName('Austin Tan');
        expect(output, isNull);
      });
    });

    group('Usename Validation', () {
      test('Empty String Handling', () {
        final output = validationController.validateUsername('');
        expect(output, 'Please enter a Username');
      });

      test('Invalid Name Handling', () {
        var output = validationController.validateUsername('ABCD ');
        expect(output, 'Invalid Username Entered');
      });

      test('Valid Name Handling', () {
        var output = validationController.validateUsername('Austin Tan');
        expect(output, isNull);
      });
    });
  });

  tearDown(() {});
}
