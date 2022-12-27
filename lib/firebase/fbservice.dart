import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_sport/models/exercise.dart';
import 'package:flutter_sport/models/routine.dart';
import 'package:flutter_sport/models/routine_entry.dart';
import 'package:uuid/uuid.dart';

class FBService {
  Future<void> saveExercise(Exercise exercise) async {
    // final uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseDatabase.instance.ref('exercises').child(exercise.id).update(exercise.toMap());
  }

  Stream<List<Exercise>> observeExercises() {

    
    return FirebaseDatabase.instance.ref('exercises')
    .onValue.map((event) => event.snapshot.children.map((e) => Exercise.fromMap(e.value as Map<Object?, Object?>)).toList());
  }

  Future<Exercise> getExercise(String id) {
    return FirebaseDatabase.instance.ref('exercises/$id').get()
    .then((snap) => Exercise.fromMap(snap.value as Map<Object?, Object?>));
  }

  Stream<List<Routine>> observeRoutines() {
    return FirebaseDatabase.instance.ref('routines')
    .onValue.map((event) => event.snapshot.children.map((snap) => Routine.fromMap(snap.value as Map<Object?, Object?>)).toList());
  }

  Future<void> saveRoutine(Exercise exercise) async {
    // final uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseDatabase.instance.ref('exercises').child(exercise.id).update(exercise.toMap());
  }

  Future<void> saveRoutineEntry(RoutineEntry routineEntry) async {
    // final uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseDatabase.instance.ref('routineEntries').child(routineEntry.id).update(routineEntry.toMap());
  }

  Future<void> createNewRoutine(String name) async {
    final id = const Uuid().v1();
    FirebaseDatabase.instance.ref('routines').child(id).update({'id': id, 'name': name});
  }

  Stream<List<RoutineEntry>> observeRoutineEntries({required String routineId}) {
    return FirebaseDatabase.instance.ref('routineEntries').child(routineId)
    .onValue.map((event) => event.snapshot.children.map((snap) => RoutineEntry.fromMap(snap.value as Map<Object?,Object?>)).toList());
  }

  Future<List<RoutineEntry>> getRoutineEntries({required String routineId}) async {
    return FirebaseDatabase.instance.ref('routineEntries').child(routineId).get().then((value) => value.children.map((e) => RoutineEntry.fromSnap(e)).toList());
  }
}
