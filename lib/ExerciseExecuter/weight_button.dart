import 'package:flutter/material.dart';
import 'package:flutter_sport/ExerciseExecuter/set_info.dart';
import 'package:flutter_sport/ExerciseExecuter/weight_selector.dart';
import 'package:provider/provider.dart';

class WeightButton extends StatelessWidget {
  const WeightButton({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final weight = Provider.of<SetInfo>(context, listen: true).weights[index];
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return WeightSelectorScreen(index: index,);
        }));
      },
      child: Text('W:$weight'),
    );
  }
}
