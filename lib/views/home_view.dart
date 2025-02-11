import 'package:flutter/material.dart';

import '../models/game_arguments.dart';
import '../widgets/map_button.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Choisissez une difficulté :",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => (Navigator.pushNamed(context, '/game', arguments: GameArguments("easy"))),
                  child: Text("Easy"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => (Navigator.pushNamed(context, '/game', arguments: GameArguments("medium"))),
                  child: Text("Medium"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => (Navigator.pushNamed(context, '/game', arguments: GameArguments("hard"))),
                  child: Text("Hard"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
