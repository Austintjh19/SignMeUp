import 'package:flutter_test/flutter_test.dart';
//import 'package:auth_repository/auth_repository.dart';
// the import above is bugged for me for some reason so i changed it to the following
import '../lib/auth_repository.dart';

void main() {
  test('adds one to input values', () {
    final calculator = Calculator();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });
}
