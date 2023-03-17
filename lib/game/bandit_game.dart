
import 'package:bandit/game/components/actors/enemy/enemy.dart';
import 'package:bandit/game/components/actors/player/player.dart';
import 'package:bandit/game/components/dasher/kill_line/kill_line_pool.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class BanditGame extends FlameGame with TapDetector, PanDetector, HasCollisionDetection {

  late final BanditPlayer player = BanditPlayer();
  late final KillLinePool killLinePool = KillLinePool();
  
  @override
  Future<void>? onLoad() async {

    add(ScreenHitbox()); // Adds a hitbox around the screen
    add(player); // Adds the player
    add(killLinePool); // Adds the player
    // add(Enemy(position: Vector2(300, 300))); // Adds an enemy

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
    pauseEngine(); // Pauses the game
  }
}