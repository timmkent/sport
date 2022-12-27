import 'package:flutter_sport/models/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Result Code/Encode', () {
    final sut = Result(index: 0, id: 'id', exerciseId: 'exerciseId', reps: 0, timestamp: 0, weight: 0.0, setResultId: 'setResultId');
    final map = sut.toMap();
    final result = Result.fromMap(map);
    expect(sut.index, result.index);
    expect(sut.id, result.id);
    expect(sut.exerciseId, result.exerciseId);
    expect(sut.reps, result.reps);
    expect(sut.timestamp, result.timestamp);
    expect(sut.weight, result.weight);
    expect(sut.setResultId, result.setResultId);
  });
}
