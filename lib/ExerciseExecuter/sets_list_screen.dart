import 'package:flutter/material.dart';
import 'package:flutter_sport/ExerciseExecuter/set_info.dart';
import 'package:flutter_sport/ExerciseExecuter/set_row.dart';
import 'package:provider/provider.dart';

class SetsListScreen extends StatelessWidget {
  const SetsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = Provider.of<SetInfo>(context, listen: true).exercises;
    final routineEntries = Provider.of<SetInfo>(context, listen: true).routineEntries;
    final routines = Provider.of<SetInfo>(context, listen: true).routines;
    var routineName = '';
    if (routines.isNotEmpty) routineName = routines.first.name;
    var currentExerciseName = '';
    if (routines.isNotEmpty && routineEntries.isNotEmpty && exercises.isNotEmpty) {
      final currentExerciseId = Provider.of<SetInfo>(context, listen: true).currentExerciseId;
      debugPrint('currentExerciseId $currentExerciseId');
      currentExerciseName = exercises.where((element) => element.id == currentExerciseId).first.name;
    }

    // final firstRoutineId = routines.first;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('Routine Name: $routineName'),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    Provider.of<SetInfo>(context, listen: false).changeExerciseIdPrev();
                  },
                  child: const Text('prev')),
              Text('Exercise Name: $currentExerciseName'),
              TextButton(
                  onPressed: () {
                    Provider.of<SetInfo>(context, listen: false).changeExerciseIdNext();
                  },
                  child: const Text('next'))
            ],
          ),
          const SetRow(index: 0),
          const SetRow(index: 1),
          const SetRow(index: 2),
        ],
      ),
    );
  }
}
