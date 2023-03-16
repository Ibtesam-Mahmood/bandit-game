import 'package:bandit/game/components/enemy.dart';
import 'package:bandit/game/components/player.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class BanditGame extends FlameGame with TapDetector, HasCollisionDetection {

  late final BanditPlayer player = BanditPlayer();
  
  @override
  Future<void>? onLoad() async {

    add(ScreenHitbox()); // Adds a hitbox around the screen
    add(player); // Adds the player
    add(Enemy(position: Vector2(300, 300))); // Adds an enemy

    return super.onLoad();
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);

    player.moveTo(info.eventPosition.global);
  }

  void gameover(){
    pauseEngine(); // Pauses the game
  }
}