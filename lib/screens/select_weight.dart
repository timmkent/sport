import 'package:flutter/material.dart';

class SelectWeight extends StatelessWidget {
  const SelectWeight({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
            children: [60.0,61.0,62.0,63.0,64.0,65.0,66.0]
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
