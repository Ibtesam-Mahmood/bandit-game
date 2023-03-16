import 'package:bandit/game/bandit_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bandit Game',
      home: Scaffold(
        body: GameWidget(game: BanditGame(),)
      ),
    );
  }
}