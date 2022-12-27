import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class Exercise {
  Exercise({required this.id, required this.name, required this.category});
  final String id;
  final String name;
  final String category;

  static createNew({required String name, required String category}) {
    final id = const Uuid().v1();
    return Exercise(id: id, name: name, category: category);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'category': category};
  }

  static Exercise fromMap(Map<Object?, Object?> map) {
    final exercise = Exercise(id: map['id'] as String, name: map['name'] as String, category: map['category'] as String? ?? 'REST');
    return exercise;
  }
}
