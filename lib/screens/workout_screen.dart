import 'package:flutter/material.dart';
import 'package:flutter_sport/models/set_result.dart';
import 'package:flutter_sport/provider/pausen_timer.dart';
import 'package:provider/provider.dart';
import '../ExerciseExecuter/set_info.dart';
import 'package:uuid/uuid.dart';
import '../models/exercise.dart';
import 'exercise_row.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key, required this.routineId, required this.exercise, required this.numberOfSets});
  final String routineId;
  final Exercise exercise;
  final int numberOfSets;

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  SetResult? setResult;

  // create a new SetPlate or find an existing one
  @override
  void initState() {
    super.initState();
  }

  SetResult createDefaultSetPlate() {
    final id = const Uuid().v1();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final setResult = SetResult(id: id, timestamp: timestamp, exerciseId: widget.exercise.id);
    // Todo save this
    return setResult;
  }

// Eine Session (SetResult) muss an einem Tag abgeschlossen werden.
  @override
  Widget build(BuildContext context) {
    // get all setResults
    final allSetResults = Provider.of<BaseSetInfo>(context, listen: true).setResults;
    // get all setResults for this exercise
    final setResultsForThisExercise = allSetResults.where((element) => element.exerciseId == widget.exercise.id).toList();
    // get all for this exercise that we did today
    final setResultToday = setResultsForThisExercise.where((element) => element.timestamp > DateTime.now().millisecondsSinceEpoch - 86000 * 1000).toList();
    final allResults = Provider.of<BaseSetInfo>(context, listen: true).results;

    //final setResult = createDefaultSetPlate();
    // Wenn fuer heute keine Session besteht, erstellen wir eine neue

// Ein SetResult ist ein pro Exercise ausgefuehrte Sets

    var children = <Widget>[];
    children.add(Text("Exercise: ${widget.exercise.name}"));

    // final allResultsForThisSetResult = allResults.where((element) => element.setResultId == setResultToday.id).toList();
    // fuege die results hinzu,fuelle den rest mit empty auf

    if (setResultToday.isNotEmpty) {
      children.add(const Text("active session found"));
      final setResultForThisExercise = setResultsForThisExercise.first;
      final id = setResultForThisExercise.id;
      // Sobal ein SetResult angelegt wurde, muessten wir hier landen.
      // Suche durchgefuehrte Exercises und fuhge leere Rows for noch nicht ausgefuerhte an.
      // final exercisesDoneInThisSession = allResults.where((element) => element.exerciseId)

      final setsCompleted = allResults.where((element) => element.setResultId == id).toList();
      // Fall: heute schon angelegt, aber noch keine uebungen vorhanden.

      children.add(Text("sets completed ${setsCompleted.length.toString()}"));

      // add completed sets to array
      var setNumber = 0;
      for (var completed in setsCompleted) {
        children.add(ExerciseSetRow(
          setNumber: setNumber + 1,
          weight: completed.weight,
          reps: completed.reps,
          done: true,
          setResultId: id,
          exerciseId: completed.exerciseId,
        ));
        setNumber++;
      }

      // fill out the rest with 0.0 until we reach nmberOfSets

      for (var i = setNumber; i < widget.numberOfSets; i++) {
        children.add(ExerciseSetRow(
          setNumber: i + 1,
          weight: 0.0,
          reps: 10,
          done: false,
          setResultId: id,
          exerciseId: widget.exercise.id,
        ));
      }

      // if (setResult != null) {
      //   for (var result in setResult!.results) {
      //     children.add(ExerciseSetRow(
      //       setNumber: result.index,
      //       weight: result.weight,
      //       reps: result.reps,
      //       done: false,
      //       setResultId: setResult!.id,
      //     ));
      //   }
    } else {
      children.add(TextButton(
          onPressed: () {
            final timestamp = DateTime.now().millisecondsSinceEpoch;
            final setResult = createDefaultSetPlate();
            Provider.of<SetInfo>(context, listen: false).saveNewSetResult(setResult.id, setResult.exerciseId, timestamp);
          },
          child: const Text("Add SetDefaultResult")));
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [...children, const PausenTimerWidget()],
      )),
    );
  }

  void changeWeight() {
    debugPrint("chaning weight");
  }
}

class PausenTimerWidget extends StatelessWidget {
  const PausenTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final remainingSeconds = Provider.of<BasePausenTimer>(context, listen: true).remainingSeconds;
    return Text(remainingSeconds.toString(),style: const TextStyle(fontSize: 20),);
  }
}
