import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_sport/models/exercise.dart';

class FBService {
  Future<void> saveExercise(Exercise exercise) async {
    // final uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseDatabase.instance.ref('exercises').child(exercise.id).update(exercise.toMap());
  }

  Stream<List<Exercise>> observeExercises() {
    return FirebaseDatabase.instance.ref('exercises').onValue.map((event) => event.snapshot.children.map((e) => Exercise.fromSnap(e)).toList());
  }
}
