import 'package:flutter/material.dart';
import 'package:flutter_sport/ExerciseExecuter/resp_button.dart';
import 'package:flutter_sport/ExerciseExecuter/set_info.dart';
import 'package:flutter_sport/ExerciseExecuter/weight_button.dart';
import 'package:provider/provider.dart';

class SetRow extends StatelessWidget {
  const SetRow({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final doneColor = Provider.of<SetInfo>(context, listen: true).isDone[index] ? Colors.green : Colors.grey;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text((index + 1).toString()),
        WeightButton(index: index),
        RepsButton(index: index),
        TextButton(
            onPressed: () {
              Provider.of<SetInfo>(context, listen: false).toggleIsDone(index);
            },
            child: Text(
              'done',
              style: TextStyle(color: doneColor),
            ))
      ],
    );
  }
}
