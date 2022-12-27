import 'package:flutter/material.dart';
import 'package:flutter_sport/my_colors.dart';

import '../navi_routes.dart';

const size = 100.0;


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
            menu(context, NaviRoutes.routines, "ROUTINES"),
            menu(context, NaviRoutes.doworkout, "DO WORKOUT"),
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
              Navigator.pushNamed(context, route);
            },
          )),
    );
  }
}