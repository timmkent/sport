import 'package:flutter_sport/models/routine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Routine Code/Encode', () {
    final sut = Routine(id: 'id', name: 'name');
    final map = sut.toMap();
    final result = Routine.fromMap(map);
    expect(sut.name, result.name);
    expect(sut.id, result.id);
  });
}
