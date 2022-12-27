import 'package:flutter_sport/models/exercise.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Exercise Code/Encode', () {
    final exercise = Exercise(id: 'e1', name: 'exerciseA', category: 'BRUST');
    final map = exercise.toMap();
    final result = Exercise.fromMap(map);
    expect(exercise.category, result.category);
    expect(exercise.id, result.id);
    expect(exercise.name, result.name);    
  });
}
