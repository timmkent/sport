import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sport/ExerciseExecuter/set_info.dart';
import 'package:flutter_sport/models/result.dart';
import 'package:flutter_sport/screens/select_category.dart';
import 'package:flutter_sport/screens/workout_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/exercise.dart';

// put position in DB on adding new exercise

class RoutineManager extends StatelessWidget {
  const RoutineManager({super.key, required this.routineId});
  final String routineId;

  @override
  Widget build(BuildContext context) {
    final allRoutineEntries = Provider.of<BaseSetInfo>(context, listen: true).routineEntries;
    final allExercises = Provider.of<BaseSetInfo>(context, listen: true).exercises;
    final results = Provider.of<BaseSetInfo>(context, listen: true).results;

    Result? lastEntryDateForExercise(Exercise exercise) {
      final resultsForSpecificExercise = results.where((element) => element.exerciseId == exercise.id).toList();
      resultsForSpecificExercise.sort(((a, b) => a.timestamp.compareTo(b.timestamp)));
      for (var result in resultsForSpecificExercise) {
        debugPrint('Id: ${result.exerciseId} ${result.timestamp}');
      }
      if (resultsForSpecificExercise.isNotEmpty) {
        return resultsForSpecificExercise.last;
      }
      return null;
    }

    final routineEntries = allRoutineEntries
        .where(
          (element) => element.routineId == routineId,
        )
        .toList(); //.sort(((a, b) => a.position.compareTo(b.position)));
    routineEntries.sort((a, b) => a.position.compareTo(b.position));

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                    return SelectCategoryScreen(
                      newPosition: routineEntries.length,
                      routineId: routineId,
                    );
                  })));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: SafeArea(
          child: ReorderableListView(
              onReorder: (int oldIndex, int newIndex) {
                // TODO nach FBService packen
                FirebaseDatabase.instance.ref('routineEntries').child(routineEntries[oldIndex].id).update({'position': routineEntries[newIndex].position});
                FirebaseDatabase.instance.ref('routineEntries').child(routineEntries[newIndex].id).update({'position': routineEntries[oldIndex].position});
              },
              children: routineEntries.map((e) {
                final exercise = allExercises.where((element) => e.exerciseId == element.id);
                var exerciseName = '';
                var lastResultDateString = '...';
                var exerciseId = '';
                if (exercise.isNotEmpty) {
                  exerciseName = exercise.first.name;
                  exerciseId = exercise.first.id;
                  final lastResult = lastEntryDateForExercise(exercise.first);
                  final lastResultDateTime = DateTime.fromMillisecondsSinceEpoch(lastResult?.timestamp ?? 0);
                  lastResultDateString = DateFormat('yyyy-MM-dd HH:mm:ss').format(lastResultDateTime).toString();
                }

                return Dismissible(
                  key: Key(e.id),
                  onDismissed: (direction) {
                    debugPrint("Dismissing ${e.id}");
                    FirebaseDatabase.instance.ref('routineEntries').child(e.id).remove();
                  },
                  child: InkWell(
                    onTap: (() {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return WorkoutScreen(routineId: routineId, exercise: exercise.first, numberOfSets: e.numberOfSets);
                      }));
                    }),
                    child: Card(
                      key: Key(e.id),
                      child: ListTile(
                        title: Text('${e.position}: $exerciseName'),
                        subtitle: Text('Reps:${e.numberOfSets}, last: $lastResultDateString'),
                        trailing: Icon(Icons.done_all_outlined),
                      ),
                    ),
                  ),
                );
              }).toList()),
        ));
  }
}
