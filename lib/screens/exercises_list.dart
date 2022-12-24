import 'package:flutter/material.dart';
import 'package:flutter_sport/firebase/fbservice.dart';
import 'package:flutter_sport/models/exercise.dart';
import 'package:flutter_sport/navi_routes.dart';
import 'package:provider/provider.dart';

import '../my_colors.dart';

class ExercisesList extends StatelessWidget {
  const ExercisesList({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = Provider.of<List<Exercise>>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NaviRoutes.addexercise);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: exercises
              .map((e) => ListTile(
                    title: Text(e.name),
                    subtitle: Text(e.id),
                    trailing: Text(e.tags.toString()),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class AddExercise extends StatelessWidget {
  AddExercise({super.key});
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final fbService = Provider.of<FBService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.phone,
              cursorColor: MyColors.primary,
              style: const TextStyle(color: MyColors.primary),
              decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: const TextStyle(
                    color: MyColors.primary,
                  )),
            ),
            ElevatedButton(
                onPressed: () {
                  final exercise = Exercise.createNew(name: nameController.text, tags: ['first']);
                  fbService.saveExercise(exercise);
                  Navigator.of(context).pop();
                },
                child: Text('SAVE'))
          ],
        ),
      ),
    );
  }
}
