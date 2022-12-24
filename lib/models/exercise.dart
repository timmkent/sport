import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class Exercise {
  Exercise({required this.id, required this.name, required this.tags});
  final String id;
  final String name;
  final List<String> tags;

  static createNew({required String name, required List<String> tags}) {
    final id = const Uuid().v1();
    return Exercise(id: id, name: name, tags: tags);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'tags': tags};
  }

  static Exercise fromSnap(DataSnapshot snap) {
    final map = snap.value as Map<Object?, Object?>;
    print(map);
    final exercise = Exercise(id: map['id'] as String, name: map['name'] as String, tags: ['kkk']);
    return exercise;
  }
}
