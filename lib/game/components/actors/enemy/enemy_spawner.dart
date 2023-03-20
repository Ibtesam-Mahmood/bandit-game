
import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:bandit/game/bandit_game.dart';
import 'package:bandit/game/components/actors/enemy/enemy.dart';
import 'package:bandit/game/components/actors/enemy/enemy_spawn_indicator.dart';
import 'package:flame/components.dart';

class EnemySpawer extends Component with HasGameRef<BanditGame> {

  static const int maxEnemies = 10;
  static const Duration spawnRate = Duration(milliseconds: 1000);

  int enemyCount = 0;
  bool spawning = false;
  
  void startSpawner(){
    spawning = true;
    _loop();
  }

  void stopSpawner(){
    spawning = false;
  }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   final Paint _paint = Paint()
  //   ..color = Colors.red.withOpacity(0.5)
  //   ..style = PaintingStyle.fill
  //   ..strokeWidth = 3;
  //   final screenSize = gameRef.camera.gameSize;
  //   // print(Rect.fromLTWH(
  //   //   screenSize.x * 0.1, 
  //   //   screenSize.y * 0.1, 
  //   //   screenSize.x * 0.8, 
  //   //   screenSize.y * 0.8
  //   // ));
  //   canvas.drawRect(Rect.fromLTWH(
  //     screenSize.x * 0.1, 
  //     screenSize.y * 0.1, 
  //     screenSize.x * 0.8, 
  //     screenSize.y * 0.8
  //   ), _paint);
  // }

  void spawn([bool loop = true]) async {
    if(!spawning) return;
    
    if(enemyCount < maxEnemies) {
      final r = Random();
      final screenSize = gameRef.camera.gameSize;
      final factor = Vector2((r.nextDouble() * 0.8) + 0.1, (r.nextDouble() * 0.8) + 0.1);
      final Vector2 pos = screenSize.clone()
        ..multiply(factor);
      final enemy = Enemy(position: pos);

      final indicator = EnemySpawnIndicator(enemy: enemy);
      add(indicator);
      indicator.fade();

      await indicator.completer.future;

      // Spawn the enemy
      add(enemy); 
      remove(indicator);
      enemyCount++;
    }

    _loop();
  }

  void despawn(Enemy enemy){
    try{
      remove(enemy);
      enemyCount--;
      gameRef.addToScore();
    }catch(e, s){
      dev.log('$e', stackTrace: s);
    }
  }

  void _loop([bool loop = false]) => Future.delayed(spawnRate, () => spawn(loop));
}