import 'package:flutter/material.dart';
import 'package:flutter_sport/screens/select_reps_for_exercise.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';
import '../provider/category.dart';

class SelectExerciseScreen extends StatelessWidget {
  const SelectExerciseScreen({super.key, required this.routineId, required this.newPosition});
  final String routineId;
  final int newPosition;

  // First select Categories

  @override
  Widget build(BuildContext context) {
    final allExercises = Provider.of<List<Exercise>>(context);
    final selectedCategory = Provider.of<Category>(context).currentCategory;
    final exercisesFiltered = allExercises.where(
      (element) => element.category == selectedCategory,
    );
    debugPrint('adding an exercise por sotition $newPosition');
    debugPrint('selectedCategory $selectedCategory');
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: exercisesFiltered
              .map((e) => InkWell(
                    onTap: () {
                      selectReps(context, e, routineId,newPosition);

                      //
                    },
                    child: ListTile(
                      title: Text(e.name),
                      subtitle: Text(e.id),
                      trailing: Text(e.category),
                    ),
                  ))
              .toList(),
        ),
      )),
    );
  }

  void selectReps(BuildContext context, Exercise e, String routineId, int position) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SelectRepsForExercise(
        exercise: e,
        routineId: routineId,
        position: position,
      );
    }));
  }
}
