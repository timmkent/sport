import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class RoutineEntry {
  RoutineEntry({required this.id, required this.position, required this.exerciseId, required this.numberOfSets, required this.routineId});
  final String id;
  final String exerciseId;
  final String routineId;
  final int numberOfSets;
  final int position;

  static createNew({required int position, required String exerciseId, required int numberOfSets, required String routineId}) {
    final id = const Uuid().v1();
    return RoutineEntry(id: id, position: position, exerciseId: exerciseId, numberOfSets: numberOfSets, routineId: routineId);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'position': position,
      'exerciseId': exerciseId,
      'numberOfSets': numberOfSets,
      'routineId': routineId,
    };
  }

  static RoutineEntry fromSnap(DataSnapshot snap) {
    final map = snap.value as Map<Object?, Object?>;
    return RoutineEntry.fromMap(map);
  }

  static RoutineEntry fromMap(Map<Object?, Object?> map) {
    return RoutineEntry(id: map['id'] as String, position: map['position'] as int, exerciseId: map['exerciseId'] as String, routineId: map['routineId'] as String, numberOfSets: map['numberOfSets'] as int);
  }
}
