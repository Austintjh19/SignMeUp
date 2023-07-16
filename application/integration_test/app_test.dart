import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:myapplication/main.dart' as app;

//https://docs.flutter.dev/cookbook/testing/integration/introduction

void main() {
  group('Sign In Page', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Test Valid Sign In', (tester) async {
      // Load our appplication
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle();

      final signedIn = find.text('Welcome Back !');
      expect(signedIn, findsOneWidget);
    });

    testWidgets('Test Invalid Sign In', (tester) async {
      // Load our appplication
      app.main();
      await tester.pumpAndSettle();

      // Test Valid Sign In
      final emailFormField = find.byType(TextFormField).first;
      final passwordFormField = find.byType(TextFormField).last;

      final signInButton = find.byType(ElevatedButton).last;

      await tester.enterText(emailFormField, 'user1@gmail.com');
      await tester.enterText(passwordFormField, '12345678');
      await tester.pumpAndSettle();

      await tester.tap(signInButton);
      await tester.pumpAndSettle();

      final signedIn = find.text('Error');
      expect(signedIn, findsOneWidget);
      await tester.pumpAndSettle();
    });
  });
}
