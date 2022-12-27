import 'package:flutter/material.dart';

class SelectReps extends StatelessWidget {
  const SelectReps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
            children: [6,7,8,9,10,11,12,13,14,15]
                .map((e) => ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, e);
                    },
                    child: Text(e.toString())))
                .toList()),
      ),
    );
  }
}
