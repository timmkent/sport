import 'package:flutter/material.dart';
import 'package:flutter_sport/screens/exercise_row.dart';
import 'package:flutter_test/flutter_test.dart';

import 'make_testable.dart';
import 'mocks/mock_pausen_timer.dart';

void main() {
  testWidgets('if done false, start timer when done is pressed', (WidgetTester tester) async {
    final mockPausenTimer = MockPausenTimer();
    const sut = Material(child: ExerciseSetRow(setNumber: 0, weight: 0.0, reps: 0, done: false, setResultId: '', exerciseId: ''));
    await tester.pumpWidget(makeTestable(child: sut, pausenTimer: mockPausenTimer));
    await tester.pumpAndSettle();
    expect(find.text('done'), findsWidgets);
    await tester.tap(find.text('done').first);
    expect(mockPausenTimer.startCountdownWasCalled, true);
  });
}
