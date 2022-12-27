import 'package:flutter/material.dart';
import 'package:flutter_sport/screens/manage_routine.dart';
import 'package:provider/provider.dart';
import '../firebase/fbservice.dart';
import '../models/routine.dart';
import '../my_colors.dart';
import '../navi_routes.dart';

class RoutinesList extends StatelessWidget {
  const RoutinesList({super.key});

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
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => RoutineManager(routineId: e.id)));
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

class AddRoutine extends StatelessWidget {
  AddRoutine({super.key});
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
                  labelText: 'Routine-Name',
                  labelStyle: TextStyle(
                    color: MyColors.primary,
                  )),
            ),

            // List of exercises of which this routine comprises

            // Table(
            //   columnWidths: {0: FixedColumnWidth(180), 1: FixedColumnWidth(80)},
            //   children: [
            //     TableRow(
            //       children: [
            //         Text('Exercise Name'),
            //         Text('No Sets'),
            //       ],
            //     )
            //   ],
            // ),

            // Row(
            //   children: [
            //     Spacer(),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: SizedBox(
            //         width: 100,
            //         height: 30,
            //         child: ElevatedButton(
            //             onPressed: () {
            //               // final exercise = Routine.createNew(name: nameController.text, tags: ['first']);
            //               // fbService.saveExercise(exercise);
            //               Navigator.of(context).pushNamed(NaviRoutes.selectExercise);
            //             },
            //             child: Text(
            //               'Add Exercise',
            //               style: TextStyle(fontSize: 10),
            //             )),
            //       ),
            //     ),
            //   ],
            // ),

            // Save routine
            ElevatedButton(
                onPressed: () {
                  fbService.createNewRoutine(nameController.text);
                  Navigator.of(context).pop();
                },
                child: Text('SAVE'))
          ],
        ),
      ),
    );
  }
}
