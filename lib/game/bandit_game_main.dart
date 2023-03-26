import 'package:bandit/blocs/score/score_bloc.dart';
import 'package:bandit/game/bandit_game.dart';
import 'package:bandit/game/components/display/score.dart';
import 'package:bandit/menu/GameOverMenu.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BanditGameMain extends StatelessWidget {
  const BanditGameMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget(
          game: BanditGame(scoreBloc: BlocProvider.of<ScoreBloc>(context)),
          overlayBuilderMap: {
            'DashboardOverlay': (BuildContext context, BanditGame game) {
              return const Dashboard();
            },
            GameOverMenu.id: (BuildContext context, BanditGame game) {
              return GameOverMenu(gameRef: game);
            }
          },
        ),
      ],
    );
  }
}