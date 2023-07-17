import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:myapplication/main.dart' as app;

//https://docs.flutter.dev/cookbook/testing/integration/introduction

void main() {
  group('Test Messaging Feature', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Automatically added to group after sign up', (tester) async {
      // Load our appplication
      app.main();
      await tester.pumpAndSettle();
    });

    testWidgets('Able to send messages', (tester) async {
      // Load our appplication
      app.main();
      await tester.pumpAndSettle();
    });

    testWidgets('Able to receive messages', (tester) async {
      // Load our appplication
      app.main();
      await tester.pumpAndSettle();
    });
  });
}
