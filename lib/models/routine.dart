import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class Routine {
  Routine({required this.id, required this.name});
  final String id;
  final String name;

  static createNew({required String name, required Set<String> exerciseIds}) {
    final id = const Uuid().v1();
    return Routine(id: id, name: name);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  static Routine fromMap(Map<Object?, Object?> map) {
    return Routine(id: map['id'] as String, name: map['name'] as String);
  }

  static Routine fromSnap(DataSnapshot snap) {
    final map = snap.value as Map<Object?, Object?>;
    return Routine.fromMap(map);
  }
}

// consists of exercise, number of sets and position
