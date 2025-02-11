import 'package:demineur/viewmodels/game_view_model.dart';
import 'package:demineur/views/game_view.dart';
import 'package:demineur/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => GameViewModel(),
        child: MaterialApp(
          title: 'Démineur',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, secondary: Colors.red),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => HomeView(),
            '/game' : (context) => GameView(),
            '/won' : (context) => Scaffold(body: Center(child: Text("Vous avez gagné !"))),
            '/lost' : (context) => Scaffold(body: Center(child: Text("Vous avez perdu !"))),
          },
        ),
    );
  }
}
