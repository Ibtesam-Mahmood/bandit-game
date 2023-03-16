
import 'package:bandit/game/components/actors/enemy/enemy.dart';
import 'package:bandit/game/components/actors/player/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class BanditGame extends FlameGame with TapDetector, PanDetector, HasCollisionDetection {

  late final BanditPlayer player = BanditPlayer();
  
  @override
  Future<void>? onLoad() async {

    add(ScreenHitbox()); // Adds a hitbox around the screen
    add(player); // Adds the player
    add(Enemy(position: Vector2(300, 300))); // Adds an enemy

    return super.onLoad();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    super.onPanUpdate(info);

    player.prepareDash(info.eventPosition.global);
  }

  @override
  void onPanCancel() {
    super.onPanCancel();

    player.stopDash();
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