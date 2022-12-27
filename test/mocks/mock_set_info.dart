import 'package:flutter/foundation.dart';
import 'package:flutter_sport/ExerciseExecuter/set_info.dart';
import 'package:flutter_sport/models/exercise.dart';
import 'package:flutter_sport/models/result.dart';
import 'package:flutter_sport/models/routine.dart';
import 'package:flutter_sport/models/routine_entry.dart';
import 'package:flutter_sport/models/set_result.dart';

class MockSetInfo extends ChangeNotifier implements BaseSetInfo {
  MockSetInfo({required this.exercises, required this.results, required this.setResults});
  @override
  List<Exercise> exercises;

  @override
  List<RoutineEntry> routineEntries = [
    RoutineEntry(id: 're1', position: 0, exerciseId: 'e1', numberOfSets: 4, routineId: 'routine1'),
    RoutineEntry(id: 're2', position: 1, exerciseId: 'e2', numberOfSets: 3, routineId: 'routine2'),
  ];

  @override
  String routineId = '';

// Der Tag z.B. "Chest Day"
  @override
  List<Routine> routines = [Routine(id: 'routine1', name: 'Chest Day')];

// Der name der Uebung z.B. Dominadas
  @override
  List<SetResult> setResults;

// Die Ergebnisse (index ist der Satz)
  @override
  List<Result> results;

  @override
  void saveAsDone(String setResultId, int position, int reps, double weight, int timestamp, String exerciseId) {
    // TODO: implement saveAsDone
  }
}
