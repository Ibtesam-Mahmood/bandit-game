
import 'dart:math';

import 'package:bandit/game/util/game_layers.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Enemy extends SpriteComponent with CollisionCallbacks {

  static final Vector2 enemySize = Vector2(50, 50);
  static const double enemySpeed = 400;

  late Vector2 velocity;
  
  Enemy({super.position}) : super(
    size: Enemy.enemySize, 
    priority: GameLayers.enemy.layer
  );

  @override
  Future<void> onLoad() async {
    
    final image = await Flame.images.load('./boxes/1.png');
    sprite = Sprite(image);

    add(RectangleHitbox());

    setVelocity(); // Randomly sets the velocity of the enemy

    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if(other is ScreenHitbox){
      // Reserve the velocity based on the wall that was hit
      final screenSize = other.size;
      final point = intersectionPoints.first;
      double velX = velocity.x;
      double velY = velocity.y;
      
      if(point.x == 0 || point.x == screenSize.x) velX *= -1;
      if(point.y == 0 || point.y == screenSize.y) velY *= -1;

      setVelocity(Vector2(velX, velY));
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.add(velocity * dt);
  }

  void setVelocity([Vector2? direction]) {

    if(direction == null) {
      Random r = Random();
      int neg1 = r.nextInt(2) == 0 ? -1 : 1;
      int neg2 = r.nextInt(2) == 0 ? -1 : 1;
      direction = Vector2(neg1 * r.nextDouble(), neg2 * r.nextDouble());
    }

    velocity = direction.normalized() * Enemy.enemySpeed;
  }

}