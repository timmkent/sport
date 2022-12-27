import 'package:firebase_database/firebase_database.dart';

class Result {
  Result({required this.index, required this.id, required this.exerciseId, required this.reps, required this.timestamp, required this.weight, required this.setResultId});
  final int index;
  final String id;
  final String exerciseId;
  final String setResultId;
  final int timestamp;
  final int reps;
  final double weight;

  // static createNew({required String exerciseId, required int reps, required int timestamp, required double weight}) {
  //   final id = const Uuid().v1();
  //   return Result(id: id, exerciseId: exerciseId, timestamp: timestamp, weight: weight, reps: reps);
  // }

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'id': id, 
      'exerciseId': exerciseId, 
      'timestamp': timestamp, 
      'weight': weight, 
      'reps': reps, 
      'setResultId': setResultId};
  }

  static Result fromMap(Map<Object?, Object?> map) {
    return Result(
      id: map['id'] as String,
      index: map['index'] as int, // todo with is actually in with set of the exerecise it occured
      exerciseId: map['exerciseId'] as String,
      setResultId: map['setResultId'] as String,
      timestamp: map['timestamp'] as int,
      weight: (map['weight'] as num).toDouble(),
      reps: map['reps'] as int,
    );
  }

  static Result fromSnap(DataSnapshot snap) {
    final map = snap.value as Map<Object?, Object?>;
    return Result.fromMap(map);
  }

  double get tenRepPerformance {
    return 10 * weight / reps.toDouble();
  }
}

