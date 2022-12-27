import 'package:firebase_database/firebase_database.dart';

class SetResult {
  SetResult({required this.id, required this.timestamp, required this.exerciseId});
  final String exerciseId;
  final String id;
  final int timestamp;
  
  Map<String, dynamic> toMap() {
    return {'exerciseId': exerciseId, 'id': id, 'timestamp':timestamp};
  }
  static fromMap(Map<Object?, Object?> map) {
    return SetResult(
      id: map['id'] as String,
      exerciseId: map['exerciseId'] as String,
      timestamp: map['timestamp'] as int,
    );
  }
  static SetResult fromSnap(DataSnapshot snap) {
    final map = snap.value as Map<Object?, Object?>;
    return SetResult.fromMap(map);
  }
}
