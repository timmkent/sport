import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sport/firebase/fbservice.dart';
import 'package:flutter_sport/models/exercise.dart';
import 'package:flutter_sport/navi_routes.dart';
import 'package:provider/provider.dart';

import '../my_colors.dart';
import '../provider/category.dart';

class ExercisesList extends StatelessWidget {
  const ExercisesList({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = Provider.of<List<Exercise>>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise list'),
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
                key: Key(e.id),
                onLongPress: () => FirebaseDatabase.instance.ref().child('exercises').child(e.id).remove(),
                    title: Text(e.name),
                    subtitle: Text(e.id),
                    trailing:  Text(e.category),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
              //  keyboardType: TextInputType.phone,
                cursorColor: MyColors.primary,
                style: const TextStyle(color: MyColors.primary),
                decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: MyColors.primary,
                    )),
              ),
            ),
            Wrap(children: 
              Category.categories.map((e) {
                return InkWell(
                  onTap: (() => Provider.of<Category>(context, listen: false).setCategory(e)),
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Container(color: Provider.of<Category>(context, listen: true).currentCategory == e ? Colors.lightBlue : Colors.grey,child: Text(e),),
                  ),
                );
              }).toList()
            ,),
            ElevatedButton(
                onPressed: () {
                  final exercise = Exercise.createNew(name: nameController.text, category: Provider.of<Category>(context, listen: false).currentCategory);
                  fbService.saveExercise(exercise);
                  Navigator.of(context).pop();
                },
                child: const Text('SAVE'))
          ],
        ),
      ),
    );
  }
}
