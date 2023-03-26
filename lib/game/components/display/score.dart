import 'package:bandit/blocs/score/score_bloc.dart';
import 'package:bandit/game/bandit_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocBuilder<ScoreBloc, ScoreState>(
          builder: (context, state) {
            return SafeArea(
              top: true,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    const Text("Score: ", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white, decoration: TextDecoration.none)),
                    Text(state.score.toString(), style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white, decoration: TextDecoration.none)),
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
}