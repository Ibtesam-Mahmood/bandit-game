import 'package:bandit/blocs/score/score_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'menu/GameMenu.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ScoreBloc>(
        create: (context) => ScoreBloc(),
      ),

    ],
    child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bandit Game',
      home: Scaffold(
          body: GameMenu()
        ),
    );
  }
}