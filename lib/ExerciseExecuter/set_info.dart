import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sport/firebase/fbservice.dart';
import 'package:flutter_sport/models/exercise.dart';
import 'package:flutter_sport/models/routine_entry.dart';
import 'package:flutter_sport/models/set_result.dart';
import 'package:uuid/uuid.dart';

import '../models/result.dart';
import '../models/routine.dart';

abstract class BaseSetInfo extends ChangeNotifier {
  String routineId = '';
  List<RoutineEntry> routineEntries = [];
  List<Exercise> exercises = [];
  List<Routine> routines = [];
  List<Result> results = [];
  List<SetResult> setResults = [];
  void saveAsDone(String setResultId, int position, int reps, double weight, int timestamp, String exerciseId);
}

class SetInfo extends ChangeNotifier implements BaseSetInfo {
  // erstmal muessen wir hier die gewuentschte Routine auswaehlen und uns dazu die exercises holen

  @override
  String routineId = '';
  @override
  List<RoutineEntry> routineEntries = [];
  @override
  List<Exercise> exercises = [];
  @override
  List<Routine> routines = [];
  @override
  List<Result> results = [];
  @override
  List<SetResult> setResults = [];

  SetInfo() {
    observceAllExercises();
    observceAllRoutines();
    observceAllRoutineEntries();
    observceAllResults();
    observceAllSetResults();
  }
  void observceAllExercises() {
    FBService().observeExercises().listen((event) {
      exercises = event;
      debugPrint('Number of exercises loaded: ${exercises.length}');
      notifyListeners();
    });
    // FirebaseDatabase.instance.ref('exercises').onValue.listen((event) {
    //   exercises = event.snapshot.children.map((e) => Exercise.fromMap(e.value as Map<Object?, Object?>)).toList();
    //   debugPrint('Number of exercises loaded: ${exercises.length}');
    //   notifyListeners();
    // });
  }

  void observceAllRoutines() {
    FirebaseDatabase.instance.ref('routines').onValue.listen((event) {
      routines = event.snapshot.children.map((e) => Routine.fromSnap(e)).toList();
      debugPrint('Number of routines loaded: ${routines.length}');
      notifyListeners();
    });
  }

  void observceAllRoutineEntries() {
    FirebaseDatabase.instance.ref('routineEntries').onValue.listen((event) {
      routineEntries = event.snapshot.children.map((e) => RoutineEntry.fromSnap(e)).toList();
      debugPrint('Number of routineEntries loaded: ${routineEntries.length}');
      notifyListeners();
    });
  }

  void observceAllResults() {
    FirebaseDatabase.instance.ref('results').onValue.listen((event) {
      results = event.snapshot.children.map((e) => Result.fromSnap(e)).toList();
      debugPrint('Number of results loaded: ${results.length}');
      notifyListeners();
    });
  }

  void observceAllSetResults() {
    FirebaseDatabase.instance.ref('setresults').onValue.listen((event) {
      setResults = event.snapshot.children.map((e) => SetResult.fromSnap(e)).toList();
      debugPrint('Number of results loaded: ${results.length}');
      notifyListeners();
    });
  }

  int currentExerciseIndex = 0;
  List<double> weights = [0.0, 0.0, 0.0];
  List<int> reps = [0, 0, 0];
  List<bool> isDone = [false, false, false];
  int index = 0;

  String get currentExerciseId {
    if (routineEntries.length > currentExerciseIndex) {
      return routineEntries[currentExerciseIndex].exerciseId;
    } else {
      return '';
    }
  }

  void changeExerciseIdNext() {
    if (currentExerciseIndex < routineEntries.length - 1) {
      currentExerciseIndex++;
      notifyListeners();
    }
  }

  void changeExerciseIdPrev() {
    if (currentExerciseIndex > 0) {
      currentExerciseIndex--;
      notifyListeners();
    }
  }

  void changeWeight(double newValue, int index) {
    weights[index] = newValue;
    notifyListeners();
  }

  void changeReps(int newValue, int index) {
    reps[index] = newValue;
    notifyListeners();
  }

  void toggleIsDone(int index) {
    isDone[index] = !isDone[index];
    notifyListeners();
  }

  @override
  void saveAsDone(String setResultId, int position, int reps, double weight, int timestamp, String exerciseId) {
    final id = const Uuid().v1();
    FirebaseDatabase.instance.ref('results').push().update({'id': id, 'setResultId': setResultId, 'position': position, 'reps': reps, 'weight': weight, 'timestamp': timestamp});
  }

  void saveNewSetResult(String setResultId, String exerciseId, int timestamp) {
    FirebaseDatabase.instance.ref('setresults').push().update({'id': setResultId, 'exerciseId': exerciseId, 'timestamp': timestamp});
  }
}
