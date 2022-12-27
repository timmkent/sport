import 'package:flutter_sport/models/exercise.dart';
import 'package:flutter_sport/models/result.dart';
import 'package:flutter_sport/models/set_result.dart';
import 'package:flutter_sport/screens/workout_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import 'make_testable.dart';

final exercises = [
  Exercise(id: 'e1', name: 'dominadas', category: 'BACK'),
  Exercise(id: 'e2', name: 'exercise2', category: 'BACK'),
  Exercise(id: 'e3', name: 'exercise3', category: 'BACK'),
];

final results = [
  Result(index: 0, id: 'resultid1', exerciseId: 'e1', reps: 11, timestamp: 4711, weight: 30, setResultId: 'sr1'),
  Result(index: 1, id: 'resultid2', exerciseId: 'e2', reps: 11, timestamp: 4711, weight: 30, setResultId: 'sr1'),
  Result(index: 2, id: 'resultid3', exerciseId: 'e3', reps: 11, timestamp: 4711, weight: 30, setResultId: 'sr1'),
];

final setResults = [SetResult(id: 'sr1', timestamp: 4711, exerciseId: 'e1')];
void main() {
  testWidgets('Test exercise name is shown', (WidgetTester tester) async {
    final exercise = Exercise(id: 'e1', name: 'exerciseA', category: 'BRUST');
    final sut = WorkoutScreen(routineId: 'routineId', exercise: exercise, numberOfSets: 4);
    await tester.pumpWidget(makeTestable(child: sut, exercises: exercises, results: results, setResults: setResults));
    await tester.pumpAndSettle();
    expect(find.text('Exercise: exerciseA'), findsOneWidget);
  });

  testWidgets('Find not session if session is too old.', (WidgetTester tester) async {
    final exercise = Exercise(id: 'e1', name: 'exerciseA', category: 'BRUST');
    final sut = WorkoutScreen(routineId: 'routineId', exercise: exercise, numberOfSets: 4);
    await tester.pumpWidget(makeTestable(child: sut, exercises: exercises, results: results, setResults: setResults));
    await tester.pumpAndSettle();
    expect(find.text('0.0'), findsNothing);
    expect(find.text('active session found'), findsNothing);
  });

  testWidgets('Test 4 emtpy rows is shown if no entries exist but session of today', (WidgetTester tester) async {
    final exercise = Exercise(id: 'e1', name: 'exerciseA', category: 'BRUST');
    final sut = WorkoutScreen(routineId: 'routineId', exercise: exercise, numberOfSets: 4);
    final vorhinGeradeEben = DateTime.now().millisecondsSinceEpoch - 46000 * 1000;
    final setResults = [SetResult(id: 'sr1', timestamp: vorhinGeradeEben, exerciseId: 'e1')];
    final results = <Result>[];
    await tester.pumpWidget(makeTestable(child: sut, exercises: exercises, results: results, setResults: setResults));
    await tester.pumpAndSettle();
    expect(find.text('0.0'), findsNWidgets(4));
    expect(find.text('active session found'), findsNWidgets(1));
  });

  testWidgets('Test 3 emtpy row is shown if 1 entry exist for today', (WidgetTester tester) async {
    final exercise = Exercise(id: 'e1', name: 'exerciseA', category: 'BRUST');
    final sut = WorkoutScreen(routineId: 'routineId', exercise: exercise, numberOfSets: 4);
    final vorhinGeradeEben = DateTime.now().millisecondsSinceEpoch - 46000 * 1000;
    final setResults = [SetResult(id: 'sr1', timestamp: vorhinGeradeEben, exerciseId: 'e1')];
    final results = [
      Result(index: 0, id: 'resultid1', exerciseId: 'e1', reps: 11, timestamp: vorhinGeradeEben, weight: 30, setResultId: 'sr1'),
    ];
    await tester.pumpWidget(makeTestable(child: sut, exercises: exercises, results: results, setResults: setResults));
    await tester.pumpAndSettle();
    expect(find.text('active session found'), findsNWidgets(1));
    expect(find.text('sets completed 1'), findsNWidgets(1));
    expect(find.text('0.0'), findsNWidgets(3));
  });
}


