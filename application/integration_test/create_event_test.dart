import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:myapplication/main.dart' as app;

//https://docs.flutter.dev/cookbook/testing/integration/introduction

void main() {
  group('Test Create Event Feature', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Create Event', (tester) async {
      // Load our appplication
      app.main();
      await tester.pumpAndSettle();
    });
  });
}
