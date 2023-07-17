import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:myapplication/main.dart' as app;
import 'package:myapplication/src/features/authentication/screens/sign_up/SignUpScreen.dart';

//https://docs.flutter.dev/cookbook/testing/integration/introduction

void main() {
  Widget _signUp() {
    return const MaterialApp(
      home: SignUpScreen(),
    );
  }

  group('Test Sign Up', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Sign Up', (tester) async {
      // Load our appplication
      app.main();
      await tester.pumpAndSettle();

      // await tester.pumpWidget(_signUp());
      // await tester.pumpAndSettle();

      // final name = find.textContaining('Name');
      // final username = find.textContaining('Username');
      // final email = find.textContaining('Email');
      // final password1 = find.textContaining('Enter Password');
      // final password2 = find.textContaining('Confirm Password');
      // final continueButton = find.textContaining('Continue');
      // final bio = find.textContaining('Description');
      // final createButton = find.textContaining('Create');

      // await tester.enterText(name, 'User 100');
      // await tester.pumpAndSettle();

      // await tester.enterText(username, 'User100');
      // await tester.pumpAndSettle();

      // await tester.enterText(email, 'user100@gmail.com');
      // await tester.pumpAndSettle();

      // await tester.enterText(password1, 'P@ssword123');
      // await tester.pumpAndSettle();

      // await tester.enterText(password2, 'P@ssword123');
      // await tester.pumpAndSettle();

      // await tester.tap(continueButton);
      // await tester.pumpAndSettle();

      // await tester.enterText(bio, 'Sup man.');
      // await tester.pumpAndSettle();

      // await tester.tap(createButton);
      // await tester.pumpAndSettle();

      // final signedIn = find.textContaining('Welcome');
      // expect(signedIn, findsOneWidget);
      // await tester.pump(const Duration(seconds: 2));
    });
  });
}
