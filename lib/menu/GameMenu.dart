import 'package:bandit/blocs/score/score_bloc.dart';
import 'package:bandit/game/bandit_game_main.dart';
import 'package:bandit/menu/components/ElevatedButton.dart';
import 'package:bandit/util/components/SizedSpacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameMenu extends StatefulWidget {
  const GameMenu({super.key});

  @override
  State<GameMenu> createState() => _GameMenuState();
}

class _GameMenuState extends State<GameMenu> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage('assets/levels/level6.png')
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bandit Game',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 36.0,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 3.0,
                    color: Color(0xFF92ACC4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50.0),
            CustomElevatedButton(
              label: 'Start Game',
              onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<ScoreBloc>(context),
                      child: const BanditGameMain()
                    )
                  ),
                );
            }),
            SizedSpacer.vertical(20),
            CustomElevatedButton(
              label: 'Characters',
              onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<ScoreBloc>(context),
                      child: const BanditGameMain()
                    )
                  ),
                );
            }),
            SizedSpacer.vertical(20),
            CustomElevatedButton(
              label: 'Leaderboard',
              onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                   builder: (context) => BlocProvider.value(
                      value: BlocProvider.of<ScoreBloc>(context),
                      child: const BanditGameMain()
                    )
                  ),
                );
            }),
          ],
        ),
      ),
    );
  }
}