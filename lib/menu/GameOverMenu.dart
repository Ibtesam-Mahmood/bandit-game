import 'package:bandit/blocs/score/score_bloc.dart';
import 'package:bandit/game/bandit_game.dart';
import 'package:bandit/util/components/SizedSpacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'GameMenu.dart';
import 'components/ElevatedButton.dart';

// This class represents the game over menu overlay.
class GameOverMenu extends StatelessWidget {
  static const String id = 'GameOverMenu';
  final BanditGame gameRef;

  const GameOverMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pause menu title.
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              'Game Over',
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 50.0,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.white,
                    offset: Offset(0, 0),
                  )
                ],
              ),
            ),
          ),

          // Restart button.
          CustomElevatedButton(
            label: 'Restart',
            onPressed: (){
              BlocProvider.of<ScoreBloc>(context).add(ResetScoreEvent());
              gameRef.overlays.remove(GameOverMenu.id);
              gameRef.reset();
              gameRef.resumeEngine();
            }
          ),

          SizedSpacer.vertical(20),

          CustomElevatedButton(
            label: 'Exit',
            onPressed: (){
              BlocProvider.of<ScoreBloc>(context).add(ResetScoreEvent());
              gameRef.overlays.remove(GameOverMenu.id);
              gameRef.reset();
              gameRef.stopBgmMusic();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const GameMenu(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}