import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_sport/ExerciseExecuter/sets_list_screen.dart';
import 'package:flutter_sport/provider/category.dart';
import 'package:flutter_sport/provider/pausen_timer.dart';
import 'package:flutter_sport/screens/exercises_list.dart';
import 'package:flutter_sport/firebase/fbservice.dart';
import 'package:flutter_sport/models/exercise.dart';
import 'package:flutter_sport/navi_routes.dart';
import 'package:flutter_sport/screens/main_menu_screen.dart';
import 'package:flutter_sport/screens/routines_list.dart';
import 'package:provider/provider.dart';
import 'ExerciseExecuter/set_info.dart';
import 'firebase_options.dart';
import 'models/routine.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseSetInfo>(create: ((context) => SetInfo())),
        ChangeNotifierProvider(create: ((context) => Category())),
        ChangeNotifierProvider<BasePausenTimer>(create: ((context) => PausenTimer())),

        StreamProvider<List<Exercise>>.value(value: FBService().observeExercises(), initialData: const []),
        StreamProvider<List<Routine>>.value(value: FBService().observeRoutines(), initialData: const []),
        Provider<FBService>(
          create: (context) => FBService(),
        ),
        //  ChangeNotifierProvider<Exercise>.value(value: SelectedExercise(),initialData: )
      ],
      child: MaterialApp(
        home: const MainMenu(), //const MyHomePage(title: 'Flutter Demo Home Page')),
        routes: {
          NaviRoutes.exercises: (context) => const ExercisesList(),
          NaviRoutes.addexercise: (context) => AddExercise(),
          NaviRoutes.routines: (context) => const RoutinesList(),
          NaviRoutes.addroutine: (context) => AddRoutine(),
          NaviRoutes.doworkout: (context) => const SetsListScreen(),
          //    NaviRoutes.selectExercise: (context) =>  const SelectExerciseScreen(),
        },
      ),
    );
  }
}






