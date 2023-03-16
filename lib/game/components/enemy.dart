
import 'package:bandit/game/util/game_layers.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Enemy extends SpriteComponent {

  static final Vector2 enemySize = Vector2(50, 50);
  
  Enemy({super.position}) : super(
    size: Enemy.enemySize, 
    priority: GameLayers.enemy.layer
  );

  @override
  Future<void> onLoad() async {
    
    final image = await Flame.images.load('./boxes/1.png');
    sprite = Sprite(image);

    add(RectangleHitbox());

    return super.onLoad();
  }

}