import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_sport/screens/exercises_list.dart';
import 'package:flutter_sport/firebase/fbservice.dart';
import 'package:flutter_sport/models/exercise.dart';
import 'package:flutter_sport/my_colors.dart';
import 'package:flutter_sport/navi_routes.dart';
import 'package:flutter_sport/screens/routines_list.dart';
import 'package:flutter_sport/screens/workout_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

const size = 100.0;

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
        StreamProvider<List<Exercise>>.value(value: FBService().observeExercises(), initialData: []),
        Provider<FBService>(
          create: (context) => FBService(),
        )
      ],
      child: MaterialApp(
        home: const MainMenu(), //const MyHomePage(title: 'Flutter Demo Home Page')),
        routes: {
          NaviRoutes.exercises: (context) => const ExercisesList(),
          NaviRoutes.addexercise: (context) => AddExercise(),
          NaviRoutes.routines: (context) => const RoutinesList(),
        },
      ),
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backGroundBlueLight,
      body: Center(
        child: Wrap(
          children: [
            menu(context, NaviRoutes.exercises, "EXERCISES"),
            menu(context, NaviRoutes.bodyAndNutrition, "ROUTINES"),
            menu(context, NaviRoutes.bodyAndNutrition, "WORKOUTS"),
          ],
        ),
      ),
    );
  }

  Widget menu(BuildContext context, String route, String title) {
    const style = TextStyle(color: Colors.yellow, fontSize: 20, fontWeight: FontWeight.w400);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: size,
          height: size,
          color: MyColors.backGroundBlueDark,
          child: TextButton(
            child: Text(title, style: style),
            onPressed: () {
              Navigator.pushNamed(context, NaviRoutes.routines);
            },
          )),
    );
  }
}
