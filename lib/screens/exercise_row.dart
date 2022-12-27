import 'package:flutter/material.dart';
import 'package:flutter_sport/ExerciseExecuter/set_info.dart';
import 'package:flutter_sport/provider/pausen_timer.dart';
import 'package:flutter_sport/screens/select_reps.dart';
import 'package:flutter_sport/screens/select_weight.dart';
import 'package:provider/provider.dart';


class ExerciseSetRow extends StatefulWidget {
  const ExerciseSetRow({super.key, required this.setNumber, required this.weight, required this.reps, required this.done, required this.setResultId, required this.exerciseId});
  final String setResultId;
  final int setNumber;
  final double weight;
  final int reps;
  final bool done;
  final String exerciseId;

  @override
  State<ExerciseSetRow> createState() => _ExerciseSetRowState();
}

class _ExerciseSetRowState extends State<ExerciseSetRow> {
  late double weight;
  late int reps;
  late bool done;
  late String exerciseId;

  @override
  void initState() {
    super.initState();
    weight = widget.weight;
    reps = widget.reps;
    done = widget.done;
    exerciseId = widget.exerciseId;
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(80),
        1: FixedColumnWidth(80),
        2: FixedColumnWidth(80),
        3: FixedColumnWidth(80),
      },
      children: [
        TableRow(children: [
          Text(widget.setNumber.toString()),
          InkWell(
              onTap: (() {
                Navigator.of(context).push(MaterialPageRoute<double>(builder: (context) {
                  return const SelectWeight();
                })).then((value) {
                  if (mounted) {
                    setState(() {
                      weight = value!;
                    });
                  }
                });
              }),
              child: Text(weight.toString())),

          InkWell(
              onTap: (() {
                Navigator.of(context).push(MaterialPageRoute<int>(builder: (context) {
                  return const SelectReps();
                })).then((value) {
                  if (mounted) {
                    setState(() {
                      reps = value!;
                    });
                  }
                });
              }),
              child: Text(reps.toString())),

          //    Text(widget.reps.toString()),
          TextButton(
              onPressed: () => saveSet(),
              child: Text(
                'done',
                style: TextStyle(color: done ? Colors.green : Colors.grey),
              )),
        ]),
      ],
    );
  }

// Test that timer gets started
  saveSet() {
    //if (done == true) return;
    Provider.of<BasePausenTimer>(context, listen: false).startCountdown(100);

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    Provider.of<BaseSetInfo>(context, listen: false).saveAsDone(widget.setResultId, widget.setNumber, reps, weight, timestamp, exerciseId);
    setState(() {
      done = true;
    });
  }
}
