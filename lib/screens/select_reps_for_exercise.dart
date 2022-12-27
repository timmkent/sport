import 'package:flutter/material.dart';
import 'package:flutter_sport/firebase/fbservice.dart';
import 'package:flutter_sport/models/exercise.dart';
import 'package:flutter_sport/models/routine.dart';
import 'package:flutter_sport/models/routine_entry.dart';
import 'package:provider/provider.dart';

class SelectRepsForExercise extends StatelessWidget {
  const SelectRepsForExercise({super.key, required this.exercise, required this.routineId, required this.position});
  final Exercise exercise;
  final String routineId;
  final int position;

  @override
  Widget build(BuildContext context) {
    final fbService = Provider.of<FBService>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
            children: [3, 4, 5, 6]
                .map((e) => ElevatedButton(
                    onPressed: () {
                      final exerciseId = exercise.id;
                      debugPrint("Now creating RoutineEntry $exerciseId, with reps count: $e");
                      final routineEntry = RoutineEntry.createNew(position: position, exerciseId: exerciseId, numberOfSets: e, routineId: routineId);
                      fbService.saveRoutineEntry(routineEntry);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text(e.toString())))
                .toList()),
      ),
    );
  }
}
