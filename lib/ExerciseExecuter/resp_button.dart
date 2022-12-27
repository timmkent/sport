import 'package:flutter/material.dart';
import 'package:flutter_sport/ExerciseExecuter/reps_selector.dart';
import 'package:flutter_sport/ExerciseExecuter/set_info.dart';
import 'package:provider/provider.dart';

class RepsButton extends StatelessWidget {
  const RepsButton({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<SetInfo>(context, listen: true).reps[index];
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return RepsSelectorScreen(index: index,);
        }));
      },
      child: Text('R:$value'),
    );
  }
}
