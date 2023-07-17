import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:myapplication/main.dart' as app;

//https://docs.flutter.dev/cookbook/testing/integration/introduction

void main() {
  group('Test Sign In', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Google Sign In', (tester) async {
      // Load our appplication
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle();

      final signedIn = find.textContaining('Welcome');
      expect(signedIn, findsOneWidget);
      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('Facebook Sign In', (tester) async {
      // Load our appplication
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.textContaining('Facebook'));
      await tester.pumpAndSettle();

      final signedIn = find.textContaining('Welcome');
      expect(signedIn, findsOneWidget);
      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('Email & Password Sign In', (tester) async {
      // Load our appplication
      app.main();
      await tester.pumpAndSettle();

      final emailField = find.byType(TextFormField).first;
      final passwordField = find.byType(TextFormField).last;

      await tester.enterText(emailField, 'supabase@gmail.com');
      await tester.pumpAndSettle();

      await tester.enterText(passwordField, 'P@ssword123');
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton).last);
      await tester.pumpAndSettle();

      final signedIn = find.textContaining('Welcome');
      expect(signedIn, findsOneWidget);
      await tester.pump(const Duration(seconds: 2));
    });
  });
}
