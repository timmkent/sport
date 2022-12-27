import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/routine.dart';
import '../navi_routes.dart';

class DoWorkoutScreen extends StatelessWidget {
  const DoWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routines = Provider.of<List<Routine>>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NaviRoutes.addroutine);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: routines
              .map((e) => InkWell(
                    onTap: () {
                  //    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WorkoutScreen(routineId: e.id)));
                    },
                    child: ListTile(
                      title: Text(e.name),
                      subtitle: Text(e.id),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
