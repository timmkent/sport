import 'package:flutter_sport/models/set_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('SetResult Code/Encode', () {
    final sut = SetResult(id: 'id', timestamp: 4711, exerciseId: 'exerciseId');
    final map = sut.toMap();
    final result = SetResult.fromMap(map);
    expect(sut.id, result.id);
    expect(sut.timestamp, result.timestamp);
    expect(sut.exerciseId, result.exerciseId);
  });
}
