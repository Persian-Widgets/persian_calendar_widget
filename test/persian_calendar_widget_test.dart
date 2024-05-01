import 'package:flutter_test/flutter_test.dart';

import 'package:persian_calendar_widget/persian_calendar_widget.dart';

void main() {
  test('adds one to input values', () {
    final calculator = Calculator();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });
}
