import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class Routine {
  Routine({required this.id, required this.name, required this.exerciseIds});
  final String id;
  final String name;
  final Set<String> exerciseIds;

  static createNew({required String name, required Set<String> exerciseIds}) {
    final id = const Uuid().v1();
    return Routine(id: id, name: name, exerciseIds: exerciseIds);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'exerciseIds': exerciseIds};
  }

  static fromSnap(DataSnapshot snap) {
    final map = snap.value as Map<Object?, Object?>;
    return Routine(id: map['id'] as String, name: map['name'] as String, exerciseIds: map['exerciseIds'] as Set<String>);
  }
}
