import 'package:flutter/material.dart';
import 'package:flutter_sport/ExerciseExecuter/set_info.dart';
import 'package:provider/provider.dart';

class RepsSelectorScreen extends StatelessWidget {
  const RepsSelectorScreen({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    void setNewValue(int newValue) {
      Provider.of<SetInfo>(context, listen: false).changeReps(newValue, index);
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
            children: [3, 4, 5, 6]
                .map((e) => ElevatedButton(
                    onPressed: () {
                      setNewValue(e);
                      Navigator.pop(context, e);
                    },
                    child: Text(e.toString())))
                .toList()),
      ),
    );
  }
}
