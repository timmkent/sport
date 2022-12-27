import 'package:flutter/material.dart';
import 'package:flutter_sport/ExerciseExecuter/set_info.dart';
import 'package:flutter_sport/models/exercise.dart';
import 'package:flutter_sport/models/result.dart';
import 'package:flutter_sport/models/set_result.dart';
import 'package:flutter_sport/provider/pausen_timer.dart';
import 'package:provider/provider.dart';

import 'mocks/mock_pausen_timer.dart';
import 'mocks/mock_set_info.dart';

final defaultExercises = [
  Exercise(id: 'e1', name: 'dominadas', category: 'BACK'),
  Exercise(id: 'e2', name: 'exercise2', category: 'BACK'),
  Exercise(id: 'e3', name: 'exercise3', category: 'BACK'),
];

final defaultResults = [
  Result(index: 0, id: 'resultid1', exerciseId: 'e1', reps: 11, timestamp: 4711, weight: 30, setResultId: 'sr1'),
  Result(index: 1, id: 'resultid2', exerciseId: 'e2', reps: 11, timestamp: 4711, weight: 30, setResultId: 'sr1'),
  Result(index: 2, id: 'resultid3', exerciseId: 'e3', reps: 11, timestamp: 4711, weight: 30, setResultId: 'sr1'),
];

final defaultSetResults = [SetResult(id: 'sr1', timestamp: 4711, exerciseId: 'e1')];

Widget makeTestable({
  required Widget child,
  List<Exercise>? exercises,
  List<Result>? results,
  List<SetResult>? setResults,
  BasePausenTimer? pausenTimer,
}) {
  
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<BaseSetInfo>(create: ((context) => MockSetInfo(
        exercises: exercises ?? defaultExercises, 
        results: results ?? defaultResults, 
        setResults: setResults ?? defaultSetResults))),
      ChangeNotifierProvider<BasePausenTimer>(create: ((context) => pausenTimer ?? MockPausenTimer())),
    ],
    child: MaterialApp(
      home: child,
    ),
  );
}
