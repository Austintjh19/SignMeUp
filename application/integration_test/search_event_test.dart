import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:myapplication/main.dart' as app;

//https://docs.flutter.dev/cookbook/testing/integration/introduction

void main() {
  group('Test Search Event Feature', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Search Event By Name', (tester) async {
      // Load our appplication
      app.main();
      await tester.pumpAndSettle();
    });

    testWidgets('Search Event By Location', (tester) async {
      // Load our appplication
      app.main();
      await tester.pumpAndSettle();
    });

    testWidgets('Filter - By Date Descending', (tester) async {
      // Load our appplication
      app.main();
      await tester.pumpAndSettle();
    });
  });
}
