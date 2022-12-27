import 'package:flutter/material.dart';
import 'package:flutter_sport/screens/select_exercise.dart';
import 'package:provider/provider.dart';
import '../provider/category.dart';

class SelectCategoryScreen extends StatelessWidget {
  const SelectCategoryScreen({super.key, required this.routineId, required this.newPosition});
  final String routineId;
  final int newPosition;

  @override
  Widget build(BuildContext context) {
    final selectedCategory = Provider.of<Category>(context).currentCategory;
    return Scaffold(
      appBar: AppBar(),
      body: Wrap(
          children: Category.categories.map((e) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (() {
              debugPrint("Calling filtered exercises....$e");
              Provider.of<Category>(context, listen: false).setCategory(e);
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                return SelectExerciseScreen(routineId: routineId, newPosition: newPosition);
              })));
            }),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Center(
                child: Text(e),
              ),
            ),
          ),
        );
      }).toList()),
    );
  }
}
