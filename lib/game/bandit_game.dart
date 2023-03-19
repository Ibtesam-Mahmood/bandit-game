
import 'package:bandit/game/components/actors/enemy/enemy.dart';
import 'package:bandit/game/components/actors/enemy/enemy_spawner.dart';
import 'package:bandit/game/components/actors/player/player.dart';
import 'package:bandit/game/components/dasher/kill_line/kill_line_pool.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class BanditGame extends FlameGame with TapDetector, PanDetector, HasCollisionDetection {

  late final BanditPlayer player = BanditPlayer();
  late final EnemySpawer enemySpawner = EnemySpawer();
  late final ScreenHitbox screen = ScreenHitbox();
  int score = 0;
  
  @override
  Future<void>? onLoad() async {

    add(screen); // Adds a hitbox around the screen
    add(player); // Adds the player
    add(enemySpawner); // Adds the spawner

    // Start the spawner
    enemySpawner.startSpawner();

    return super.onLoad();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    super.onPanUpdate(info);

    player.prepareDash(info.eventPosition.global);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    super.onPanEnd(info);

    player.dash();
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);

    player.prepareDash(info.eventPosition.global);
  }

  @override
  void onTapCancel() {
    super.onTapCancel();

    player.stopDash();
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);

    player.dash();
  }

  void gameover(){
    enemySpawner.stopSpawner(); // Stops the spawner
    pauseEngine(); // Pauses the game
  }

  void addToScore([int amount = 1]){
    score += amount;
    print('Score: $score');
  }
}