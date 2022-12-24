import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          // Exercises in this Routine
          Row(
            children: [TextButton(onPressed: () {}, child: Text('BKDR')), TextButton(onPressed: () {}, child: Text('BKDRS')), TextButton(onPressed: () {}, child: Text('BUT'))],
          ),

          // Table with Reps

          Table(
            columnWidths: {
              0: FixedColumnWidth(80),
              1: FixedColumnWidth(80),
              2: FixedColumnWidth(80),
              3: FixedColumnWidth(80),
            },
            children: [
              TableRow(children: [
                Text('Set No'),
                Text('Weight'),
                Text('Reps'),
                Text('Done'),
              ]),
              TableRow(children: [
                TextButton(onPressed: null, child: Text('1')),
                TextButton(onPressed: changeWeight, child: Text('88kg')),
                TextButton(onPressed: changeWeight, child: Text('10')),
                TextButton(onPressed: changeWeight, child: Text('Done')),
              ]),
              TableRow(children: [
                TextButton(onPressed: null, child: Text('2')),
                TextButton(onPressed: changeWeight, child: Text('88kg')),
                TextButton(onPressed: changeWeight, child: Text('10')),
                TextButton(onPressed: changeWeight, child: Text('Done')),
              ]),
            ],
          )
        ],
      )),
    );
  }

  void changeWeight() {
    print("chaning weight");
  }
}
