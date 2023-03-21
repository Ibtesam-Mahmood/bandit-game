
import 'dart:math';

import 'package:bandit/game/components/actors/base_actor.dart';
import 'package:bandit/game/components/actors/enemy/enemy_spawner.dart';
import 'package:bandit/game/components/actors/player/player.dart';
import 'package:bandit/game/components/dasher/can_dash_mixin.dart';
import 'package:bandit/game/util/game_layers.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Enemy extends SpriteComponent with CollisionCallbacks, BaseActor, CanDashActor {

  static final Vector2 enemySize = Vector2(50, 50);
  static const double enemySpeed = 400;

  @override
  double get initialDashRange => 400;

  @override
  double get dashReloadTime => 2;

  @override
  Duration get lineLife => const Duration(seconds: 2);

  @override
  BaseActorType get type => BaseActorType.enemy;

  late Vector2 velocity;
  
  Enemy({super.position}) : super(
    size: Enemy.enemySize, 
    priority: GameLayers.enemy.layer
  );

  late final hb = RectangleHitbox();

  @override
  Future<void> onLoad() async {
    
    final image = await Flame.images.load('./boxes/1.png');
    sprite = Sprite(image);

    range.reload();

    add(hb);

    setVelocity(); // Randomly sets the velocity of the enemy

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

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
    else if(other is BanditPlayer){
      other.damage();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.add(velocity * dt);
  }

  @override
  void onDeath() {
    super.onDeath();
    spawner.despawn(this);
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


  EnemySpawer get spawner {
    assert(parent is EnemySpawer, 'Enemy must be added to a EnemySpawer');
    return parent as EnemySpawer;
  }

  @override 
  void onDetect(BaseActor other) {
    super.onDetect(other);
    if(other.type == BaseActorType.player){
      prepareDash(other.center);
      dash();
    }
  }
}